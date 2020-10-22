import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:focus_widget/focus_widget.dart';
import 'package:getwidget/getwidget.dart';
import 'package:quit_smoke/enums/var.dart';
import 'package:quit_smoke/packages/login.dart';
import 'package:quit_smoke/utils/getSmokeData.dart';
import 'package:toast/toast.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _rePasswordFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  bool _obscureText = true;
  bool _isEmailValid = true;
  bool _isPassValid = true;
  bool _isRePassValid = true;

  @override
  void dispose() {
    _emailController?.dispose();
    _passwordController?.dispose();
    _rePasswordController?.dispose();
    _nameController?.dispose();

    _nameFocus?.dispose();
    _emailFocus?.dispose();
    _passwordFocus?.dispose();
    _rePasswordFocus?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onPop(),
      child: Scaffold(
        backgroundColor: body,
        appBar: AppBar(
          backgroundColor: appBar,
          title: Text('Signup Page', style: TextStyle(color: Colors.white)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5 * wm),
            child: Column(
              children: [
                SizedBox(height: 10 * wm),
                FocusWidget(
                  focusNode: _nameFocus,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    cursorColor: darkGreen,
                    autocorrect: false,
                    enableInteractiveSelection: true,
                    enableSuggestions: true,
                    controller: _nameController,
                    focusNode: _nameFocus,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      _emailFocus.requestFocus();
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: darkGreen),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[600]),
                      ),
                      labelText: "Name:",
                      labelStyle: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                ),
                SizedBox(height: 3 * wm),
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
                    textInputAction: TextInputAction.next,
                    enableInteractiveSelection: true,
                    enableSuggestions: false,
                    onEditingComplete: () {
                      _rePasswordFocus.requestFocus();
                    },
                    onChanged: (value) {
                      if (value.isEmpty) {
                        setState(() => _isPassValid = false);
                      } else {
                        setState(() => _isPassValid = true);
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
                      suffixIcon: IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        color: _obscureText ? Colors.grey[600] : darkGreen,
                        onPressed: () {
                          setState(() => _obscureText = !_obscureText);
                        },
                      ),
                      errorText: _isPassValid ? null : 'Field is required',
                      errorStyle: TextStyle(color: Colors.red[400]),
                      labelText: "Password:",
                      labelStyle: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                ),
                SizedBox(height: 3 * wm),
                FocusWidget(
                  focusNode: _rePasswordFocus,
                  onLostFocus: (widget, focusNode) {
                    setState(() => _isRePassValid = true);
                  },
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    autocorrect: false,
                    cursorColor: _isRePassValid ? darkGreen : Colors.red[400],
                    obscureText: _obscureText,
                    controller: _rePasswordController,
                    focusNode: _rePasswordFocus,
                    enableInteractiveSelection: true,
                    enableSuggestions: false,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        setState(() => _isRePassValid = false);
                      } else {
                        setState(() => _isRePassValid = true);
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
                      suffixIcon: IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        color: _obscureText ? Colors.grey[600] : darkGreen,
                        onPressed: () {
                          setState(() => _obscureText = !_obscureText);
                        },
                      ),
                      errorText: _isRePassValid ? null : 'Field is required',
                      errorStyle: TextStyle(color: Colors.red[400]),
                      labelText: "Password Again:",
                      labelStyle: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                ),
                SizedBox(height: 5 * wm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlatButton(
                      padding: EdgeInsets.zero,
                      child: Text("Cancle", style: TextStyle(color: darkGreen)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      width: 25 * wm,
                      height: 9.5 * wm,
                      child: GFButton(
                        color: darkGreen,
                        type: GFButtonType.solid,
                        shape: GFButtonShape.pills,
                        size: GFSize.MEDIUM,
                        text: 'Sign up',
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
                            //
                            _showToast("Please fill all the details");
                            //
                          } else if (_passwordController.text != _rePasswordController.text) {
                            //
                            _showToast("Passwords don't match");
                            //
                          } else {
                            Login.signUpWithEmail(
                              email: _emailController,
                              password: _passwordController,
                              displayName: _nameController,
                              context: context,
                            ).then((value) {
                              if (value == null) {
                                _showToast("Sign up failed");
                                //
                              } else {
                                _showToast("Signup success... Logging in");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GetSmokeData(),
                                  ),
                                );
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
