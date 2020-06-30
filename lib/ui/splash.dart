import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quit_smoke/enums/var.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 13 * hm, left: 3 * wm),
              child: Row(
                children: <Widget>[
                  Text(
                    'Giv',
                    style: GoogleFonts.montserrat(
                      fontSize: 2.2 * hm,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Notes.',
                    style: GoogleFonts.montserrat(
                      fontSize: 2.2 * hm,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20 * hm),
            Center(
              child: Container(
                height: 18.4 * hm,
                width: 34.7 * wm,
                child: FlareActor(
                  'assets/animations/loading.flr',
                  animation: 'Alarm',
                  alignment: Alignment.center,
                ),
              ),
            ),
            SizedBox(height: 30 * hm),
            Text(
              "Checking your Google Login Status",
              style: GoogleFonts.sourceSansPro(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 2.1 * hm,
              ),
            ),
          ],
        ),
      ),
    );
  }
}