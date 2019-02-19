import 'package:bluestone/src/components/extras.dart';
import 'package:flutter/material.dart';

class StickyDisplay extends StatefulWidget {
  const StickyDisplay({UniqueKey key, this.cardType, this.cardTitle});

  final String cardType;
  final String cardTitle;
  @override
  _StickyDisplayState createState() => new _StickyDisplayState();
}

class _StickyDisplayState extends State<StickyDisplay> {
  String _cardTitle = "Testing...";
  TextEditingController _controller = new TextEditingController();
  bool isEditting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: new Text("_cardTitle"),
        ),
        backgroundColor: ThemeSettings.themeData.backgroundColor,
        floatingActionButton: new FloatingActionButton.extended(
            icon: (isEditting) ? new Icon(Icons.save) : new Icon(Icons.edit),
            onPressed: () {
              setState(() {
                isEditting = !isEditting;
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
                        controller: _controller,
                        enableInteractiveSelection: false,
                        maxLength: 18,
                      )
                    : new Row(children: <Widget>[
                        Text(
                          _controller.value.text,
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
              new TextFormField(
                  controller: _controller,
                  enableInteractiveSelection: false,
                  maxLength: 18,
                )
              : new Row(children: <Widget>[
                  Text(_controller.value.text, textScaleFactor: 1.5,),
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
}
