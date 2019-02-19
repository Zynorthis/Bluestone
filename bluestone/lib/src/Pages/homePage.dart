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

// static final FirebaseUser user = MyHomePage
enum Choices { STICKY, BULLET, CHECKBOX }

class _MyHomePageState extends State<MyHomePage> {
  // _MyHomePageState({ this.user })
  static var user;
  List<IconButton> _cardItems = buildItems("Card", user);
  var _calendarItems = buildItems("Calendar", user);

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
            alignment: Alignment(0.85, -0.3),
            child: IconButton(
              icon: Icon(Icons.person),
              iconSize: 35.0,
              color: Colors.white,
              tooltip: "${widget.user.email} is logged in.",
              onPressed: () {
                print("Starting OnPress Action.");
                var thing = new SimpleDialog(
                  title: Text("Select a User Account"),
                  children: <Widget>[
                    SimpleDialogOption(
                        onPressed: null,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.person),
                            Text("${widget.user.email}"),
                          ],
                        )),
                  ],
                );
                assert(AlertDialog != null);
                print("Finishing Construction of OnPress Action");
                return showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return thing;
                    });
              },
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
              itemBuilder: (context, i) {
                if (i.isOdd) {
                  return Divider();
                }
                final index = i ~/ 2;
                return Container(
                  decoration: BoxDecoration(
                      color: ThemeSettings.themeData.accentColor,
                      shape: BoxShape.rectangle),
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
              itemBuilder: (context, i) {
                if (i.isOdd) {
                  return Divider();
                }
                final index = i ~/ 2;
                return new Container(
                  decoration: BoxDecoration(
                      color: ThemeSettings.themeData.accentColor,
                      shape: BoxShape.rectangle),
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

  Future<Null> showDialogBox() async {
    switch (await showDialog(
      context: context,
      barrierDismissible: true,
      child: new SimpleDialog(
        title: Text("Select a Card Type"),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, Choices.STICKY);
            },
            child: const Text("Sticky"),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, Choices.BULLET);
            },
            child: const Text("Bullet"),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, Choices.CHECKBOX);
            },
            child: const Text("Checkbox"),
          ),
        ],
      ),
    )) {
      case Choices.STICKY:
        print("Card Type - Sticky - was selected.");
        break;
      case Choices.BULLET:
        print("Card Type - Bullet - was selected.");
        break;
      case Choices.CHECKBOX:
        print("Card Type - Checkbox - was selected.");
        break;
    }
  }

  List<IconButton> buildItems(String type, FirebaseUser user) {
    var list = new List<IconButton>();
    // var userId = user.uid;
    // if (type == "Card") {
    //   final Future<QuerySnapshot> privateResults =
    //       fireStoreSnapshot("Cards/Private/UIDs/", "UID", userId);
    //   // final Future<QuerySnapshot> publicResults = fireStoreSnapshot("Cards/Public/UIDs/", "UID", userId);
    //   // FirebaseDatabase.instance.reference().child("card").reference().child("private").reference().child("UID").once().then((DataSnapshot snapshot) {

    //   // });
    //   // FirebaseDatabase.instance.reference().child("card").reference().child("public").reference().child("UID").once();

    // } else if (type == "Calendar") {
    //   // add all of the calendars save for a user here.
    // } else {
    //   print(
    //       "Error: invalid type - Type being passed in was unable to be determined. (menuBuilder.dart - line 24)");
    //   throw new Exception(
    //       "Error: invalid type - Type being passed in was unable to be determined.");
    // }

    var addIcon = new IconButton(
        icon: Icon(Icons.add),
        iconSize: 125.0,
        color: Colors.blueAccent,
        //padding: EdgeInsets.all(25.0),
        tooltip: "Tap me to create a new $type!",
        onPressed: showDialogBox //create new item
        );

    list.add(addIcon);
    return list;
  }
}
