import 'package:bluestone/src/Pages/homePage.dart';
import 'package:bluestone/src/components/extras.dart';
import 'package:bluestone/src/components/firebaseContent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInManager extends StatefulWidget {
  @override
  _SignInManagerState createState() => new _SignInManagerState();
}

class _SignInManagerState extends State<SignInManager> {
  String _email, _password;
  bool isValid = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
        textTheme: ThemeSettings.customTheme,
      ),
      backgroundColor: ThemeSettings.themeData.backgroundColor,
      body: Form(
        key: _formKey,
        //child: SingleChildScrollView(
          child: 
          Column(
            children: <Widget>[
              // SizedBox(
              //   height: 50.0,
              // ),
              Container(
                child: (isValid)
                    ? Text("")
                    : Text(
                        "Unable to sign in, please try again.",
                        style: TextStyle(color: Colors.red),
                      ),
              ),
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
                      input.trim();
                      input.trimLeft();
                      input.trimRight();
                      return input;
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
                      color: ThemeSettings.themeData.primaryColor,
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              RaisedButton(
                onPressed: () async {
                  CurrentLoggedInUser.user = null;
                  await signIn();
                  while (CurrentLoggedInUser.user == null) {
                    // showLoadingIndicator();
                  }
                  // final snackBar = SnackBar(content: Text("Logging in..."));
                  // Scaffold.of(context).showSnackBar(snackBar);
                },
                child: Text("Sign In"),
                color: ThemeSettings.themeData.accentColor,
              )
            ],
          ),
        //),
      ),
    );
  }

  Widget showLoadingIndicator() {
    return new Center(
      child: CircularProgressIndicator(),
    );
  }

  Future<void> signIn() async {
    final _formState = _formKey.currentState;
    if (_formState.validate()) {
      _formState.save();
      try {
        // here I capture the FirebaseUser we get back with the
        // user attached to the CurrentLoggedInUser class. This
        // is so anywhere else in the app when needed we can easily
        // grab the current logged in user details and use them.

        CurrentLoggedInUser.user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.of(context).pop();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(
                      title: ThemeSettings.defaultTitle,
                      user: CurrentLoggedInUser.user,
                    )));
      } catch (error) {
        print(error.message);
        isValid = false;
        return;
      }
    }
  }
}
