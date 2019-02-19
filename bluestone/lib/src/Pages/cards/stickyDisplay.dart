import 'package:bluestone/src/Pages/homePage.dart';
import 'package:bluestone/src/components/extras.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StickyDisplay extends StatefulWidget {
  const StickyDisplay({UniqueKey key});

  @override
  _StickyDisplayState createState() => new _StickyDisplayState();
}

class _StickyDisplayState extends State<StickyDisplay> {
  static const String _cardTitle = "Testing...";
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _textBodyController = new TextEditingController();
  bool isEditting = false;
  final DocumentReference firestoreDoc = Firestore.instance.document("TestData/TestDocument");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_cardTitle),
        ),
        backgroundColor: ThemeSettings.themeData.backgroundColor,
        floatingActionButton: new FloatingActionButton.extended(
            icon: (isEditting) ? new Icon(Icons.save) : new Icon(Icons.edit),
            onPressed: () {
              setState(() {
                isEditting = !isEditting;
                if (isEditting == false){
                  _saveEditsToDb();
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
                margin: const EdgeInsets.all(10.0),
                child: (isEditting)
                    ? new TextFormField(
                        controller: _titleController,
                        enableInteractiveSelection: false,
                        maxLength: 18,
                      )
                    : new Row(children: <Widget>[
                        Text(
                          _titleController.value.text,
                          textScaleFactor: 1.5,
                        ),
                      ]),
              ),
              // Padding holds child for textbox
              Container(
                height: 80.0,
                margin: const EdgeInsets.all(10.0),
                child: (isEditting)
                    ? 
              new TextField(
                  controller: _textBodyController,
                  enableInteractiveSelection: false,
                )
              : new Row(children: <Widget>[
                  Text(_textBodyController.value.text, textScaleFactor: 1.5,),
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
      "title" : _titleController.value.text,
      "textBody" : _textBodyController.value.text,
    };
    firestoreDoc.updateData(data).whenComplete(() {
      print("Document Updated.");
      setState(() {});
    }).catchError((e) => print(e));
  }
  void _removeFromDb() async {
    firestoreDoc.delete().whenComplete(() {
      print("Removed Document.");
      setState(() {});
    }).catchError((e) => print(e));
    Navigator.pop(context);
    //Navigator.push(context, MyHomePage());
  }
}
