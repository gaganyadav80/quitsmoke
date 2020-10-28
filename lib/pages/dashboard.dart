import 'dart:async';

import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:quit_smoke/enums/var.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    Key key,
    @required this.quitDateReached,
    @required this.timeSmokeFree,
  }) : super(key: key);

  final bool quitDateReached;
  final String timeSmokeFree;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExploreSmokeFree(
                  initSmokeFreeTime: widget.timeSmokeFree,
                ),
              ),
            );
          },
          child: Material(
            color: Color(0xff7FC443),
            elevation: 5,
            child: Stack(
              children: [
                Hero(
                  tag: 'smoke-free-image',
                  child: Container(
                    width: double.infinity,
                    child: Image.asset('assets/images/timer.png'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5 * wm),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          !widget.quitDateReached ? "We'll start after" : 'Time smoke free',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 5.7 * wm,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: 2 * wm),
                        Text(
                          '${widget.timeSmokeFree}',
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
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 5 * wm, 3 * wm, 0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          splashColor: body,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExploreMoneySaved(),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 5 * wm, 0, 5 * wm),
            width: double.infinity,
            child: Column(
              children: [
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
            ),
          ),
        ),
        Container(
          color: Color(0xff76B83D),
          width: double.infinity,
          height: 200,
        ),
      ],
    );
  }
}

class ExploreMoneySaved extends StatelessWidget {
  ExploreMoneySaved({Key key}) : super(key: key);

  final double _savedPerWeek = double.parse((smokingCostPerDay * 7).toStringAsFixed(2));
  final double _savedPerMonth = double.parse((smokingCostPerDay * 30).toStringAsFixed(2));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: body,
      appBar: AppBar(
        title: Text(
          "Money",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: appBar,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(5 * wm, 10 * wm, 5 * wm, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Money saved',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 5 * wm,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  '₹$moneyTillSaved',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: darkGreen,
                    fontSize: 13 * wm,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5 * wm),
            Divider(
              color: appBar,
              thickness: 2,
            ),
            SizedBox(height: 5 * wm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Per day',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 5 * wm,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  '₹$smokingCostPerDay',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: darkGreen,
                    fontSize: 8 * wm,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5 * wm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Per week',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 5 * wm,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  '₹$_savedPerWeek',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: darkGreen,
                    fontSize: 8 * wm,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5 * wm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Per month',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 5 * wm,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  '₹$_savedPerMonth',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: darkGreen,
                    fontSize: 8 * wm,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5 * wm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Per year',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 5 * wm,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  '₹${yearlySaved.toInt()}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: darkGreen,
                    fontSize: 8 * wm,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5 * wm),
          ],
        ),
      ),
    );
  }
}

class ExploreSmokeFree extends StatefulWidget {
  const ExploreSmokeFree({Key key, this.initSmokeFreeTime}) : super(key: key);

  final String initSmokeFreeTime;

  @override
  _ExploreSmokeFreeState createState() => _ExploreSmokeFreeState();
}

class _ExploreSmokeFreeState extends State<ExploreSmokeFree> {
  String _exploreSmokeFree;
  Timer _exploreTimerSmokeFree;

  DateTime _getSmokeDataQuitDT;

  void exploreFetchSmokeFree() {
    setState(() {
      _exploreSmokeFree = DateTimeFormat.relative(
        smokedata['quitDateDT'],
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
    _getSmokeDataQuitDT = smokedata['quitDateDT'];
    _exploreSmokeFree = widget.initSmokeFreeTime;
    _exploreTimerSmokeFree = Timer.periodic(Duration(seconds: 1), (timer) => exploreFetchSmokeFree());
  }

  @override
  void dispose() {
    _exploreTimerSmokeFree?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff7FC443),
      appBar: AppBar(
        title: Text(
          "Time smoke free",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: appBar,
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Hero(
              tag: 'smoke-free-image',
              child: Container(
                width: double.infinity,
                child: Image.asset('assets/images/timer.png'),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 3.5 * hm),
              child: Text(
                'You have been smoke free for:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 5 * wm,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 9 * hm),
              child: Column(
                children: [
                  Text(
                    '$_exploreSmokeFree',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13 * wm,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 3 * hm),
                  Text(
                    'This is the same as',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 5 * wm,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 3 * hm),
                  Text(
                    '${DateTime.now().difference(_getSmokeDataQuitDT).inHours} Hours',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11 * wm,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    '${DateTime.now().difference(_getSmokeDataQuitDT).inMinutes} Minutes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11 * wm,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    '${DateTime.now().difference(_getSmokeDataQuitDT).inSeconds} Seconds',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11 * wm,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
