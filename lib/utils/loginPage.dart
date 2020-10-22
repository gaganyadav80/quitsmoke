import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:focus_widget/focus_widget.dart';
import 'package:getwidget/getwidget.dart';
import 'package:quit_smoke/enums/var.dart';
import 'package:quit_smoke/packages/login.dart';
import 'package:quit_smoke/pages/home.dart';
import 'package:quit_smoke/utils/signupPage.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  DateTime currentBackPressTime;
  bool _obscureText = true;
  bool _isEmailValid = true;
  bool _isPassValid = true;

  @override
  void dispose() {
    _emailController?.dispose();
    _passwordController?.dispose();
    _emailFocus?.dispose();
    _passwordFocus?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onPop(),
      child: Scaffold(
        backgroundColor: body,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: appBar,
          leading: Icon(Icons.supervisor_account, color: Colors.white),
          title: Text(
            'Connect with email',
            style: TextStyle(
              fontSize: 4.5 * wm,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5 * wm),
            child: Column(
              children: [
                SizedBox(height: 10 * wm),
                FocusWidget(
                  focusNode: _emailFocus,
                  onLostFocus: (widget, focusNode) {
                    setState(() => _isEmailValid = true);
                  },
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    cursorColor: _isEmailValid ? darkGreen : Colors.red[400],
                    autocorrect: false,
                    enableInteractiveSelection: true,
                    enableSuggestions: true,
                    controller: _emailController,
                    focusNode: _emailFocus,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      _passwordFocus.requestFocus();
                    },
                    onChanged: (value) {
                      if (value.isEmpty) {
                        setState(() => _isEmailValid = false);
                      } else {
                        setState(() => _isEmailValid = true);
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: darkGreen),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red[400]),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[600]),
                      ),
                      suffixIcon: _isEmailValid ? null : Icon(Icons.error, color: Colors.red[400]),
                      errorText: _isEmailValid ? null : 'Field is required',
                      errorStyle: TextStyle(color: Colors.red[400]),
                      labelText: "Email:",
                      labelStyle: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                ),
                SizedBox(height: 3 * wm),
                FocusWidget(
                  focusNode: _passwordFocus,
                  onLostFocus: (widget, focusNode) {
                    setState(() => _isPassValid = true);
                  },
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    autocorrect: false,
                    cursorColor: _isPassValid ? darkGreen : Colors.red[400],
                    obscureText: _obscureText,
                    controller: _passwordController,
                    focusNode: _passwordFocus,
                    enableInteractiveSelection: true,
                    enableSuggestions: false,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        setState(() => _isPassValid = false);
                      } else {
                        setState(() => _isPassValid = true);
                      }
                    },
                    decoration: InputDecoration(
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red[400]),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[600]),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: darkGreen),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: _obscureText ? Colors.grey[600] : darkGreen,
                        ),
                        color: _obscureText ? Colors.grey : darkGreen,
                        onPressed: () {
                          setState(() => _obscureText = !_obscureText);
                        },
                      ),
                      errorText: _isPassValid ? null : 'Field is required',
                      errorStyle: TextStyle(
                        color: Colors.red[400],
                      ),
                      labelText: "Password:",
                      labelStyle: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                ),
                SizedBox(height: 5 * wm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlatButton(
                      padding: EdgeInsets.symmetric(horizontal: wm),
                      child: Text(
                        "Create new account",
                        style: TextStyle(
                          color: darkGreen,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupPage(),
                          ),
                        );
                      },
                    ),
                    Container(
                      width: 25 * wm,
                      height: 9.5 * wm,
                      child: GFButton(
                        elevation: 5,
                        color: darkGreen,
                        type: GFButtonType.solid,
                        shape: GFButtonShape.pills,
                        size: GFSize.MEDIUM,
                        text: 'Log in',
                        textStyle: TextStyle(
                          fontSize: 4 * wm,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          var connectionState = await (Connectivity().checkConnectivity());

                          if (connectionState == ConnectivityResult.none) {
                            //
                            _showToast("Please connect to internet");
                            //
                          } else if (_passwordController.text.isEmpty || _emailController.text.isEmpty) {
                            _showToast("Please enter login details");
                          } else {
                            Login.signInWithEmail(
                              email: _emailController,
                              password: _passwordController,
                              context: context,
                            );

                            setReference();
                            // collectionName = "${Login.currentUser.email}";
                            // debugPrint("COLLECTION : $collectionName");
                            // DocRef.userRef = FirebaseFirestore.instance.collection("$collectionName");

                            // ! WORKING
                            // Login.checkLogin(Login.currentUser).then((value) {
                            //   if (value) {
                            //     setReference();
                            //     _showToast("Login success");
                            //   } else if (value == false) {
                            //     _showToast("Login failed :(");
                            //   } else {
                            //     _showToast("Something's fucked up. idk what !!");
                            //   }
                            // });
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showToast(String msg) {
    Toast.show(
      msg,
      context,
      duration: 3,
      gravity: Toast.BOTTOM,
      backgroundRadius: 5,
      backgroundColor: appBar,
    );
  }

  Future<bool> _onPop() async {
    if (MediaQuery.of(context).viewInsets.bottom != 0) {
      return false;
    }
    return true;
  }
}
