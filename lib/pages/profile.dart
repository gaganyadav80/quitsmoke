import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/login.dart';
import 'package:quit_smoke/enums/var.dart';
import 'package:toast/toast.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: body,
      appBar: AppBar(
        backgroundColor: appBar,
        title: Text('Account'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/profile.png',
            width: double.infinity,
          ),
          SizedBox(height: 3 * wm),
          Text(
            "Your account details",
            style: TextStyle(
              color: Colors.white,
              fontSize: 7 * wm,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 5 * wm),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5 * wm),
            child: Column(
              children: [
                Text(
                  "You can easily restore your data should you loose",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 3.5 * wm,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  "or change your phone",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 3.5 * wm,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5 * wm),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3 * wm),
            child: GestureDetector(
              onTap: () => Toast.show(
                "Long press to copy on clipboard",
                context,
                duration: 3,
                gravity: Toast.BOTTOM,
                backgroundRadius: 5,
                backgroundColor: appBar,
              ),
              onLongPress: () {
                Clipboard.setData(ClipboardData(text: Login.currentUser.email));
                Toast.show(
                  "Copied to clipboard",
                  context,
                  duration: 3,
                  gravity: Toast.BOTTOM,
                  backgroundRadius: 5,
                  backgroundColor: appBar,
                );
                HapticFeedback.lightImpact();
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 2.5 * wm),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: darkGreen,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(7 * wm),
                ),
                child: Center(
                  child: Text(
                    "${Login.currentUser.email.toUpperCase()}",
                    style: TextStyle(
                      color: darkGreen,
                      fontSize: 3.5 * wm,
                      fontWeight: FontWeight.w500,
                      letterSpacing: wm / 2.5,
                    ),
                  ),
                ),
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              // TODO fix this in login.dart flutter package
              debugPrint("RESET PASSWORD PRESSED");
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Will be added soon!"),
                  backgroundColor: appBar,
                  duration: Duration(seconds: 3),
                ),
              );
            },
            child: Text(
              "Reset password?",
              style: TextStyle(
                color: darkGreen,
              ),
            ),
          ),
          SizedBox(height: 5 * wm),
          Text(
            "We do not collect any of your data. 100% privacy",
            style: TextStyle(
              color: Colors.white,
              fontSize: 3.5 * wm,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
