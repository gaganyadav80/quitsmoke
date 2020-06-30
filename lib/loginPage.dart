import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quit_smoke/enums/var.dart';

// !! Login Page Design
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    getFirstLauch().then((value) => isFirstLaunch = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: null,
    );
  }
}

Widget signInButton(BuildContext context, {bool onProfile, bool isSignOut}) {
  return Container(
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        blurRadius: 10,
        color: Colors.grey[400],
      )
    ]),
    height: hm < 7 ? 9 * hm : 8 * hm,
    child: GFButton(
      elevation: 4,
      fullWidthButton: true,
      color: onProfile == true ? Colors.black : Colors.purple,
      borderShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3 * wm),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.person_add,
            color: Colors.white,
            size: onProfile ? 2.2 * hm : 2.5 * hm,
          ),
          SizedBox(width: 4.6 * wm),
          Text(
            isSignOut == false ? 'Sign in' : 'Sign out',
            style: GoogleFonts.ubuntu(
              color: Colors.white,
              letterSpacing: 0.5,
              fontSize: onProfile ? 2.5 * hm : 2.9 * hm,
            ),
          ),
        ],
      ),
      onPressed: isSignOut == false ? () {} : () {},
    ),
  );
}
