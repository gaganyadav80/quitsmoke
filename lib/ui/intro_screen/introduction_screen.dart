import 'dart:async';
import 'dart:math';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:quit_smoke/enums/var.dart';
import 'package:quit_smoke/ui/intro_screen/intro_page.dart';
import 'package:quit_smoke/ui/intro_screen/page_view_model.dart';
import 'package:quit_smoke/utils/loginPage.dart';
import 'package:quit_smoke/utils/signupPage.dart';

class IntroductionScreen extends StatefulWidget {
  // All pages of the onboarding
  final List<PageViewModel> pages;

  // Is the user is allow to change page
  // @Default `false`
  final bool freeze;

  // Global background color (only visible when a page has a transparent background color)
  final Color globalBackgroundColor;

  // Animation duration in millisecondes
  // @Default `350`
  final int animationDuration;

  // Index of the initial page
  // @Default `0`
  final int initialPage;

  // Type of animation between pages
  // @Default `Curves.easeIn`
  final Curve curve;

  const IntroductionScreen({
    Key key,
    @required this.pages,
    this.freeze = false,
    this.globalBackgroundColor,
    this.animationDuration = 350,
    this.initialPage = 0,
    this.curve = Curves.easeIn,
  }) : super(key: key);

  @override
  IntroductionScreenState createState() => IntroductionScreenState();
}

class IntroductionScreenState extends State<IntroductionScreen> {
  PageController _pageController;
  double _currentPage = 0.0;
  bool _isScrolling = false;

  PageController get controller => _pageController;

  @override
  void initState() {
    super.initState();
    int initialPage = min(widget.initialPage, widget.pages.length - 1);
    _currentPage = initialPage.toDouble();
    _pageController = PageController(initialPage: initialPage);
  }

  bool _onScroll(ScrollNotification notification) {
    final metrics = notification.metrics;
    if (metrics is PageMetrics) {
      setState(() => _currentPage = metrics.page);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: NotificationListener<ScrollNotification>(
              onNotification: _onScroll,
              child: PageView(
                controller: _pageController,
                physics: ClampingScrollPhysics(),
                children: widget.pages.map((p) => IntroPage(page: p)).toList(),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Opacity(
              opacity: 0.5,
              child: DotsIndicator(
                dotsCount: widget.pages.length,
                position: _currentPage,
                decorator: DotsDecorator(
                  activeColor: Colors.grey,
                  size: Size.fromRadius(0.7 * wm),
                  spacing: EdgeInsets.all(wm),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Container(
              color: introButtons,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(right: BorderSide(width: 0.4)),
                      ),
                      height: 12.5 * wm,
                      child: RaisedButton(
                        color: introButtons,
                        child: Text(
                          "GET STARTED",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 3.5 * wm,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupPage(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(left: BorderSide(width: 0.4)),
                      ),
                      height: 12.5 * wm,
                      child: FlatButton(
                        color: introButtons,
                        child: Text("LOG IN",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 3.5 * wm,
                            )),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
