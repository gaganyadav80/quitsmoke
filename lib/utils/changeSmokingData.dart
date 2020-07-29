import 'package:flutter/material.dart';
import 'package:quit_smoke/enums/var.dart';

class ChangeSmokingData extends StatefulWidget {
  ChangeSmokingData({Key key}) : super(key: key);

  @override
  _ChangeSmokingDataState createState() => _ChangeSmokingDataState();
}

class _ChangeSmokingDataState extends State<ChangeSmokingData> {
  final String packcostStr = 'How much does a packet cost?';
  final String packqtyStr = 'How many in a packet?';
  final String dailyqtyStr = 'How many do you smoke each day?';

  TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _textEditingController?.dispose();
    _focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: body,
      appBar: AppBar(
        backgroundColor: appBar,
        title: Text(
          "Change smoking data",
          style: TextStyle(
            fontSize: 5 * wm,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 5 * wm),
          GestureDetector(
            onTap: () {
              _textEditingController.text = "${smokedata['packCost']}";
              _showDialog(
                title: packcostStr,
                onPressedOK: () {
                  DocRef.smokedataRef.updateData({
                    "packCost": int.parse(_textEditingController.text),
                  });
                  setState(() {
                    smokedata['packCost'] = int.parse(_textEditingController.text);
                  });
                  _textEditingController.clear();
                  Navigator.pop(context);
                },
              );
            },
            child: ListTile(
              leading: Padding(
                padding: EdgeInsets.only(top: 6),
                child: Icon(
                  Icons.attach_money,
                  color: Colors.grey[500],
                ),
              ),
              title: Text(
                packcostStr,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                "INR ${smokedata['packCost']}",
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _textEditingController.text = "${smokedata['packQty']}";
              _showDialog(
                title: packqtyStr,
                onPressedOK: () {
                  DocRef.smokedataRef.updateData({
                    "packQty": int.parse(_textEditingController.text),
                  });
                  setState(() {
                    smokedata['packQty'] = int.parse(_textEditingController.text);
                  });
                  _textEditingController.clear();
                  Navigator.pop(context);
                },
              );
            },
            child: ListTile(
              leading: Padding(
                padding: EdgeInsets.only(top: 6),
                child: Icon(
                  Icons.bubble_chart,
                  color: Colors.grey[500],
                ),
              ),
              title: Text(
                packqtyStr,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                "${smokedata['packQty']}",
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _textEditingController.text = "${smokedata['dailyQty']}";
              _showDialog(
                title: dailyqtyStr,
                onPressedOK: () {
                  DocRef.smokedataRef.updateData({
                    "dailyQty": int.parse(_textEditingController.text),
                  });
                  setState(() {
                    smokedata['dailyQty'] = int.parse(_textEditingController.text);
                  });
                  _textEditingController.clear();
                  Navigator.pop(context);
                },
              );
            },
            child: ListTile(
              leading: Padding(
                padding: EdgeInsets.only(top: 6),
                child: Icon(
                  Icons.smoking_rooms,
                  color: Colors.grey[500],
                ),
              ),
              title: Text(
                dailyqtyStr,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                "${smokedata['dailyQty']}",
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

  void _showDialog({String title, Function onPressedOK}) async {
    await showDialog(
        context: context,
        builder: (BuildContext cotext) {
          return Dialog(
            child: Container(
              color: appBar,
              height: 42 * wm,
              child: Padding(
                padding: EdgeInsets.only(top: 5 * wm, left: 5 * wm, right: 5 * wm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 4.3 * wm,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 3 * wm),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      cursorColor: darkGreen,
                      controller: _textEditingController,
                      focusNode: _focusNode,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: darkGreen, width: 0.5 * wm),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[500], width: 0.5 * wm),
                        ),
                      ),
                    ),
                    SizedBox(height: 4 * wm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FlatButton(
                          padding: EdgeInsets.all(0),
                          child: Text(
                            "CANCLE",
                            style: TextStyle(color: darkGreen),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        FlatButton(
                          padding: EdgeInsets.zero,
                          child: Text(
                            "OK",
                            style: TextStyle(color: darkGreen),
                          ),
                          onPressed: onPressedOK,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

// class _SystemPadding extends StatelessWidget {
//   final Widget child;

//   _SystemPadding({Key key, this.child}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       child: child,
//     );
//   }
// }
