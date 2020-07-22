import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quit_smoke/enums/var.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DateTime quitDateDT;
  Duration difference;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 67.5 * wm,
          color: Colors.transparent,
          child: Image.asset('assets/images/timer.png'),
        ),
        Center(
          child: Text(
            difference == null ? '0 seconds' : '${difference.inSeconds} seconds',
            style: TextStyle(
              color: Colors.white,
              fontSize: 5 * wm,
            ),
          ),
        ),
        Column(
          children: [
            RaisedButton(
              child: Text('get'),
              onPressed: () {
                getQuitDate().then((value) {
                  quitDateDT = DateFormat.yMd().add_Hms().parse(value);
                  //
                  print('value: $value');
                  print('quitDate: $quitDateDT');
                });
              },
            ),
            RaisedButton(
              child: Text('start'),
              onPressed: () {
                print("start time: ${DateTime.now()}");
                setState(() => difference = DateTime.now().difference(quitDateDT));
              },
            ),
          ],
        )
      ],
    );
  }
}
