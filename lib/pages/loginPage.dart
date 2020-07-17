import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:focus_widget/focus_widget.dart';
import 'package:getflutter/getflutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/login.dart';
import 'package:quit_smoke/enums/var.dart';
import 'package:quit_smoke/pages/homePage.dart';
import 'package:quit_smoke/pages/signupPage.dart';
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
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onPop(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.green,
          leading: Icon(Icons.supervisor_account),
          title: Text(
            'Connect with email',
            style: GoogleFonts.roboto(
              fontSize: 4.5 * wm,
              fontWeight: FontWeight.w400,
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
                  child: TextFormField(
                    cursorColor: _isEmailValid ? Colors.black : Colors.red,
                    autocorrect: false,
                    enableInteractiveSelection: true,
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
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      suffixIcon: _isEmailValid ? null : Icon(Icons.error, color: Colors.red),
                      errorText: _isEmailValid ? null : 'Field is required',
                      labelText: "Email:",
                    ),
                  ),
                ),
                SizedBox(height: 3 * wm),
                FocusWidget(
                  focusNode: _passwordFocus,
                  child: TextFormField(
                    autocorrect: false,
                    cursorColor: _isPassValid ? Colors.black : Colors.red,
                    obscureText: _obscureText,
                    controller: _passwordController,
                    focusNode: _passwordFocus,
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
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        color: _obscureText ? Colors.grey : Colors.green,
                        onPressed: () {
                          setState(() => _obscureText = !_obscureText);
                        },
                      ),
                      errorText: _isPassValid ? null : 'Field is required',
                      labelText: "Password:",
                    ),
                  ),
                ),
                SizedBox(height: 5 * wm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlatButton(
                      padding: EdgeInsets.symmetric(horizontal: wm),
                      child: Text("Create new account"),
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
                        color: Colors.green,
                        type: GFButtonType.solid,
                        shape: GFButtonShape.pills,
                        size: GFSize.MEDIUM,
                        text: 'Log in',
                        textStyle: GoogleFonts.roboto(
                          fontSize: 4 * wm,
                        ),
                        onPressed: () async {
                          var connectionState = await (Connectivity().checkConnectivity());

                          if (connectionState == ConnectivityResult.none) {
                            //
                            _showToast("Please connect to internet");
                            //
                          } else if (_passwordController.text.isEmpty ||
                              _emailController.text.isEmpty) {
                            _showToast("Please enter login details");
                          } else {
                            Login.signInWithEmail(
                              email: _emailController,
                              password: _passwordController,
                              context: context,
                            ).then((value) => currentUser = value);
                            // _passwordController.clear();
                            Login.checkLogin(currentUser).then((value) {
                              if (value) {
                                //
                                _showToast("Login success");
                                //
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ),
                                );
                              } else if (value == false) {
                                //
                                _showToast("Login failed :(");
                                //
                              } else {
                                _showToast("Something's fucked up. idk what !!");
                              }
                            });
                          }
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
      duration: Toast.LENGTH_LONG,
      gravity: Toast.BOTTOM,
      backgroundRadius: 5,
    );
  }

  Future<bool> _onPop() async {
    //
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Toast.show(
        'Press back again to exit',
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundRadius: 5,
      );
      return false;
      //
    }
    exit(0);
    return true;
  }
}
