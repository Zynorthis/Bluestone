import 'package:bluestone/src/components/extras.dart';
import 'package:flutter/material.dart';

class CardDisplay extends StatefulWidget {
  const CardDisplay({Key key, @required this.cardType, this.cardTitle});

  final String cardType;
  final String cardTitle;
  @override
  _CardDisplayState createState() => _CardDisplayState();
}

class _CardDisplayState extends State<CardDisplay> {
  String _cardTitle;
  bool isEdittingTitle;
  bool isEdittingBody;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_cardTitle),
        ),
        backgroundColor: ThemeSettings.themeData.backgroundColor,
        body: Column(
          children: <Widget>[
            // Padding holds container to hold title
            Container(
              height: 20.0,
              child: isEdittingTitle
                  ? Row(
                      children: <Widget>[TextField(), Icon(Icons.edit)],
                    )
                  : Row(
                      children: <Widget>[Text("Placeholder Title"), Icon(Icons.save)],
                    ),
            ),
            // Padding holds child for textbox
            Container(
              height: 80.0,
              child: isEdittingBody
                  ? Row(
                      children: <Widget>[TextField(), Icon(Icons.edit)],
                    )
                  : Row(
                      children: <Widget>[Text("Placeholder Body Text"), Icon(Icons.save)],
                    ),
            ),
          ],
        ));
  }
}
