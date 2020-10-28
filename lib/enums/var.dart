import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quit_smoke/enums/sizeConfig.dart';
import 'package:quit_smoke/packages/login.dart';

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

String collectionName;

class DocRef {
  static CollectionReference userRef;
  //
  static final DocumentReference smokedataRef = userRef.doc("smokeData");
  static final DocumentReference journaldataRef = userRef.doc("journalData");
  static final DocumentReference goaldataRef = userRef.doc("goalData");
}

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

Duration moneyMultiplier;
double moneyTillSaved;
double yearlySaved;
double smokingCostPerDay;

void setSmokeData() {
  int _timestamp;

  DocRef.smokedataRef.get().then((document) {
    if (document.exists && document != null) {
      smokedata = document.data();

      _timestamp = document.data()['quitDateDT'];
      smokedata['quitDateDT'] = DateTime.fromMillisecondsSinceEpoch(_timestamp);

      // DateTime tempQuitDateDT = smokedata()['quitDateDT'];

      print("DATA CHECK AND GET SUCCESSFULL");

      // setState(() {
      smokingCostPerDay = smokedata['dailyQty'] * (smokedata['packCost'] / smokedata['packQty']);
      moneyMultiplier = DateTime.now().difference(smokedata['quitDateDT']);
      moneyTillSaved = double.parse(((moneyMultiplier.inMinutes) * smokingCostPerDay / 3600).toStringAsFixed(2));
      yearlySaved = double.parse((smokingCostPerDay * 365).toStringAsFixed(2));
      // });
    } else {
      print("DATA NOT PRESENT");
    }
  });
}

void setReference() {
  // print(Login.currentUser);
  collectionName = "${Login.currentUser.email}";
  debugPrint("COLLECTION : $collectionName");
  DocRef.userRef = FirebaseFirestore.instance.collection("$collectionName");
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
