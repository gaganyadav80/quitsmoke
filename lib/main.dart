import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/login.dart';
import 'package:quit_smoke/enums/sizeConfig.dart';
import 'package:quit_smoke/pages/homePage.dart';
import 'package:quit_smoke/pages/loginPage.dart';
import 'package:quit_smoke/ui/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        SizeConfig().init(constraints);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: CheckLogin(),
        );
      },
    );
  }
}

class CheckLogin extends StatefulWidget {
  CheckLogin({Key key}) : super(key: key);

  @override
  _CheckLoginState createState() => _CheckLoginState();
}

class _CheckLoginState extends State<CheckLogin> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
        Login.initUser();
        if (snapshot.connectionState == ConnectionState.waiting) return SplashPage();
        if (!snapshot.hasData || snapshot.data == null) return LoginPage();

        return HomePage();
      },
    );
    // return Scaffold(
    //   resizeToAvoidBottomInset: false,
    //   body: Login(
    //     loggedIn: HomePage(),
    //     loggedOut: LoginPage(),
    //   ),
    // );
  }
}
