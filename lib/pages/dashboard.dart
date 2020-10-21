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
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              child: Image.asset('assets/images/timer.png'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5 * wm),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      !quitDateReached ? "We'll start after" : 'Time smoke free',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 5.7 * wm,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 2 * wm),
                    Text(
                      '$timeSmokeFree',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13 * wm,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 5 * wm),
        Text(
          'Money saved',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 6.5 * wm,
            fontWeight: FontWeight.w300,
          ),
        ),
        SizedBox(height: 2 * wm),
        Text(
          '₹$moneyTillSaved',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: darkGreen,
            fontSize: 9 * wm,
            fontWeight: FontWeight.w300,
          ),
        ),
        SizedBox(height: 5 * wm),
        Text(
          'Per year',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 4.5 * wm,
            fontWeight: FontWeight.w300,
          ),
        ),
        SizedBox(height: 2 * wm),
        Text(
          '₹$yearlySaved',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: darkGreen,
            fontSize: 7 * wm,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
