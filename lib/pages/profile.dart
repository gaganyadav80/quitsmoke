import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quit_smoke/enums/var.dart';
import 'package:quit_smoke/packages/login.dart';
import 'package:toast/toast.dart';

class ProfilePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: body,
      appBar: AppBar(
        backgroundColor: appBar,
        title: Text('Account'),
        actions: [
          PopupMenuButton<String>(
            color: appBar,
            onSelected: (value) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  elevation: 0,
                  backgroundColor: appBar,
                  content: Text(
                    "Do you want to permanently delete this account?",
                    style: TextStyle(color: Colors.white),
                  ),
                  actions: [
                    FlatButton(
                      child: Text(
                        'CANCLE',
                        style: TextStyle(color: darkGreen),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    FlatButton(
                      child: Text(
                        "DELETE",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        print('Delete tap');
                        Login.currentUser.delete();
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              );
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem(
                value: "deleteacc",
                child: Text(
                  "Delete account?",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ],
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
                  "You can easily restore your data should you loose or change your phone",
                  textAlign: TextAlign.center,
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
              _scaffoldKey.currentState.showSnackBar(
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
            "We do not collect any of your personal data. \nJust the numbers, 100% privacy.",
            textAlign: TextAlign.center,
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
