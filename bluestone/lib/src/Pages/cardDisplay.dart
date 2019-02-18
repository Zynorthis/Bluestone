import 'package:bluestone/src/components/extras.dart';
import 'package:flutter/material.dart';

class CardDisplay extends StatefulWidget {
  const CardDisplay({UniqueKey key, this.cardType, this.cardTitle});

  final String cardType;
  final String cardTitle;
  @override
  _CardDisplayState createState() => new _CardDisplayState();
}

class _CardDisplayState extends State<CardDisplay> {
  String _cardTitle = "Testing...";
  bool isEditting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: new Text("_cardTitle"),
        ),
        backgroundColor: ThemeSettings.themeData.backgroundColor,
        body: Center(
          child: Column(
            
            children: <Widget>[
              // Padding holds container to hold title
              Container(
                height: 20.0,
                child: (isEditting)
                    ? new Row(
                        children: <Widget>[TextField(), IconButton(icon: Icon(Icons.save), onPressed: enableEditting,)],
                      )
                    : new Row(
                        children: <Widget>[Text("Placeholder Title"), IconButton(icon: Icon(Icons.edit), onPressed: enableEditting,)],
                      ),
              ),
              // Padding holds child for textbox
              Container(
                height: 80.0,
                child: (isEditting)
                    ? new Row(
                        children: <Widget>[TextField(), IconButton(icon: Icon(Icons.save), onPressed: enableEditting,)],
                      )
                    : new Row(
                        children: <Widget>[Text("Placeholder Body Text"), IconButton(icon: Icon(Icons.edit), onPressed: enableEditting,)],
                      ),
              ),
            ],
          ),
        ));
  }
  void enableEditting(){
    setState(() {
      isEditting = !isEditting;
      isEditting ? print("Editting Enabled") : print("Editting Disabled"); 
    }); 
  }
}
