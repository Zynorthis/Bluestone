import 'package:bluestone/src/Pages/testingFile.dart';
import 'package:flutter/material.dart';
import 'package:bluestone/src/components/extras.dart';
import 'package:bluestone/src/Pages/welcomePage.dart';

//title: 'Bluestone [Local dev build]'

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final appName = "Bluestone";
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        primarySwatch: ThemeSettings.themeData.primaryColor,
      ),
      home: WelcomePage(),
    );
  }
}