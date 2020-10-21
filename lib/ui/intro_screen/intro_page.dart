import 'package:flutter/material.dart';
import 'package:quit_smoke/enums/var.dart';
import 'package:quit_smoke/ui/intro_screen/page_view_model.dart';

class IntroPage extends StatelessWidget {
  final PageViewModel page;

  const IntroPage({Key key, @required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 4,
          child: Material(
            elevation: 2 * wm,
            child: Container(
              color: appBar,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(7 * wm),
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Text(
                            'Quit',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 2.2 * hm,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Smoke.',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 2.2 * hm,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Center(
                          child: page.bodyWidget,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15 * wm),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  page.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 6 * wm,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: wm),
                Text(
                  page.body,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontSize: 4 * wm,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
