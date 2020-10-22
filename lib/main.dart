import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quit_smoke/enums/sizeConfig.dart';
import 'package:quit_smoke/enums/var.dart';
import 'package:quit_smoke/pages/home.dart';
import 'package:quit_smoke/ui/intro_screen/my_introscreen.dart';
import 'package:quit_smoke/ui/splashscreen.dart';

import 'packages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
          theme: ThemeData(accentColor: appBar),
          home: SplashScreen(
            seconds: 1,
            navigateAfterSeconds: CheckLogin(),
            backgroundColor: Colors.white,
          ),
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
  void initState() {
    super.initState();
    Login.initUser();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return Scaffold(backgroundColor: body);

        if (!snapshot.hasData || snapshot.data == null) return IntroScreen();
        setReference();

        return HomePage();
      },
    );
  }
}

// return Scaffold(
//   resizeToAvoidBottomInset: false,
//   body: Login(
//     loggedIn: HomePage(),
//     loggedOut: LoginPage(),
//   ),
// );
