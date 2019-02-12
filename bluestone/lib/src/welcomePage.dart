import 'package:bluestone/src/components/extras.dart';
import 'package:bluestone/src/loginPage.dart';
import 'package:bluestone/src/registerPage.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ThemeSettings.defaultTitle),
      ),
      backgroundColor: ThemeSettings.themeData.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //crossAxisAlignment: CrossAxisAlignment,
          children: <Widget>[
            RaisedButton(
              padding: EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
              onPressed: navigateToLoginPage,
              child: Text("Sign In", textScaleFactor: 2.0),
              color: ThemeSettings.themeData.accentColor,
            ),
            RaisedButton(
              padding: EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
              onPressed: navigateToRegisterPage,
              child: Text("Register", textScaleFactor: 2.0),
              color: ThemeSettings.themeData.accentColor,
            ),
          ],
        ),
      ),
    );
  }

  void navigateToLoginPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SignInManager(), fullscreenDialog: true));
  }

  void navigateToRegisterPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RegisterPage(), fullscreenDialog: true));
  }
}
