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
  String _tempEmail, _tempPassword, _tempValidationPass;
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
            SizedBox(height: 50.0,),
            Container(
              width: 375.0,
              padding: EdgeInsets.all(16.0),
              child: TextFormField(
                validator: (input) {
                  _tempEmail = input;
                  if (_tempEmail.isEmpty) {
                    return "Please provide an email address.";
                  } else if (!_tempEmail.contains("@")) {
                    return "Please provide a valid email address.";
                  } else if (_tempEmail.contains(" ")) {
                    input.trim();
                    input.trimRight();
                    input.trimLeft();
                    _tempEmail = input;
                    return _tempEmail;
                  }
                },
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                  labelText: "Email Address",
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: "Input an Email Address",
                  icon: new Icon(
                    Icons.email,
                    color: ThemeSettings.themeData.primaryColor,
                  ),
                ),
              ),
            ),
            Container(
              width: 375.0,
              padding: EdgeInsets.all(16.0),
              child: TextFormField(
                validator: (input) {
                  _tempPassword = input;
                  if (_tempPassword.isEmpty) {
                    return "Please provide a password.";
                  } else if (_tempPassword.length < 6 || _tempPassword.length > 20) {
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
                    color: ThemeSettings.themeData.primaryColor,
                  ),
                ),
                obscureText: true,
              ),
            ),
            Container(
              width: 375.0,
              padding: EdgeInsets.all(16.0),
              child: TextFormField(
                validator: (input) {
                  _tempValidationPass = input;
                  if (_tempValidationPass != _tempPassword) {
                    return "Passwords do not match.";
                  } else if (_tempValidationPass.length < 6 || _tempValidationPass.length > 20) {
                    return "Passwords must be between 6-20 characters long.";
                  }
                },
                onSaved: (input) => _password = input,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: "Confirm Password by re-typing it",
                  icon: new Icon(
                    Icons.lock,
                    color: ThemeSettings.themeData.primaryColor,
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
