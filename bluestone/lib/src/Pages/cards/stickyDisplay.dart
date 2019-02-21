import 'package:bluestone/src/components/extras.dart';
import 'package:bluestone/src/components/firebaseContent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StickyDisplay extends StatefulWidget {
  const StickyDisplay(
      {UniqueKey key,
      @required String textBodyContent,
      @required String titleContent,
      @required bool visibility});

  @override
  _StickyDisplayState createState() => new _StickyDisplayState();
}

class _StickyDisplayState extends State<StickyDisplay> {
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _textBodyController = new TextEditingController();
  String textBodyContent = FirestoreContent.documentSnap.data["textBody"];
  String titleContent = FirestoreContent.documentSnap.data["title"];
  // false visabilty means private
  bool visibility = FirestoreContent.documentSnap.data["visibilty"];
  bool isEditting = false;

  @override
  Widget build(BuildContext context) {
    _titleController.text = titleContent;
    _textBodyController.text = textBodyContent;
    return Scaffold(
        appBar: AppBar(
          title: Text("${_titleController.text}"),
        ),
        backgroundColor: ThemeSettings.themeData.backgroundColor,
        floatingActionButton: new FloatingActionButton.extended(
            icon: (isEditting) ? new Icon(Icons.save) : new Icon(Icons.edit),
            onPressed: () {
              setState(() {
                isEditting = !isEditting;
                if (isEditting == false) {
                  _saveEditsToDb();
                  titleContent =_titleController.text;
                  textBodyContent =_textBodyController.text;
                }
              });
            },
            label: (isEditting) ? Text("Save") : Text("Edit")),
        body: Center(
          child: Column(
            children: <Widget>[
              // Padding holds container to hold title
              Container(
                height: 20.0,
                margin: const EdgeInsets.all(20.0),
                child: (isEditting)
                    ? new TextFormField(
                        controller: _titleController,
                        enableInteractiveSelection: true,
                        maxLength: 18,
                      )
                    : new Row(children: <Widget>[
                        Text(
                          _titleController.text,
                          textScaleFactor: 1.5,
                        ),
                      ]),
              ),
              // Padding holds child for textbox
              Container(
                height: 80.0,
                margin: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
                padding: EdgeInsets.only(bottom: 0.0),
                child: (isEditting)
                    ? new TextField(
                        controller: _textBodyController,
                        enableInteractiveSelection: false,
                        maxLines: 99,
                        decoration: InputDecoration(
                          hintText: "Textbox",
                          border: OutlineInputBorder(),
                        ),
                      )
                    : new Row(children: <Widget>[
                        Text(
                          "${_textBodyController.text}",
                          textScaleFactor: 1.0
                        ),
                      ]),
              ),
            ],
          ),
        ));
  }

  void enableEditting() {
    setState(() {
      isEditting = !isEditting;
      isEditting ? print("Editting Enabled") : print("Editting Disabled");
    });
  }

  void _saveEditsToDb() async {
    Map<String, String> data = <String, String>{
      "title": _titleController.value.text,
      "textBody": _textBodyController.value.text,
    };
    var id = FirestoreContent.documentSnap.documentID;
    FirestoreContent.firestoreDoc = Firestore.instance.document(
        "Cards/Personal/UIDs/${CurrentLoggedInUser.user.uid}/CardIDs/$id");
    FirestoreContent.firestoreDoc.updateData(data).whenComplete(() {
      print("Document Updated.");
      setState(() {});
    }).catchError((e) => print(e));
  }

  void _removeFromDb() async {
    var id = FirestoreContent.documentSnap.documentID;
    FirestoreContent.firestoreDoc = Firestore.instance.document(
        "Cards/Personal/UIDs/${CurrentLoggedInUser.user.uid}/CardIDs/$id");
    FirestoreContent.firestoreDoc.delete().whenComplete(() {
      print("Removed Document.");
      setState(() {});
    }).catchError((e) => print(e));
    Navigator.pop(context);
    //Navigator.push(context, MyHomePage());
  }
}
