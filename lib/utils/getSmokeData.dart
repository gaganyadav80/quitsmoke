import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:focus_widget/focus_widget.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:quit_smoke/enums/var.dart';
import 'package:quit_smoke/pages/home.dart';
import 'package:toast/toast.dart';

class GetSmokeData extends StatefulWidget {
  GetSmokeData({Key key}) : super(key: key);

  @override
  _GetSmokeDataState createState() => _GetSmokeDataState();
}

class _GetSmokeDataState extends State<GetSmokeData> {
  final FocusNode _packcostFocus = FocusNode();
  final FocusNode _packqtyFocus = FocusNode();
  final FocusNode _dailyqtyFocus = FocusNode();
  final FocusNode _quitdateFocus = FocusNode();

  final TextEditingController _packcostController = TextEditingController();
  final TextEditingController _packqtyController = TextEditingController();
  final TextEditingController _dailyqtyController = TextEditingController();
  TextEditingController _quitdateController = TextEditingController();

  bool _emptyField = false;
  DateTime _datetime = DateTime.now();
  DateTime currentBackPressTime;

  @override
  void initState() {
    super.initState();
    setReference();
    _quitdateController.text = "${DateFormat("h:mm a, dd MMM yyyy").format(_datetime)}";
  }

  @override
  void dispose() {
    _packcostController?.dispose();
    _packqtyController?.dispose();
    _dailyqtyController?.dispose();
    _quitdateController?.dispose();
    _packcostFocus?.dispose();
    _packqtyFocus?.dispose();
    _dailyqtyFocus?.dispose();
    _quitdateFocus?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: body,
      appBar: AppBar(
        backgroundColor: appBar,
        leading: Icon(Icons.all_inclusive, color: Colors.white),
        title: Text(
          "Let's get started!",
          style: TextStyle(
            fontSize: 5 * wm,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5 * wm),
        child: ListView(
          children: [
            SizedBox(height: 10 * wm),
            FocusWidget(
              focusNode: _packcostFocus,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                cursorColor: darkGreen,
                controller: _packcostController,
                focusNode: _packcostFocus,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  _packqtyFocus.requestFocus();
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: darkGreen),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[500]),
                  ),
                  labelText: "How much does a packet cost?",
                  labelStyle: TextStyle(color: Colors.grey[600]),
                  helperText: "Required field",
                  helperStyle: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),
            SizedBox(height: 4 * wm),
            FocusWidget(
              focusNode: _packqtyFocus,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                cursorColor: darkGreen,
                controller: _packqtyController,
                focusNode: _packqtyFocus,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  _dailyqtyFocus.requestFocus();
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: darkGreen),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[500]),
                  ),
                  labelText: "How many in a packet?",
                  labelStyle: TextStyle(color: Colors.grey[600]),
                  helperText: "Required field",
                  helperStyle: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),
            SizedBox(height: 4 * wm),
            FocusWidget(
              focusNode: _dailyqtyFocus,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                cursorColor: darkGreen,
                controller: _dailyqtyController,
                focusNode: _dailyqtyFocus,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                onEditingComplete: () {
                  _quitdateFocus.requestFocus();
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: darkGreen),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[500]),
                  ),
                  labelText: "How many do you smoke each day?",
                  labelStyle: TextStyle(color: Colors.grey[600]),
                  helperText: "Required field",
                  helperStyle: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),
            SizedBox(height: 4 * wm),
            FocusWidget(
              focusNode: _quitdateFocus,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                cursorColor: darkGreen,
                controller: _quitdateController,
                focusNode: _quitdateFocus,
                textInputAction: TextInputAction.done,
                readOnly: true,
                onTap: () {
                  DatePicker.showDatePicker(
                    context,
                    showTitleActions: true,
                    theme: DatePickerTheme(
                      backgroundColor: datetimePicker,
                      cancelStyle: TextStyle(color: Colors.grey[500], fontSize: 4.5 * wm),
                      doneStyle: TextStyle(color: darkGreen, fontSize: 4.5 * wm),
                      itemStyle: TextStyle(color: Colors.white, fontSize: 5 * wm),
                      titleHeight: 13 * wm,
                      itemHeight: 10 * wm,
                      containerHeight: 65 * wm,
                    ),
                    minTime: DateTime(DateTime.now().year, 1, 1),
                    maxTime: DateTime(DateTime.now().add(Duration(days: 400)).year, 12, 31),
                    onConfirm: (date) {
                      DatePicker.showTime12hPicker(
                        context,
                        showTitleActions: true,
                        theme: DatePickerTheme(
                          backgroundColor: datetimePicker,
                          cancelStyle: TextStyle(color: Colors.grey[500], fontSize: 4.5 * wm),
                          doneStyle: TextStyle(color: darkGreen, fontSize: 4.5 * wm),
                          itemStyle: TextStyle(color: Colors.white, fontSize: 5.5 * wm),
                        ),
                        onConfirm: (time) {
                          _datetime = DateTime(
                            date.year,
                            date.month,
                            date.day,
                            time.hour,
                            time.minute,
                          );
                          print('confirm $_datetime');
                          setState(() {
                            _quitdateController.text = "${DateFormat("h:mm a, dd MMM yyyy").format(_datetime)}";
                          });
                        },
                      );
                    },
                    currentTime: DateTime.now(),
                  );
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: darkGreen),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[500]),
                  ),
                  labelText: "Quit date?",
                  labelStyle: TextStyle(color: Colors.grey[600]),
                  helperText: "Required field",
                  helperStyle: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),
            SizedBox(height: 10 * wm),
            Container(
              width: 25 * wm,
              height: 10 * wm,
              child: GFButton(
                elevation: 3.5,
                color: darkGreen,
                type: GFButtonType.solid,
                shape: GFButtonShape.pills,
                size: GFSize.MEDIUM,
                text: 'Save',
                textStyle: TextStyle(
                  fontSize: 4 * wm,
                  color: Colors.white,
                ),
                onPressed: () async {
                  _emptyField = _packcostController.text.isEmpty || _packqtyController.text.isEmpty || _dailyqtyController.text.isEmpty;

                  var connectionState = await (Connectivity().checkConnectivity());

                  if (connectionState == ConnectivityResult.none) {
                    _showToast("Please connect to internet");
                    //
                  } else if (_emptyField == false) {
                    DocRef.smokedataRef.setData({
                      'packCost': int.parse(_packcostController.text),
                      'packQty': int.parse(_packqtyController.text),
                      'dailyQty': int.parse(_dailyqtyController.text),
                      'quitDateStr': _quitdateController.text,
                      'quitDateDT': Timestamp.fromDate(_datetime),
                    });
                    // SmokeData.packCost = int.parse(_packcostController.text);
                    // SmokeData.packQty = int.parse(_packqtyController.text);
                    // SmokeData.dailyQty = int.parse(_dailyqtyController.text);
                    // SmokeData.quitDateStr = _quitdateController.text;
                    // SmokeData.quitDateDT = _datetime;

                    smokedata = {
                      'packCost': int.parse(_packcostController.text),
                      'packQty': int.parse(_packqtyController.text),
                      'dailyQty': int.parse(_dailyqtyController.text),
                      'quitDateStr': _quitdateController.text,
                      'quitDateDT': _datetime,
                    };

                    // money saved
                    moneyMultiplier = DateTime.now().difference(smokedata['quitDateDT']);
                    moneyTillSaved = (moneyMultiplier.inDays) * smokedata['dailyQty'] * (smokedata['packCost'] / smokedata['packQty']);
                    yearlySaved = ((moneyTillSaved / moneyMultiplier.inDays) * 365).toInt();
                    //

                    _showToast("Data updated!");
                    setReference();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                    //
                  } else if (_emptyField) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: appBar,
                        content: Text(
                          "Please fill all the required fields to continue.",
                          style: TextStyle(color: Colors.white),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'OK',
                              style: TextStyle(color: darkGreen),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 7 * wm),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4 * wm),
              child: Center(
                child: Text(
                  "This will help us to show data on your dashboard",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              child: Center(
                child: Text(
                  "(money saved, time smoke free etc.)",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
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

  // Future<bool> _onPop() async {
  //   DateTime now = DateTime.now();
  //   if (currentBackPressTime == null ||
  //       now.difference(currentBackPressTime) > Duration(seconds: 2)) {
  //     currentBackPressTime = now;
  //     _showToast('Press back again to exit');
  //     return false;
  //   }
  //   return true;
  // }
}

// DateTimeField(
//   initialValue: DateTime.now(),
//   format: DateFormat("h:mm a, dd MMM yyyy"),
//   onShowPicker: (context, currentValue) async {
//     final date = await showDatePicker(
//         context: context,
//         firstDate: DateTime(2020),
//         initialDate: currentValue ?? DateTime.now(),
//         lastDate: DateTime(2022));
//     if (date != null) {
//       final time = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
//       );
//       return DateTimeField.combine(date, time);
//     } else {
//       return currentValue;
//     }
//   },
//   decoration: InputDecoration(
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.all(Radius.circular(5)),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: darkGreen),
//     ),
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: Colors.grey[500]),
//     ),
//     labelText: "Quit date?",
//     labelStyle: TextStyle(color: darkGreen),
//     helperText: "Required field",
//     helperStyle: TextStyle(color: Colors.grey[600]),
//   ),
//   style: TextStyle(color: Colors.white),
//   resetIcon: Icon(Icons.close, color: Colors.grey[400]),
// ),
