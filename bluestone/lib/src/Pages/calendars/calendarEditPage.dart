import 'package:bluestone/src/components/extras.dart';
import 'package:bluestone/src/components/firebaseContent.dart';
import 'package:flutter/material.dart';

class CalendarEditPage extends StatefulWidget {
  @override
  _CalendarEditPageState createState() => _CalendarEditPageState();
}

class _CalendarEditPageState extends State<CalendarEditPage> {
  TextEditingController _titleController;
  bool visibilityCheckbox = false;
  bool scopeCheckbox = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${FirestoreContent.calendarSnap.data["title"]} - Edit"),
      ),
      backgroundColor: ThemeSettings.themeData.backgroundColor,
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
}
