import 'package:bluestone/src/components/extras.dart';
import 'package:bluestone/src/components/firebaseContent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventDetailsPage extends StatefulWidget {
  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  TimeOfDay _startTime = new TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _endTime = new TimeOfDay(hour: 0, minute: 0);
  bool _isEditing = false;
  bool isSetYetStart = false;
  bool isSetYetEnd = false;
  String isAMorPMStart, isAMorPMEnd;
  int formatedHourStart, formatedHourEnd;

  @override
  Widget build(BuildContext context) {
    _titleController.text = LocalData.currentEvent.title;
    _descriptionController.text = LocalData.currentEvent.description;

    return Scaffold(
      appBar: AppBar(
        title: Text("${_titleController.text}"),
      ),
      floatingActionButton: new FloatingActionButton.extended(
          icon: (_isEditing)
              ? new Icon(
                  Icons.save,
                  color: Colors.black,
                )
              : new Icon(
                  Icons.edit,
                  color: Colors.black,
                ),
          backgroundColor: ThemeSettings.themeData.accentColor,
          onPressed: () {
            setState(() {
              _isEditing = !_isEditing;
              LocalData.currentEvent.title = _titleController.text;
              LocalData.currentEvent.description = _descriptionController.text;
              LocalData.currentEvent.startTime = _startTime;
              LocalData.currentEvent.endTime = _endTime;
              if (!_isEditing) {
                _saveEventChangesToDb();
              }
            });
          },
          label: (_isEditing)
              ? Text(
                  "Save",
                  style: TextStyle(color: Colors.black),
                )
              : Text(
                  "Edit",
                  style: TextStyle(color: Colors.black),
                )),
      backgroundColor: ThemeSettings.themeData.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: 20.0,
            margin: const EdgeInsets.all(20.0),
            child: (_isEditing)
                ? new TextFormField(
                    controller: _titleController,
                    enableInteractiveSelection: true,
                    maxLength: 18,
                  )
                : new Row(children: <Widget>[
                    Text(LocalData.currentEvent.title,
                        textScaleFactor: 1.5,
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold)),
                  ]),
          ),
          Container(
            height: 80.0,
            margin: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
            padding: EdgeInsets.only(bottom: 0.0),
            child: (_isEditing)
                ? new TextField(
                    controller: _descriptionController,
                    enableInteractiveSelection: true,
                    maxLines: 99,
                    decoration: InputDecoration(
                      hintText: "Textbox",
                      border: OutlineInputBorder(),
                    ),
                  )
                : Container(
                    child: Text(LocalData.currentEvent.description,
                        textAlign: TextAlign.left,
                        textScaleFactor: 1.0,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w600)),
                  ),
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                      (isSetYetStart)
                          ? "Event Start Time: $formatedHourStart:${_startTime.minute} $isAMorPMStart"
                          : "Event Start Time: 12:00 AM",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  RaisedButton.icon(
                    color: ThemeSettings.themeData.accentColor,
                    icon: Icon(Icons.edit),
                    label: Text("Edit"),
                    onPressed: () {
                      print("Begin Edit Start Time");
                      _selectTime(context, true);
                    },
                  ),
                ],
              )),
          Container(
              margin: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                      (isSetYetEnd)
                          ? "Event End Time: $formatedHourEnd:${_endTime.minute} $isAMorPMEnd"
                          : "Event End Time: 12:00 AM",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  RaisedButton.icon(
                    color: ThemeSettings.themeData.accentColor,
                    icon: Icon(Icons.edit),
                    label: Text("Edit"),
                    onPressed: () {
                      print("Begin Edit End Time");
                      _selectTime(context, false);
                    },
                  ),
                ],
              )),
          SizedBox(height: 24.0),
        ],
      ),
    );
  }

  Future<Null> _selectTime(BuildContext context, bool startOrEndTime) async {
    final TimeOfDay _selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 0, minute: 0),
    );
    startOrEndTime ? isSetYetStart = true : isSetYetEnd = true;
    if (_selectedTime != null) {
      _timeFormating(_selectedTime, startOrEndTime);
      startOrEndTime
          ? print(
              "Time Selected: $formatedHourStart:${_selectedTime.minute} $isAMorPMStart")
          : print(
              "Time Selected: $formatedHourEnd:${_selectedTime.minute} $isAMorPMEnd");
      setState(() {
        if (startOrEndTime) {
          _startTime = _selectedTime;
          LocalData.currentEvent.startTime = _selectedTime;
        } else {
          _endTime = _selectedTime;
          LocalData.currentEvent.endTime = _endTime;
        }
      });
    }
  }

  void _timeFormating(TimeOfDay _time, bool startOrEndTime) {
    // (startOrEndTime)
    //     ? ((_time.hour > 12)
    //         ? (formatedHourStart = _time.hour - 12)
    //         : (formatedHourStart = _time.hour))
    //     : ((_time.hour > 12)
    //         ? (formatedHourEnd = _time.hour - 12)
    //         : (formatedHourEnd = _time.hour));
    if (startOrEndTime) {
      if (_time.hour > 12) {
        formatedHourStart = _time.hour - 12;
        isAMorPMStart = "PM";
      } else {
        formatedHourStart = _time.hour;
        isAMorPMStart = "AM";
      }
    } else {
      if (_time.hour > 12) {
        formatedHourEnd = _time.hour - 12;
        isAMorPMEnd = "PM";
      } else {
        formatedHourEnd = _time.hour;
        isAMorPMEnd = "AM";
      }
    }
    print("Formatting Complete");
  }

  _saveEventChangesToDb() async {
    Map<String, dynamic> data = <String, dynamic>{
      "title": _titleController.text,
      "description": _descriptionController.text,
      "date": LocalData.currentEvent.date,
      "startTime": _startTime,
      "endTime": _endTime,
    };
    var id = FirestoreContent.eventSnap.documentID;
    FirestoreContent.eventDoc = Firestore.instance.document(
        "/Calendars/Live/UIDs/${CurrentLoggedInUser.user.uid}/CalendarIDs/${FirestoreContent.calendarDoc.documentID}/Events/$id");
    FirestoreContent.eventDoc.setData(data).whenComplete(() {
      print("Event Data Updated.");
      setState(() {});
    }).catchError((e) => print(e));
  }
}
