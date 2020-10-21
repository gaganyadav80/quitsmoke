import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:quit_smoke/enums/var.dart';
import 'package:quit_smoke/ui/intro_screen/introduction_screen.dart';
import 'package:quit_smoke/ui/intro_screen/page_view_model.dart';
import 'package:toast/toast.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  DateTime currentBackPressTime;

  // @override
  // void initState() {
  //   super.initState();
  //   setReference();
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onPop(),
      child: IntroductionScreen(
        pages: [
          PageViewModel(
            title: 'Welcome',
            body: "Logs you daily cigarettes, see time smoke free, and sync it all across devies",
            bodyColor: introGreen,
            bodyWidget: Padding(
              padding: EdgeInsets.all(5 * wm),
              child: Lottie.asset("assets/animations/lady-relax-goals.json"),
            ),
          ),
          PageViewModel(
            title: "Realtime",
            body: "Sync all your data in realtime. Offline? No problem we got you covered ",
            bodyColor: introPink,
            bodyWidget: Padding(
              padding: EdgeInsets.all(15 * wm),
              child: Lottie.asset("assets/animations/clock-dashboard.json"),
            ),
          ),
          PageViewModel(
            title: "Journal, Goals",
            body: "Keep your cigarettes journals and want to keep some goals? Gotcha!",
            bodyColor: introYellow,
            bodyWidget: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5 * wm),
              child: Lottie.asset("assets/animations/[.]read-book.json"),
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

  Future<bool> _onPop() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      _showToast('Press back again to exit');
      return false;
    }
    SystemNavigator.pop();
    return true;
  }
}
