import 'package:flutter/material.dart';
import 'package:quit_smoke/enums/var.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          color: Colors.transparent,
          child: Image.asset('assets/images/timer.png'),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5 * wm),
          child: Center(
            child: Column(
              children: [
                Text(
                  'Time smoke free',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 5.7 * wm,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 2 * wm),
                Text(
                  quitDateReached ? '$timeSmokeFree' : "We'll start soon",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13 * wm,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
