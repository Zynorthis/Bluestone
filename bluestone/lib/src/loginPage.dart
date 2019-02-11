import 'package:bluestone/main.dart';
import 'package:bluestone/src/components/extras.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInManager extends StatefulWidget{
  @override
  _SignInManagerState createState() => new _SignInManagerState();
}

class _SignInManagerState extends State<SignInManager> {

  @override
  Widget build(BuildContext context) {

    String _email, _password;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
        textTheme: ThemeSettings.customTheme,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (input){
                if(input.isEmpty){
                  return "Please provide an email address.";
                }
                else if(!input.contains("@")){
                  return "Please provide a valid email address.";
                }
              },
              onSaved: (input) => _email = input,
              decoration: InputDecoration(
                labelText: "Email Address",
              ),
            ),
            TextFormField(
              validator: (input){
                if(input.isEmpty){
                  return "Please provide a password.";
                }
                else if(input.length < 6 || input.length > 20){
                  return "Passwords must be between 6-20 characters long.";
                }
              },
              onSaved: (input) => _password = input,
              decoration: InputDecoration(
                labelText: "Password",
              ),
              obscureText: true,
            ),
            RaisedButton(
              onPressed: () {},
              child: Text("Sign In"),
            )
          ],
        ),
      ),
    );

    Future<void> signIn() async {
      final _formState = _formKey.currentState;
      if (_formState.validate()){
        _formState.save();
        try{
          FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
        }
        catch(e) {
          print(e.message);
        }
      }
    }
  }
}