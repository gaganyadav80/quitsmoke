import 'package:quit_smoke/enums/sizeConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

double hm = SizeConfig.heightMultiplier;
double wm = SizeConfig.widthMultiplier;

// * Logic values
bool isLoggedIn = false;
bool isFirstLaunch = true;

// * Skip funcitionality
void setLoginStat({bool login}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('bool', login);
}

Future<bool> getLoginStat() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('bool');
}

void setFirstLaunch({bool isFirstLaunch = true}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isFirstLaunch', isFirstLaunch);
}

Future<bool> getFirstLauch() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isFirstLaunch');
}
