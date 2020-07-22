import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quit_smoke/enums/sizeConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

double hm = SizeConfig.heightMultiplier;
double wm = SizeConfig.widthMultiplier;

// * Colors
Color appBar = Color(0xff2C2C2C);
Color body = Color(0xff191919);
Color card = Color(0xff272727);
Color green = Color(0xff62E843);
Color darkGreen = Color(0xff3DBB2B);

// * Logic values
bool isFirstLaunch = true;

void setFirstLaunch({bool isFirstLaunch = true}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isFirstLaunch', isFirstLaunch);
}

Future<bool> getFirstLauch() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isFirstLaunch');
}

Future<Null> setQuitDate({String value}) async {
  print('setQuitDate: $value');

  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('quitDate', value);
}

Future<String> getQuitDate() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('quitDate');
}

FirebaseUser currentUser;
String blankUser = '', photoUrl = '', displayName = 'Not Logged in', email = '';

Future<void> setUserDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setString('url', currentUser.photoUrl);
  await prefs.setString('name', currentUser.displayName);
  await prefs.setString('email', currentUser.email);
}

Future<void> getUserDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  photoUrl = prefs.getString('url');
  displayName = prefs.getString('name');
  email = prefs.getString('email');
}
