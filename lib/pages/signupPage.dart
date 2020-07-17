import 'package:flutter/material.dart';
import 'package:focus_widget/focus_widget.dart';
import 'package:getflutter/getflutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/login.dart';
import 'package:quit_smoke/enums/var.dart';
import 'package:quit_smoke/pages/homePage.dart';
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

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  bool _obscureText = true;
  bool _isEmailValid = true;
  bool _isPassValid = true;
  bool _isRePassValid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('SignUp Page'),
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
                  textInputAction: TextInputAction.next,
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
              SizedBox(height: 3 * wm),
              FocusWidget(
                focusNode: _rePasswordFocus,
                child: TextFormField(
                  autocorrect: false,
                  cursorColor: _isRePassValid ? Colors.black : Colors.red,
                  obscureText: _obscureText,
                  controller: _rePasswordController,
                  focusNode: _rePasswordFocus,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      setState(() => _isRePassValid = false);
                    } else {
                      setState(() => _isRePassValid = true);
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
                    errorText: _isRePassValid ? null : 'Field is required',
                    labelText: "Password Again:",
                  ),
                ),
              ),
              SizedBox(height: 5 * wm),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                    padding: EdgeInsets.zero,
                    child: Text("Cancle"),
                    onPressed: () {
                      Navigator.pop(context);
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
                      text: 'Sign up',
                      textStyle: GoogleFonts.roboto(
                        fontSize: 4 * wm,
                      ),
                      onPressed: () {
                        if (_passwordController.text.isEmpty || _emailController.text.isEmpty) {
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
                            context: context,
                          ).then((value) {
                            if (value == null) {
                              //
                              _showToast("Sign up failed");
                              //
                            } else {
                              _showToast("Signup success... Logging in");
                              Navigator.pop(context);
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
}
