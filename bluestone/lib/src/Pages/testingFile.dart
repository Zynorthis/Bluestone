import 'package:bluestone/src/components/extras.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dev Testing Page"),
      ),
      backgroundColor: ThemeSettings.themeData.backgroundColor,
      body: null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: ThemeSettings.themeData.accentColor,
        label: const Text("Add"),
        icon: Icon(Icons.add),
        onPressed: null,
      ),
      bottomNavigationBar: BottomAppBar(
        child: null,
      ),
    );
  }

}
