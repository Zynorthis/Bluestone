import 'package:bluestone/src/components/extras.dart';
import 'package:bluestone/src/components/firebaseContent.dart';
import 'package:bluestone/src/components/menuBuilder.dart';
import 'package:flutter/material.dart';

class BulletPage extends StatefulWidget {
  @override
  _BulletPageState createState() => _BulletPageState();
}

class _BulletPageState extends State<BulletPage> {
  @override
  Widget build(BuildContext context) {
    documentReference = "Bullet";
    return Scaffold(
      appBar: AppBar(
        title: Text("${ThemeSettings.defaultTitle}"),
        actions: <Widget>[
          deleteButton(context),
        ],
      ),
    );
  }
}
