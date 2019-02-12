import 'package:bluestone/main.dart';
import 'package:bluestone/src/components/extras.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInManager extends StatefulWidget {
  @override
  _SignInManagerState createState() => new _SignInManagerState();
}

class _SignInManagerState extends State<SignInManager> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
        textTheme: ThemeSettings.customTheme,
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
                ),
                obscureText: true,
              ),
            ),
            RaisedButton(
              onPressed: signIn,
              child: Text("Sign In"),
              color: ThemeSettings.themeData.accentColor,
            )
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    final _formState = _formKey.currentState;
    if (_formState.validate()) {
      _formState.save();
      // // If the form is valid, we want to show a Snackbar
      // if(_formKey.currentState.validate()){
      //   Scaffold.of(context).showSnackBar(
      //     SnackBar(content: Text('Login Successful, please wait...')));
      // }
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        // Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(
                    title: ThemeSettings.defaultTitle,
                    user: user,
                  )));
      } catch (error) {
        print(error.message);
      }
    }
  }
}
