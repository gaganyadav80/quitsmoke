import 'dart:async';
import 'dart:io';

import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';
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
  DateTime currentBackPressTime;
  Timer timer;
  int levelPrec = 2;
  DateTime temp;
  int temp2;

  final List<PopupMenuItem<String>> _popUpMenuItems = <String>['Settings', 'Logout']
      .map(
        (String value) => PopupMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  void fetchTimeSmokeFree() {
    setState(() {
      quitDateReached = smokedata['quitDateDT'].difference(DateTime.now()) < Duration(seconds: 0);
      timeSmokeFree = DateTimeFormat.relative(
        smokedata['quitDateDT'] ?? DateTime.now(),
        levelOfPrecision: 3,
        minUnitOfTime: UnitOfTime.hour,
        abbr: true,
      ).toLowerCase();
    });
  }

  @override
  void initState() {
    super.initState();
    setSmokeData();
    gfTabController = TabController(length: 3, vsync: this);
    temp = smokedata['quitDateDT'];
    timer = Timer.periodic(Duration(seconds: 1), (timer) => fetchTimeSmokeFree());
  }

  @override
  void dispose() {
    gfTabController?.dispose();
    timer?.cancel();
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
          automaticallyImplyLeading: false,
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
          backgroundColor: appBar,
          title: Text(
            'Confirm Logout?',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            "Just making sure you didn't pressed accidently xD",
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'NO',
                style: TextStyle(color: darkGreen),
              ),
            ),
            FlatButton(
              onPressed: () {
                _showToast('Logout success');
                Login.signOut();
                Navigator.pop(context);
              },
              child: Text(
                'Logout',
                style: TextStyle(color: darkGreen),
              ),
            ),
          ],
        ),
      );
    }
  }

  Future<bool> _onPop() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      _showToast('Press back again to exit');
      return false;
    }
    if (Platform.isAndroid) SystemNavigator.pop();
    return true;
  }
}
