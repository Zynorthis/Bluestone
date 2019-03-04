import 'package:bluestone/src/components/extras.dart';
import 'package:bluestone/src/components/firebaseContent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CalendarEditPage extends StatefulWidget {
  @override
  _CalendarEditPageState createState() => _CalendarEditPageState();
}

class _CalendarEditPageState extends State<CalendarEditPage> {
  TextEditingController _titleController = new TextEditingController();
  bool visibilityCheckbox = FirestoreContent.calendarSnap.data["visibility"];
  bool scopeCheckbox = FirestoreContent.calendarSnap.data["scope"];

  @override
  Widget build(BuildContext context) {
    _titleController.text = FirestoreContent.calendarSnap.data["title"];
    return Scaffold(
      appBar: AppBar(
        title: Text("${_titleController.text} - Edit"),
      ),
      backgroundColor: ThemeSettings.themeData.backgroundColor,
      floatingActionButton: new FloatingActionButton.extended(
        icon: Icon(Icons.save),
        label: Text("Save"),
        onPressed: _saveCalendarEditsToDb,
      ),
      body: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _titleController,
                enableInteractiveSelection: true,
                maxLength: 18,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  Checkbox(
                    value: visibilityCheckbox,
                    onChanged: (bool value) {
                      setState(() {
                        visibilityCheckbox = value;
                      });
                      print("Visibility set to $visibilityCheckbox");
                    },
                  ),
                  Text("Visibilty Settings"),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  Checkbox(
                    value: scopeCheckbox,
                    onChanged: (bool value) {
                      setState(() {
                        scopeCheckbox = value;
                      });
                      print("Scope set to $scopeCheckbox");
                    },
                  ),
                  Text("Scope Settings"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveCalendarEditsToDb() async {
    print("Saving ${FirestoreContent.calendarSnap.documentID} Changes...");
    FirestoreContent.calendarSnap.data["title"] = _titleController.text;
    Map<String, dynamic> data = <String, dynamic>{
      "title": FirestoreContent.calendarSnap.data["title"],
      "visibility": visibilityCheckbox,
      "scope": scopeCheckbox,
    };
    var id = FirestoreContent.calendarSnap.documentID;
    FirestoreContent.calendarDoc = Firestore.instance.document(
        "Calendars/Live/UIDs/${CurrentLoggedInUser.user.uid}/CalendarIDs/$id");
    FirestoreContent.calendarDoc.updateData(data).whenComplete(() {
      print("Document Updated.");
      setState(() {});
    }).catchError((e) => print(e));
    Navigator.pop(context);
  }
}
