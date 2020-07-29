import 'dart:core';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:quit_smoke/enums/var.dart';

class SplashScreen extends StatefulWidget {
  final int seconds;
  final Color backgroundColor;
  final dynamic navigateAfterSeconds;
  // final TextStyle styleTextUnderTheLoader;
  // final Text title;
  // final double photoSize;
  // final dynamic onClick;
  // final Color loaderColor;
  // final Image image;
  // final Text loadingText;
  // final ImageProvider imageBackground;
  // final Gradient gradientBackground;
  SplashScreen({
    @required this.seconds,
    this.navigateAfterSeconds,
    this.backgroundColor = Colors.white,
    // this.photoSize,
    // this.title = const Text(''),
    // this.onClick,
    // this.loaderColor,
    // this.styleTextUnderTheLoader = const TextStyle(
    // fontSize: 18.0,
    // fontWeight: FontWeight.bold,
    // color: Colors.black
    // ),
    // this.image,
    // this.loadingText  = const Text(""),
    // this.imageBackground,
    // this.gradientBackground
  });

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: widget.seconds), () {
      if (widget.navigateAfterSeconds is String) {
        // It's fairly safe to assume this is using the in-built material
        // named route component
        Navigator.of(context).pushReplacementNamed(widget.navigateAfterSeconds);
        //
      } else if (widget.navigateAfterSeconds is Widget) {
        // Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(builder: (BuildContext context) => widget.navigateAfterSeconds));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => widget.navigateAfterSeconds,
          ),
        );
      } else {
        throw ArgumentError('widget.navigateAfterSeconds must either be a String or Widget');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20 * wm, left: 3 * wm),
            child: Row(
              children: <Widget>[
                Text(
                  'Quit',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 2.2 * hm,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Smoke.',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 2.2 * hm,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25 * hm),
          Center(
            child: Container(
              height: 50 * wm,
              child: FlareActor(
                'assets/animations/loading.flr',
                animation: 'Alarm',
                alignment: Alignment.center,
              ),
            ),
          ),
          SizedBox(height: 25 * hm),
          Text(
            "Powered by GivNotes Inc.",
            style: TextStyle(
              fontFamily: 'SourceSansPro',
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 2.1 * hm,
            ),
          ),
        ],
      ),
    );
  }
}
