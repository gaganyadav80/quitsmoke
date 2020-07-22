import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/tabs/gf_tabbar.dart';
import 'package:getflutter/components/tabs/gf_tabbar_view.dart';
import 'package:login/login.dart';
import 'package:quit_smoke/enums/var.dart';
import 'package:quit_smoke/pages/dashboard.dart';
import 'package:quit_smoke/pages/journal.dart';
import 'package:quit_smoke/pages/goals.dart';
import 'package:quit_smoke/pages/settings.dart';
import 'package:toast/toast.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  TabController gfTabController;

  final List<PopupMenuItem<String>> _popUpMenuItems = <String>['Settings', 'Logout']
      .map(
        (String value) => PopupMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  @override
  void initState() {
    super.initState();
    gfTabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    gfTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: body,
      appBar: AppBar(
        backgroundColor: appBar,
        title: Text("Home"),
        actions: [
          PopupMenuButton<String>(
            onSelected: choiceActions,
            itemBuilder: (BuildContext context) => _popUpMenuItems,
          ),
        ],
      ),
      body: GFTabBarView(
        controller: gfTabController,
        children: [
          Dashboard(),
          JournalPage(),
          GoalsPage(),
          // SettingsPage(),
        ],
      ),
      bottomNavigationBar: GFTabBar(
        length: 3,
        tabBarHeight: 15 * wm,
        tabBarColor: appBar,
        controller: gfTabController,
        indicatorColor: darkGreen,
        unselectedLabelColor: Colors.white,
        labelColor: darkGreen,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w400,
        ),
        tabs: [
          Tab(
            icon: Icon(Icons.dashboard),
            child: Text(
              "Dashboard",
            ),
          ),
          Tab(
            icon: Icon(Icons.book),
            child: Text(
              "Journal",
            ),
          ),
          Tab(
            icon: Icon(Icons.check_circle_outline),
            child: Text(
              "Goals",
            ),
          ),
        ],
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

  void choiceActions(String choice) async {
    if (choice == 'Settings') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SettingsPage(),
        ),
      );
    }
    if (choice == 'Logout') {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Confirm Logout?'),
          content: Text("Just making sure you didn't pressed accidently xD"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('NO'),
            ),
            FlatButton(
              onPressed: () {
                _showToast('Logout success');
                Login.signOut();
                Navigator.pop(context);
              },
              child: Text('Logout'),
            ),
          ],
        ),
      );
    }
  }
}
