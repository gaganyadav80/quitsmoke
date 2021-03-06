import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';
import 'package:quit_smoke/enums/var.dart';
import 'package:quit_smoke/packages/login.dart';
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
  TabController _gfTabController;
  DateTime _currentBackPressTime;
  Timer _timerSmokeFree;
  // Timer timerMoneySaved;

  String _timeSmokeFree;
  bool _quitDateReached = false;

  // DateTime temp;

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
      _quitDateReached = smokedata['quitDateDT'].difference(DateTime.now()) < Duration(seconds: 0);
      _timeSmokeFree = DateTimeFormat.relative(
        smokedata['quitDateDT'] ?? DateTime.now(),
        levelOfPrecision: 3,
        ifNow: "Let's Go!",
        minUnitOfTime: UnitOfTime.second,
        abbr: true,
      ).toLowerCase();
    });
  }

  @override
  void initState() {
    super.initState();
    setSmokeData();
    _gfTabController = TabController(length: 3, vsync: this);
    _timerSmokeFree = Timer.periodic(Duration(seconds: 1), (timer) => fetchTimeSmokeFree());
  }

  @override
  void dispose() {
    _gfTabController?.dispose();
    _timerSmokeFree?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onPop(),
      child: Scaffold(
        backgroundColor: card,
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
          physics: NeverScrollableScrollPhysics(),
          controller: _gfTabController,
          children: [
            SingleChildScrollView(
                child: Dashboard(
              timeSmokeFree: _timeSmokeFree,
              quitDateReached: _quitDateReached,
            )),
            SingleChildScrollView(child: JournalPage()),
            SingleChildScrollView(child: GoalsPage()),
          ],
        ),
        bottomNavigationBar: GFTabBar(
          length: 3,
          tabBarHeight: 15 * wm,
          tabBarColor: appBar,
          controller: _gfTabController,
          indicatorColor: darkGreen,
          unselectedLabelColor: Colors.white,
          labelColor: darkGreen,
          labelStyle: TextStyle(
            fontWeight: FontWeight.w400,
          ),
          tabs: [
            Tab(
              icon: Icon(Icons.dashboard),
              child: Text("Dashboard"),
            ),
            Tab(
              icon: Icon(Icons.book),
              child: Text("Journal"),
            ),
            Tab(
              icon: Icon(Icons.check_circle_outline),
              child: Text("Goals"),
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
      ).then((value) {
        if (value == true) {
          setState(() {
            _quitDateReached = smokedata['quitDateDT'].difference(DateTime.now()) < Duration(seconds: 0);
          });
        }
      });
    }
    if (choice == 'Logout') {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          elevation: 0,
          backgroundColor: appBar,
          // title: Text(
          //   'Confirm Logout?',
          //   style: TextStyle(color: Colors.white),
          // ),
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
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }
  }

  Future<bool> _onPop() async {
    DateTime now = DateTime.now();
    if (_currentBackPressTime == null || now.difference(_currentBackPressTime) > Duration(seconds: 2)) {
      _currentBackPressTime = now;
      _showToast('Press back again to exit');
      return false;
    }
    if (Platform.isAndroid) SystemNavigator.pop();
    return true;
  }
}
