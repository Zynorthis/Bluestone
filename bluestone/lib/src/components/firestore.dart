import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@override
Widget build(BuildContext context){
  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection("$path/$visablity/$uid").snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return new Center( child: new CircularProgressIndicator() );
        default:
          return new ListView(children: getExpenseItems(snapshot))
      }
      //return snapshot.data.documents.map((document) => new Text(document['some_field'])).toList()
      //return snapshot.data.documents.map((document) => new Text(document['some_field']).toList(),
    },
  );
}