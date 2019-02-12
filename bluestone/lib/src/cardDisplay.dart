import 'package:bluestone/src/components/extras.dart';
import 'package:flutter/material.dart';

class CardDisplay extends StatefulWidget {
  const CardDisplay({Key key, @required this.cardType });

  final String cardType;
  @override
  _CardDisplayState createState() => _CardDisplayState();
}

class _CardDisplayState extends State<CardDisplay> {
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
