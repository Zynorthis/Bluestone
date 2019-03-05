import 'package:bluestone/src/components/extras.dart';
import 'package:bluestone/src/components/firebaseContent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CheckboxPage extends StatefulWidget {
  @override
  _CheckboxPageState createState() => _CheckboxPageState();
}

class _CheckboxPageState extends State<CheckboxPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${ThemeSettings.defaultTitle}"),
        actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                print("Delete button Tapped.");
                return showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return new AlertDialog(
                        content:
                            new Text("Are you sure you want to delete this?"),
                        actions: <Widget>[
                          new FlatButton(
                            child: new Text("Yes"),
                            onPressed: () {
                              print(
                                  "Removing ${FirestoreContent.checkboxSnap.documentID}...");
                              FirestoreContent.checkboxDoc = Firestore.instance
                                  .document(
                                      "Calendars/Live/UIDs/${CurrentLoggedInUser.user.uid}/CalendarIDs/${FirestoreContent.checkboxSnap.documentID}");
                              FirestoreContent.checkboxDoc
                                  .delete()
                                  .whenComplete(() {
                                setState(() {});
                              }).catchError((e) => print(e));
                              print("Document Deleted.");
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          ),
                          new FlatButton(
                            child: new Text("No"),
                            onPressed: () {
                              print(
                                  "${FirestoreContent.checkboxSnap.documentID} will not be deleted.");
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });
              },
              color: Colors.white,
              tooltip: "Tap to Delete",
              iconSize: 25.0,
            ),
        ],
      ),
    );
  }
}