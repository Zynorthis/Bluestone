import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  TextEditingController _controller = new TextEditingController();
  bool _enabled = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Testing Ground"),
      ),
      floatingActionButton: new FloatingActionButton.extended(
          icon: (_enabled) ? new Icon(Icons.save) : new Icon(Icons.edit),
          onPressed: () {
            setState(() {
              _enabled = !_enabled;
            });
          }, label: (_enabled) ? Text("Save") : Text("Edit")),
      body: new Center(
        child: new Container(
          margin: const EdgeInsets.all(10.0),
          child: _enabled
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
      ),
    );
  }
}
