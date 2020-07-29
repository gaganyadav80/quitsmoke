import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:quit_smoke/enums/var.dart';
import 'package:quit_smoke/pages/profile.dart';
import 'package:quit_smoke/utils/changeSmokingData.dart';
import 'package:quit_smoke/utils/getSmokeData.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController _quitdateController = TextEditingController();
  DateTime _datetime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _quitdateController.text = "${DateFormat("h:mm a, dd MMM yyyy").format(_datetime)}";
  }

  @override
  void dispose() {
    _quitdateController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint('QUITDATE : ${SmokeData.quitDateStr} =================================');

    return Scaffold(
      backgroundColor: body,
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: appBar,
      ),
      body: Column(
        children: [
          SizedBox(height: 5 * wm),
          ListTile(
            leading: Icon(
              Icons.account_circle,
              color: Colors.grey[500],
            ),
            title: Text(
              'My Account',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ),
            ),
          ),
          SizedBox(height: wm),
          GestureDetector(
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
                currentTime: smokedata['quitDateDT'] ?? DateTime.now(),
                minTime: DateTime(DateTime.now().year, 1, 1),
                maxTime: DateTime(DateTime.now().add(Duration(days: 400)).year, 12, 31),
                onConfirm: (date) {
                  DatePicker.showTime12hPicker(
                    context,
                    showTitleActions: true,
                    currentTime: smokedata['quitDateDT'],
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
                      debugPrint('confirm $_datetime');

                      _quitdateController.text =
                          "${DateFormat("h:mm a, dd MMM yyyy").format(_datetime)}";
                      setState(() {
                        smokedata['quitDateStr'] = _quitdateController.text;
                        smokedata['quitDateDT'] = _datetime;
                      });

                      DocRef.smokedataRef.updateData({
                        'quitDateStr': _quitdateController.text,
                        'quitDateDT': Timestamp.fromDate(_datetime),
                      });
                    },
                  );
                },
              );
            },
            child: ListTile(
              leading: Padding(
                padding: EdgeInsets.only(top: 6),
                child: Icon(
                  Icons.today,
                  color: Colors.grey[500],
                ),
              ),
              title: Text(
                'Change quit date',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                smokedata['quitDateStr'] ?? "Not set",
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeSmokingData(),
              ),
            ),
            child: ListTile(
              leading: Padding(
                padding: EdgeInsets.only(top: 6),
                child: Icon(
                  Icons.storage,
                  color: Colors.grey[500],
                ),
              ),
              title: Text(
                'Change smoking data',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                "Cost per pack, number smoked per day etc.",
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GetSmokeData(),
                ),
              );
            },
            child: ListTile(
              leading: Padding(
                padding: EdgeInsets.only(top: 6),
                child: Icon(
                  Icons.note_add,
                  color: Colors.grey[500],
                ),
              ),
              title: Text(
                'Set smoking data',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                "Enter ALL smoking data",
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: appBar,
                  content: Text(
                    "Are you sure about this?",
                    style: TextStyle(color: Colors.white),
                  ),
                  actions: [
                    FlatButton(
                      child: Text(
                        'CANCLE',
                        style: TextStyle(color: darkGreen),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    FlatButton(
                      child: Text(
                        "DELETE",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        DocRef.smokedataRef.updateData({
                          "packCost": 0,
                          "packQty": 0,
                          "dailyQty": 0,
                          "quitDateStr": null,
                          "quitDateDT": null,
                        });

                        smokedata = {
                          "packCost": 0,
                          "packQty": 0,
                          "dailyQty": 0,
                          "quitDateStr": null,
                          "quitDateDT": null,
                        };

                        // SmokeData.packCost = 0;
                        // SmokeData.packQty = 0;
                        // SmokeData.dailyQty = 0;
                        // SmokeData.quitDateStr = null;
                        // SmokeData.quitDateDT = null;
                      },
                    )
                  ],
                ),
              );
            },
            child: ListTile(
              leading: Padding(
                padding: EdgeInsets.only(top: 6),
                child: Icon(
                  Icons.delete_forever,
                  color: Colors.grey[500],
                  size: 6.5 * wm,
                ),
              ),
              title: Text(
                'Reset data',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                "Resets ONLY smoking data",
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
