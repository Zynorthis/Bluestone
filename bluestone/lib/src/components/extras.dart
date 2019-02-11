import 'package:flutter/material.dart';

/// This is a custom class designed to hold [ThemeData] and
/// [TextTheme] data. 
/// 
/// Whenever a color option is present, using [ThemeSettings] allows
/// for easier customization later on, due to only having to change one
/// variable in one place versus one variable across the whole app in
/// many different places.
/// 
/// current settings include:
/// ``` dart
///   primaryColor: Colors.blue
///   accentColor: Colors.blue[200]
///   backgroundColor: Colors.blue[50]
/// 
///   headline: TextStyle(
///     fontSize: 72.0, 
///     fontWeight: FontWeight.bold
///   ),
///   title: TextStyle(
///     fontSize: 36.0, 
///     fontStyle: FontStyle.italic
///   ),
///   body1: TextStyle(
///     fontSize: 14.0, 
///     fontFamily: "Malgun Gothic"
///   ),
/// ```

class ThemeSettings {

  static final themeData = new ThemeData(
    primaryColor: Colors.blue,
    accentColor: Colors.blue[200],
    backgroundColor: Colors.blue[50],
    textTheme: customTheme,
  );

  static final customTheme = new TextTheme(
    headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    body1: TextStyle(fontSize: 14.0, fontFamily: "Malgun Gothic"),
  );
}