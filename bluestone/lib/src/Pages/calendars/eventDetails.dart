import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Details Page"),
      ),
      floatingActionButton: new FloatingActionButton.extended(
          icon: (_isEditing) ? new Icon(Icons.save) : new Icon(Icons.edit),
          onPressed: () {
            setState(() {
              _isEditing = !_isEditing;
            });
          },
          label: (_isEditing) ? Text("Save") : Text("Edit")),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    Text(
                      _titleController.text,
                      textScaleFactor: 1.5,
                    ),
                  ]),
          ),
          Container(
            height: 80.0,
            margin: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
            padding: EdgeInsets.only(bottom: 0.0),
            child: (_isEditing)
                ? new TextField(
                    controller: _descriptionController,
                    enableInteractiveSelection: false,
                    maxLines: 99,
                    decoration: InputDecoration(
                      hintText: "Textbox",
                      border: OutlineInputBorder(),
                    ),
                  )
                : new Row(children: <Widget>[
                    Text("${_descriptionController.text}",
                        textScaleFactor: 1.0),
                  ]),
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text((isSetYetStart)
                      ? "Event Start Time: $formatedHourStart:${_startTime.minute} $isAMorPMStart"
                      : "Event Start Time: 12:00 AM"),
                  RaisedButton.icon(
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
                  Text((isSetYetEnd)
                      ? "Event End Time: $formatedHourEnd:${_endTime.minute} $isAMorPMEnd"
                      : "Event End Time: 12:00 AM"),
                  RaisedButton.icon(
                    icon: Icon(Icons.edit),
                    label: Text("Edit"),
                    onPressed: () {
                      print("Begin Edit End Time");
                      _selectTime(context, false);
                    },
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Future<Null> _selectTime(BuildContext context, bool startOrEndTime) async {
    final TimeOfDay _selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 0, minute: 0),
    );
    startOrEndTime ? isSetYetStart = true : isSetYetStart = true;
    _timeFormating(_selectedTime, startOrEndTime);
    startOrEndTime
        ? print(
            "Time Selected: $formatedHourStart:${_selectedTime.minute} $isAMorPMStart")
        : print(
            "Time Selected: $formatedHourEnd:${_selectedTime.minute} $isAMorPMEnd");
    setState(() {
      if (startOrEndTime) {
        _startTime = _selectedTime;
      } else {
        _endTime = _selectedTime;
      }
    });
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
        isAMorPMStart = "PM";
      } else {
        formatedHourEnd = _time.hour;
        isAMorPMStart = "AM";
      }
    }
    print("Formating Complete");
  }
}
