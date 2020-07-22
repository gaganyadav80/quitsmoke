import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quit_smoke/enums/var.dart';

class JournalPage extends StatefulWidget {
  JournalPage({Key key}) : super(key: key);

  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          RaisedButton(
            child: Text('Set'),
            onPressed: () {
              String quitDateJournal = DateFormat.yMd().add_Hms().format(DateTime.now());
              setQuitDate(value: quitDateJournal);
            },
          )
        ],
      ),
    );
  }
}
