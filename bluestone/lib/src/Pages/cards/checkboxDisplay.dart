import 'package:bluestone/src/components/extras.dart';
import 'package:bluestone/src/components/firebaseContent.dart';
import 'package:bluestone/src/components/menuBuilder.dart';
import 'package:flutter/material.dart';

class CheckboxPage extends StatefulWidget {
  @override
  _CheckboxPageState createState() => _CheckboxPageState();
}

class _CheckboxPageState extends State<CheckboxPage> {
  @override
  Widget build(BuildContext context) {
    documentReference = "Checkbox";
    return Scaffold(
      appBar: AppBar(
        title: Text("${ThemeSettings.defaultTitle}"),
        actions: <Widget>[
            deleteButton(context),
        ],
      ),
      backgroundColor: ThemeSettings.themeData.backgroundColor,
      body: null
    );
  }
}