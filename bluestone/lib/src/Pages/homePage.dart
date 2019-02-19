import 'package:firebase_auth/firebase_auth.dart';
import 'package:bluestone/src/components/menuBuilder.dart';
import 'package:bluestone/src/components/extras.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.user}) : super(key: key);

  final FirebaseUser user;
  final String title;
  List<IconButton> _cardItems;
  List<IconButton> _calendarItems;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// static final FirebaseUser user = MyHomePage
enum CardChoices { STICKY, BULLET, CHECKBOX }

class _MyHomePageState extends State<MyHomePage> {

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
                        onPressed: () {print("User was selected."); Navigator.pop(context);},
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
              itemCount: cardLengthReturn(),
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
                    icon: widget._cardItems[index].icon,
                    iconSize: widget._cardItems[index].iconSize,
                    color: widget._cardItems[index].color,
                    splashColor: widget._cardItems[index].splashColor,
                    padding: widget._cardItems[index].padding,
                    tooltip: widget._cardItems[index].tooltip,
                    onPressed: widget._cardItems[index].onPressed,
                  ),
                );
              },
            ),
            ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: calendarLengthReturn(),
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
                    icon: widget._calendarItems[index].icon,
                    iconSize: widget._calendarItems[index].iconSize,
                    color: widget._calendarItems[index].color,
                    splashColor: widget._calendarItems[index].splashColor,
                    padding: widget._calendarItems[index].padding,
                    tooltip: widget._calendarItems[index].tooltip,
                    onPressed: widget._calendarItems[index].onPressed,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> showDialogBoxCard() async {
    switch (await showDialog(
      context: context,
      barrierDismissible: true,
      child: new SimpleDialog(
        title: Text("Select a Card Type"),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, CardChoices.STICKY);
            },
            child: const Text("Sticky"),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, CardChoices.BULLET);
            },
            child: const Text("Bullet"),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, CardChoices.CHECKBOX);
            },
            child: const Text("Checkbox"),
          ),
        ],
      ),
    )) {
      case CardChoices.STICKY:
        print("Card Type - Sticky - was selected.");
        break;
      case CardChoices.BULLET:
        print("Card Type - Bullet - was selected.");
        break;
      case CardChoices.CHECKBOX:
        print("Card Type - Checkbox - was selected.");
        break;
    }
  }

    Future<Null> showDialogBoxCalendar() async {
    switch (await showDialog(
      context: context,
      barrierDismissible: true,
      child: new SimpleDialog(
        title: Text("Select a Card Type"),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, CardChoices.STICKY);
            },
            child: const Text("Sticky"),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, CardChoices.BULLET);
            },
            child: const Text("Bullet"),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, CardChoices.CHECKBOX);
            },
            child: const Text("Checkbox"),
          ),
        ],
      ),
    )) {
      case CardChoices.STICKY:
        print("Card Type - Sticky - was selected.");
        break;
      case CardChoices.BULLET:
        print("Card Type - Bullet - was selected.");
        break;
      case CardChoices.CHECKBOX:
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
        onPressed: (type == "Card") ? showDialogBoxCard : showDialogBoxCalendar//create new item
        );

    list.add(addIcon);
    return list;
  }

  void createStickyCard(){

  }

  int cardLengthReturn(){
    widget._cardItems = buildItems("Card", widget.user); 
    return widget._cardItems.length;
  }

  int calendarLengthReturn(){
    widget._calendarItems = buildItems("Calendar", widget.user);
    return widget._calendarItems.length;
  }
}
