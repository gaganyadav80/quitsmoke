import 'package:firebase_auth/firebase_auth.dart';
import 'package:quit_smoke/enums/sizeConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

double hm = SizeConfig.heightMultiplier;
double wm = SizeConfig.widthMultiplier;

// * Logic values
bool isFirstLaunch = true;
FirebaseUser currentUser;

void setFirstLaunch({bool isFirstLaunch = true}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isFirstLaunch', isFirstLaunch);
}

Future<bool> getFirstLauch() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isFirstLaunch');
}
