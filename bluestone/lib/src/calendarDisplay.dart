import 'package:bluestone/src/components/extras.dart';
import 'package:flutter/material.dart';

class CalendarDisplay extends StatefulWidget {
  const CalendarDisplay({ Key key, @required this.calendarType });
  
  final String calendarType;
  @override
  _CalendarDisplayState createState() => _CalendarDisplayState();
}

class _CalendarDisplayState extends State<CalendarDisplay> {
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
