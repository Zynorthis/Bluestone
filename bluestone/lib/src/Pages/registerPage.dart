import 'package:bluestone/src/components/extras.dart';
import 'package:bluestone/src/Pages/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      backgroundColor: ThemeSettings.themeData.backgroundColor,
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              width: 375.0,
              padding: EdgeInsets.all(16.0),
              child: TextFormField(
                validator: (input) {
                  if (input.isEmpty) {
                    return "Please provide an email address.";
                  } else if (!input.contains("@")) {
                    return "Please provide a valid email address.";
                  } else if (input.contains(" ")) {
                    return input = input.trim();
                  }
                },
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                  labelText: "Email Address",
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: "Input an Email Address",
                  icon: new Icon(
                    Icons.email,
                    color: ThemeSettings.themeData.accentColor,
                  ),
                ),
              ),
            ),
            Container(
              width: 375.0,
              padding: EdgeInsets.all(16.0),
              child: TextFormField(
                validator: (input) {
                  if (input.isEmpty) {
                    return "Please provide a password.";
                  } else if (input.length < 6 || input.length > 20) {
                    return "Passwords must be between 6-20 characters long.";
                  }
                },
                onSaved: (input) => _password = input,
                decoration: InputDecoration(
                  labelText: "Password",
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: "Input a Password",
                  icon: new Icon(
                    Icons.lock,
                    color: ThemeSettings.themeData.accentColor,
                  ),
                ),
                obscureText: true,
              ),
            ),
            RaisedButton(
              onPressed: registerFirebaseAccount,
              child: Text("Register"),
              color: ThemeSettings.themeData.accentColor,
            )
          ],
        ),
      ),
    );
  }

  void registerFirebaseAccount() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        user.sendEmailVerification();
        //Navigator.of(context).pop();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignInManager()));
      } catch (error) {
        print(error.message);
      }
    }
  }
}
