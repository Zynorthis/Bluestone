import 'package:bluestone/src/components/extras.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter/material.dart';

class CalendarDisplay extends StatefulWidget {
  const CalendarDisplay({ Key key, @required this.calendarType });
  
  final String calendarType;
  @override
  _CalendarDisplayState createState() => _CalendarDisplayState();
}

class _CalendarDisplayState extends State<CalendarDisplay> {

  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = '';
  
  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.event,
      color: Colors.amber,
    ),
  );



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ThemeSettings.defaultTitle),
      ),
      backgroundColor: ThemeSettings.themeData.backgroundColor,
      body: Container(

      ),
    );
  }
}
