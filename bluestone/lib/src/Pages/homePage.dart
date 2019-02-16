import 'package:firebase_auth/firebase_auth.dart';
import 'package:bluestone/src/components/menuBuilder.dart';
import 'package:bluestone/src/components/extras.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.user}) : super(key: key);

  final FirebaseUser user;
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  var _cardItems = MenuBuilder.buildItems("Card");
  var _calendarItems = MenuBuilder.buildItems("Calendar");

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            textAlign: TextAlign.left,
            ),
          flexibleSpace: Container(
            alignment: Alignment(0.85,-0.3),
            child: IconButton(
              icon: Icon(Icons.person),
              iconSize: 35.0,
              color: Colors.blueAccent,
              tooltip: "${widget.user.email} is logged in.",
              onPressed: null,
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.view_list)),
              Tab(icon: Icon(Icons.calendar_today)),
            ],
          ),
        ),  
        backgroundColor: ThemeSettings.themeData.backgroundColor,
        body: TabBarView(
          children: [
            ListView.builder( 
              padding: const EdgeInsets.all(16.0),
              itemCount: _cardItems.length,
              itemBuilder: (context, i){
                if (i.isOdd){
                  return Divider();
                }
                final index = i~/2;
                return Container(
                  decoration: BoxDecoration(
                    color: ThemeSettings.themeData.accentColor,
                    shape: BoxShape.rectangle
                  ),
                  child: IconButton(
                    icon: _cardItems[index].icon,
                    iconSize: _cardItems[index].iconSize,
                    color: _cardItems[index].color,
                    splashColor: _cardItems[index].splashColor,
                    padding: _cardItems[index].padding,
                    tooltip: _cardItems[index].tooltip,
                    onPressed: _cardItems[index].onPressed,
                  ),
                ); 
              },
            ), 
            ListView.builder( 
              padding: const EdgeInsets.all(16.0),
              itemCount: _calendarItems.length,
              itemBuilder: (context, i){
                if (i.isOdd){
                  return Divider();
                }
                final index = i~/2;
                return new Container(
                  decoration: BoxDecoration(
                    color: ThemeSettings.themeData.accentColor,
                    shape: BoxShape.rectangle
                  ),
                  child: IconButton(
                    icon: _calendarItems[index].icon,
                    iconSize: _calendarItems[index].iconSize,
                    color: _calendarItems[index].color,
                    splashColor: _calendarItems[index].splashColor,
                    padding: _calendarItems[index].padding,
                    tooltip: _calendarItems[index].tooltip,
                    onPressed: _calendarItems[index].onPressed,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
