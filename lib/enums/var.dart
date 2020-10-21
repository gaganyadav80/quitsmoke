import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login/login.dart';
import 'package:quit_smoke/enums/sizeConfig.dart';

double hm = SizeConfig.heightMultiplier;
double wm = SizeConfig.widthMultiplier;

// * Colors
// Color appBar = Color(0xff2C2C2C);
Color appBar = Colors.grey[800];
Color body = Color(0xff191919);
Color card = Color(0xff272727);
Color green = Color(0xff62E843);
Color darkGreen = Color(0xff3DBB2B);
Color datetimePicker = Color(0xff2C2C2C);
Color introGreen = Color(0xff00C27D);
Color introPink = Color(0xffF10050);
Color introYellow = Color(0xffF0B809);
Color introButtons = Color(0xff2670C2);

// * Logic values
// bool isFirstLaunch = true;

// void setFirstLaunch({bool isFirstLaunch = true}) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.setBool('isFirstLaunch', isFirstLaunch);
// }

// Future<bool> getFirstLauch() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   return prefs.getBool('isFirstLaunch');
// }

// Future<Null> setQuitDate({String value}) async {
//   print('setQuitDate: $value');

//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.setString('quitDate', value);
// }

// Future<String> getQuitDate() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   return prefs.getString('quitDate');
// }
String collectionName;

class DocRef {
  static CollectionReference userRef;
  //
  static final DocumentReference smokedataRef = userRef.document("smokeData");
  static final DocumentReference journaldataRef = userRef.document("journalData");
  static final DocumentReference goaldataRef = userRef.document("goalData");
}

// class SmokeData {
//   static int packCost = 0;
//   static int packQty = 0;
//   static int dailyQty = 0;
//   static String quitDateStr;
//   static DateTime quitDateDT;
// }

// class JournalData {
//   static DateTime dateSmokedDT;
//   static String dateSmokedStr;
//   static int todayQty;
//   static int craveRating;
//   static String comment;
// }

// class GoalsData {
//   static DateTime goalDateDT;
//   static String goalDateStr;
//   static String goal;
// }

Map<String, dynamic> smokedata = {
  'packCost': 0,
  'packQty': 0,
  'dailyQty': 0,
  'quitDateStr': 'null',
  'quitDateDT': DateTime.now(),
};

Map<String, dynamic> jounaldata = {
  'todayQty': 0,
  'cravingRating': 0,
  'comment': null,
  'dateSmokedStr': 'null',
  'dateSmokedDT': null,
};

Map<String, dynamic> goalsData = {
  'goal': null,
  'goalDateStr': 'null',
  'goalDateDT': null,
};

String timeSmokeFree;
bool quitDateReached = false;

Duration moneyMultiplier;
double moneyTillSaved;
int yearlySaved;

void setSmokeData() {
  Timestamp _timestamp;

  DocRef.smokedataRef.get().then((document) {
    if (document.exists && document != null) {
      smokedata = document.data;

      _timestamp = document.data['quitDateDT'];
      smokedata['quitDateDT'] = _timestamp.toDate();

      print("DATA CHECK AND GET SUCCESSFULL");

      // setState(() {
      moneyMultiplier = DateTime.now().difference(smokedata['quitDateDT']);
      moneyTillSaved = (moneyMultiplier.inDays) * smokedata['dailyQty'] * (smokedata['packCost'] / smokedata['packQty']);
      yearlySaved = ((moneyTillSaved / moneyMultiplier.inDays) * 365).toInt();
      // });
    } else {
      print("DATA NOT PRESENT");
    }
  });
}

void setReference() {
  collectionName = "${Login.currentUser.displayName.toLowerCase().trim()}_${Login.currentUser.uid}";
  debugPrint("COLLECTION : $collectionName");
  DocRef.userRef = Firestore.instance.collection("$collectionName");
}

// document.data.forEach((key, value) {
//   if (key == 'packCost') {
//     SmokeData.packCost = value;
//   } else if (key == 'packQty') {
//     SmokeData.packQty = value;
//   } else if (key == 'dailyQty') {
//     SmokeData.dailyQty = value;
//   } else if (key == 'quitDateStr') {
//     SmokeData.quitDateStr = value;
//   } else if (key == 'quitDateDT') {
//     _timestamp = value;
//     SmokeData.quitDateDT = _timestamp.toDate();
//     print("DATA CHECK AND GET SUCCESSFULL");
//   }
// });
