import 'package:flutter/material.dart';
import 'package:bluestone/src/components/extras.dart';
import 'package:bluestone/src/Pages/welcomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: ThemeSettings.themeData.primaryColor,
      ),
      home: WelcomePage(),
    );
  }
}