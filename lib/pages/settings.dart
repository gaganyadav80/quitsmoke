import 'package:flutter/material.dart';
import 'package:login/login.dart';
import 'package:quit_smoke/enums/var.dart';
import 'package:quit_smoke/pages/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String quitDateSettings;

  @override
  void initState() {
    super.initState();
    getQuitDate().then((value) {
      debugPrint('VALUE : $value =================================');
      setState(() {
        quitDateSettings = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint('QUITDATE : $quitDateSettings =================================');

    return Scaffold(
      backgroundColor: body,
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: appBar,
      ),
      body: Column(
        children: [
          SizedBox(height: 5 * wm),
          ListTile(
            leading: Icon(
              Icons.account_circle,
              color: Colors.grey[500],
            ),
            title: Text(
              'My Account',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ),
            ),
          ),
          SizedBox(height: wm),
          ListTile(
            leading: Padding(
              padding: EdgeInsets.only(top: 6),
              child: Icon(
                Icons.today,
                color: Colors.grey[500],
              ),
            ),
            title: Text(
              'Change quit date',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              quitDateSettings.substring(0, 15),
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          ListTile(
            leading: Padding(
              padding: EdgeInsets.only(top: 6),
              child: Icon(
                Icons.storage,
                color: Colors.grey[500],
              ),
            ),
            title: Text(
              'Change smoking data',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              "Cost per pack, number smoked per day etc.",
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          ListTile(
            leading: Padding(
              padding: EdgeInsets.only(top: 6),
              child: Icon(
                Icons.delete_forever,
                color: Colors.grey[500],
              ),
            ),
            title: Text(
              'Reset data',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              "Resets ALL data",
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
