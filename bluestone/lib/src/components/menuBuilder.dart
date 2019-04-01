import 'package:bluestone/src/components/firebaseContent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// MenuBuilder is a class used to call various static methods used
/// to make home screen menu items.
///
/// see [buildItems] and [creatItemMenu] for more details.

class MenuBuilder {
  /// The buildItems method is used to create a new list of [IconButton]s with
  /// the last one being a default IconButton used to make new Card or Calendar
  /// items.
  ///
  /// BuildItems takes in a [String] in its paramiter which is used to determine
  /// which type of IconButton it will be building a list for.
  static List<IconButton> buildItems(String type, FirebaseUser user) {
    var list = new List<IconButton>();
    var addIcon = new IconButton(
        icon: Icon(Icons.add),
        iconSize: 125.0,
        color: Colors.blueAccent,
        //padding: EdgeInsets.all(25.0),
        tooltip: "Tap me to create a new $type!",
        onPressed: null //create new item
        );

    list.add(addIcon);
    return list;
  }

  static Future<QuerySnapshot> fireStoreSnapshot(
      String awaitPart1, String documentField, String userId) async {
    return await Firestore.instance
        .collection(awaitPart1)
        .where(documentField, isEqualTo: userId)
        .getDocuments();
  }
}

@override
Widget build(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    //stream: Firestore.instance.collection("$path/$visablity/$uid").snapshots(),
    builder: (context, snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return new Center(child: new CircularProgressIndicator());
        default:
          //return new ListView(children: getExpenseItems(snapshot))
          break;
      }
    },
  );
}

Widget menuAction(BuildContext context) {
  return IconButton(
    icon: Icon(
      Theme.of(context).platform == TargetPlatform.iOS
          ? Icons.more_horiz
          : Icons.more_vert,
      semanticLabel: 'Show menu actions',
    ),
    onPressed: () {},
  );
}

Widget popupMenubutton(BuildContext context) {
  return PopupMenuButton(
    onSelected: choiceAction,
    itemBuilder: (BuildContext context) {
      return PopupMenuChoices.popupMenuChoices.map((String choice){
        return PopupMenuItem(
          value: choice,
          child: Text(choice),
        );
      }).toList();
    },
    tooltip: "Tap for more options",
  );
}

choiceAction(String choice) {
  print("$choice was selected");
}

class PopupMenuChoices{
  static const String az = "A-Z";
  static const String za = "Z-A";
  static List<String> popupMenuChoices = <String>[
    az,
    za,
  ];
}

Widget deleteButton(BuildContext context) {
  return IconButton(
    icon: Icon(
      Icons.delete,
      semanticLabel: "Delete Button",
      color: Colors.white,
    ),
    tooltip: "Tap to Delete Card",
    onPressed: () {
      print("Delete Button Tapped.");
      return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return new AlertDialog(
            content: new Text("Are you sure you want to delete this?"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Yes"),
                onPressed: () {
                  print("Begin Deletion.");
                  documentDeletion();
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
              new FlatButton(
                child: new Text("No"),
                onPressed: () {
                  print("Deletion Cancelled.");
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    },
  );
}