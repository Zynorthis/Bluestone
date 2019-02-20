import 'package:bluestone/src/Pages/cards/stickyDisplay.dart';
import 'package:bluestone/src/Pages/welcomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
                        onPressed: () {
                          print("User was selected.");
                          Navigator.pop(context);
                          return showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context){
                              return new AlertDialog(
                                content: new Text("Would you like to log out?"),
                                actions: <Widget>[
                                  new FlatButton(
                                    child: new Text("No"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  new FlatButton(
                                    child: new Text("Yes"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomePage()));
                                    },
                                  )
                                ],
                              );
                            }
                          );
                        },
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
            FutureBuilder(
              future: getCardPost(widget.user),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return new SizedBox(
                    child: CircularProgressIndicator(),
                    height: 50.0,
                    width: 50.0,
                  );
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return new Text(" Error: Connnection Timeout. ");
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      return (!snapshot.hasData)
                          ? Center(
                              child: Text(" No Cards avaible :( "),
                            )
                          : Container(
                              margin:
                                  EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
                              decoration: BoxDecoration(
                                  color: ThemeSettings.themeData.accentColor,
                                  shape: BoxShape.rectangle),
                              child: IconButton(
                                icon: Icon(Icons.home),
                                iconSize: 125.0,
                                color: Colors.blueAccent,
                                tooltip: "A Bluestone Card.",
                                onPressed: () {
                                  print("${snapshot.data[index]}");
                                },
                              ),
                            );
                    },
                  );
                }
              },
            ),
            FutureBuilder(
              future: getCalendarPost(widget.user),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return new SizedBox(
                    child: CircularProgressIndicator(),
                    height: 50.0,
                    width: 50.0,
                  );
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return new Text(" Error: Connnection Timeout. ");
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      return (!snapshot.hasData)
                          ? Center(
                              child: Text(" No Calendars avaible :( "),
                            )
                          : Container(
                              margin:
                                  EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
                              decoration: BoxDecoration(
                                  color: ThemeSettings.themeData.accentColor,
                                  shape: BoxShape.rectangle),
                              child: IconButton(
                                icon: Icon(Icons.home),
                                iconSize: 125.0,
                                color: Colors.blueAccent,
                                tooltip: "A Bluestone Calendar.",
                                onPressed: () {
                                  print("${snapshot.data[index]}");
                                },
                              ),
                            );
                    },
                  );
                }
              },
            ),
            // ListView.builder(
            //   padding: const EdgeInsets.all(16.0),
            //   itemCount: cardLengthReturn(),
            //   itemBuilder: (context, i) {
            //     if (i.isOdd) {
            //       return Divider();
            //     }
            //     final index = i ~/ 2;
            //     return Container(
            //       decoration: BoxDecoration(
            //           color: ThemeSettings.themeData.accentColor,
            //           shape: BoxShape.circle),
            //       child: IconButton(
            //         icon: widget._cardItems[index].icon,
            //         iconSize: widget._cardItems[index].iconSize,
            //         color: widget._cardItems[index].color,
            //         splashColor: widget._cardItems[index].splashColor,
            //         padding: widget._cardItems[index].padding,
            //         tooltip: widget._cardItems[index].tooltip,
            //         onPressed: widget._cardItems[index].onPressed,
            //       ),
            //     );
            //   },
            // ),
            // ListView.builder(
            //   padding: const EdgeInsets.all(16.0),
            //   itemCount: calendarLengthReturn(),
            //   itemBuilder: (context, i) {
            //     if (i.isOdd) {
            //       return Divider();
            //     }
            //     final index = i ~/ 2;
            //     return new Container(
            //       decoration: BoxDecoration(
            //           color: ThemeSettings.themeData.accentColor,
            //           shape: BoxShape.rectangle),
            //       child: IconButton(
            //         icon: widget._calendarItems[index].icon,
            //         iconSize: widget._calendarItems[index].iconSize,
            //         color: widget._calendarItems[index].color,
            //         splashColor: widget._calendarItems[index].splashColor,
            //         padding: widget._calendarItems[index].padding,
            //         tooltip: widget._calendarItems[index].tooltip,
            //         onPressed: widget._calendarItems[index].onPressed,
            //       ),
            //     );
            //   },
            // ),
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
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => StickyDisplay()));
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

  Future getCardPost(FirebaseUser user) async {
    var collectionOfPrivateCards = await Firestore.instance
        .collection("Cards/Private/UIDs/${user.uid}/CardIDs")
        .getDocuments();
    return collectionOfPrivateCards.documents;
  }

  Future getCalendarPost(FirebaseUser user) async {
    var collectionOfPrivateCards = await Firestore.instance
        .collection("Cards/Private/UIDs/${user.uid}/CardIDs")
        .getDocuments();
    return collectionOfPrivateCards.documents;
  }

  List<IconButton> buildItems(String type, FirebaseUser user) {
    var list = new List<IconButton>();

    var userId = user.uid;
    if (type == "Card") {
      var collectionOfPrivateCards = Firestore.instance
          .collection("Cards/Private/UIDs/${user.uid}/CardIDs")
          .getDocuments();
      var collectionOfPublicCards = Firestore.instance
          .collection("Cards/Public/UIDs/${user.uid}/CardIDs")
          .getDocuments();
    } else if (type == "Calendar") {
      // add all of the calendars save for a user here.
    } else {
      print(
          "Error: invalid type - Type being passed in the buildItems paremeters was unable to be determined.");
      throw new Exception(
          "Error: invalid type - Type being passed in the buildItems paremeters was unable to be determined.");
    }

    var addIcon = new IconButton(
        icon: Icon(Icons.add),
        iconSize: 125.0,
        color: Colors.blueAccent,
        //padding: EdgeInsets.all(25.0),
        tooltip: "Tap me to create a new $type!",
        onPressed: (type == "Card") // create a new item on tap
            ? showDialogBoxCard
            : showDialogBoxCalendar);

    list.add(addIcon);
    return list;
  }

  void createStickyCard() {}

  int cardLengthReturn() {
    widget._cardItems = buildItems("Card", widget.user);
    return widget._cardItems.length;
  }

  int calendarLengthReturn() {
    widget._calendarItems = buildItems("Calendar", widget.user);
    return widget._calendarItems.length;
  }
}
