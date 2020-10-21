library login;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  Login({@required this.loggedIn, @required this.loggedOut});

  static Function callback;

  final Widget loggedIn;
  final Widget loggedOut;

  static FirebaseUser currentUser;
  static bool isLoggedIn = false;

  static final FocusNode _emailFocus = FocusNode();
  static final FocusNode _passwordFocus = FocusNode();

  static final TextEditingController _emailController = TextEditingController();
  static final TextEditingController _passwordController = TextEditingController();

  static final Widget email = TextField(
      controller: _emailController,
      focusNode: _emailFocus,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        _passwordFocus.requestFocus();
      },
      decoration: InputDecoration(labelText: "Email"));

  static final Widget password = TextField(
      controller: _passwordController,
      focusNode: _passwordFocus,
      obscureText: true,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(labelText: "Password"));

  static void clearPassword() => _passwordController.clear();

  static void clearEmail() => _emailController.clear();

  static String get _passwordText {
    final String _passwordText = _passwordController.text;
    _passwordController.clear();

    return _passwordText;
  }

  static Future<bool> checkLogin(FirebaseUser user) async {
    try {
      clearEmail();
      clearPassword();

      currentUser = await FirebaseAuth.instance.currentUser();
      // assert(user.email != null);
      // assert(user.displayName != null);
      // assert(!user.isAnonymous);
      // assert(await user.getIdToken() != null);
      // assert(user.uid == currentUser.uid);
    } catch (e) {
      debugPrint("error: $e");
      debugPrint("Failure logging in.");
      return false;
    }

    return true;
  }

  // custom function
  static void initUser() {
    try {
      FirebaseAuth.instance.onAuthStateChanged.listen((FirebaseUser firebaseUser) {
        // setState(() {
        currentUser = firebaseUser;
        isLoggedIn = firebaseUser != null;
        // if (callback != null) callback(context, firebaseUser);
        // });
      });
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  static Future<FirebaseUser> signUpWithEmail(
      {@required TextEditingController email,
      @required TextEditingController password,
      @required TextEditingController displayName,
      BuildContext context}) async {
    final String _email = email.text.trim();
    final String _password = password.text;
    final String _name = displayName.text;

    AuthResult authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _email,
      password: _password,
    );

    try {
      final FirebaseUser _user = authResult.user;
      final userInfo = UserUpdateInfo();

      userInfo.displayName = _name;
      await _user.updateProfile(userInfo);
      await _user.reload();

      currentUser = _user;

      await _user.sendEmailVerification();
      return _user;
    } catch (e) {
      debugPrint("Error creating user.");
      return null;
    }
  }

  static Future<void> resetPassword({BuildContext context}) async {
    if (_emailController.text.isEmpty) return null;

    if (context != null)
      showSnackbar(
        msg:
            "If an account with that email exists, you will receive a password reset link shortly.",
        context: context,
      );

    await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
  }

  static Future<FirebaseUser> signInWithEmail(
      {@required TextEditingController email,
      @required TextEditingController password,
      BuildContext context}) async {
    try {
      final String _email = email.text.trim();
      final String _password = password.text;

      final AuthResult result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
      final FirebaseUser user = result.user;

      await checkLogin(user);
      currentUser = user;

      return user;
    } catch (e) {
      debugPrint("Error: $e");

      if (context == null) return null;
      error(context: context);
      return null;
    }
  }

  static Future<FirebaseUser> signInWithGoogle({BuildContext context}) async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final FirebaseUser user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;

      await checkLogin(user);

      return user;
    } catch (e) {
      debugPrint("Error: $e");
      return error(context: context);
    }
  }

  static signOut() {
    FirebaseAuth.instance.signOut();
    currentUser = null;
  }

  static Future error(
      {String msg = "Login failed. Please try again.", @required BuildContext context}) {
    return showSnackbar(msg: msg, context: context);
  }

  static Future showSnackbar({@required BuildContext context, String msg, SnackBar snackBar}) {
    Scaffold.of(context).showSnackBar(snackBar == null ? SnackBar(content: Text(msg)) : snackBar);
    return null;
  }

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _instance = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    try {
      _instance.onAuthStateChanged.listen((FirebaseUser firebaseUser) {
        setState(() {
          Login.currentUser = firebaseUser;
          Login.isLoggedIn = firebaseUser != null;
          if (Login.callback != null) Login.callback(context, firebaseUser);
        });
      });
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Login.isLoggedIn ? widget.loggedIn : widget.loggedOut;
  }
}

class GoogleSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      child: RaisedButton(
        elevation: 8,
        splashColor: Colors.grey,
        color: Colors.white,
        onPressed: Login.signInWithGoogle,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage("assets/google.png", package: "login"), height: 18),
              Container(
                width: 24.0,
              ),
              Text(
                'SIGN IN WITH GOOGLE',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
