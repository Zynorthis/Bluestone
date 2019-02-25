import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';

class EventDetailsPage extends StatefulWidget {
  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  TimeOfDay _startTime = new TimeOfDay();
  TimeOfDay _endTime = new TimeOfDay();
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TO DO:
      //   Let user input start and end time for an event

      //   Modify Event class (again...) and add properties for start and end times

      appBar: AppBar(
        title: Text("Event Details Page"),
      ),
      body: Column(
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
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
            padding: const EdgeInsets.only(bottom: 0.0),
          ),
        ],
      ),
    );
  }

  Future<Null> _selectTime(BuildContext context, bool startOrEndTime) async {
    final TimeOfDay _selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 0, minute: 0),
    );

    if (_selectedTime != null) {
      print("Time Selected: ${_selectedTime.hour}:${_selectedTime.minute}");
      setState(() {
        if (startOrEndTime) {
          _startTime = _selectedTime;
        } else {
          _endTime =_selectedTime;
        }
      });
    }
  }
}
