import 'package:bluestone/src/Pages/cards/stickyDisplay.dart';
import 'package:bluestone/src/Pages/welcomePage.dart';
import 'package:bluestone/src/components/firebaseContent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                var thing = new SimpleDialog(
                  title: Text("Select a User Account"),
                  children: <Widget>[
                    SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context);
                          return showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return new AlertDialog(
                                  content:
                                      new Text("Would you like to log out?"),
                                  actions: <Widget>[
                                    new FlatButton(
                                      child: new Text("No"),
                                      onPressed: () {
                                        print("User chose not to log out.");
                                        Navigator.pop(context);
                                      },
                                    ),
                                    new FlatButton(
                                      child: new Text("Yes"),
                                      onPressed: () {
                                        print(
                                            "Current user: ${widget.user.email} has logged out.");
                                        Navigator.pop(context);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    WelcomePage()));
                                      },
                                    )
                                  ],
                                );
                              });
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
                    height: 0.5,
                    width: 0.5,
                  );
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return new Text(" Error: Connnection Timeout. ");
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      return (!snapshot.hasData)
                          ? Container(
                              margin:
                                  EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
                              decoration: BoxDecoration(
                                  color: ThemeSettings.themeData.accentColor,
                                  shape: BoxShape.rectangle),
                              child: IconButton(
                                icon: Icon(Icons.add),
                                iconSize: 125.0,
                                color: Colors.blueAccent,
                                tooltip: "A Bluestone Card.",
                                onPressed: () {
                                  print("New card button pressed.");
                                  showDialogBoxCard();
                                },
                              ),
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
                                  print(
                                      "${snapshot.data[index].data["title"]} was tapped.");
                                  FirestoreContent.documentSnap = snapshot.data[index];
                                  if (snapshot.data[index].data["type"] == "Sticky"){
                                    var title = snapshot.data[index].data["title"];
                                    var visibility = snapshot.data[index].data["visibility"];
                                    var textBody = snapshot.data[index].data["textBody"];
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => StickyDisplay(
                                                titleContent: title,
                                                visibility: visibility,
                                                textBodyContent: textBody,
                                              )));
                                  } else if (snapshot.data[index].data["type"] == "Bullet"){

                                  } else if (snapshot.data[index].data["type"] == "Checkbox") {

                                  }
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
                    itemCount: snapshot.data.length + 1,
                    itemBuilder: (_, index) {
                      return (!snapshot.hasData)
                          ? Container(
                              margin:
                                  EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
                              decoration: BoxDecoration(
                                  color: ThemeSettings.themeData.accentColor,
                                  shape: BoxShape.rectangle),
                              child: IconButton(
                                icon: Icon(Icons.add),
                                iconSize: 125.0,
                                color: Colors.blueAccent,
                                tooltip: "A Bluestone Calendar.",
                                onPressed: () {
                                  print("New calendar button pressed.");
                                  showDialogBoxCalendar();
                                },
                              ),
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
                                  print(
                                      "${snapshot.data[index].data["title"]} was tapped.");
                                },
                              ),
                            );
                    },
                  );
                }
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
        String title = "New Card";
        String textBody = "Enter text here!";
        bool visibility =
            false; // false visabilty means private, new cards are set to private by default
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StickyDisplay(
                      titleContent: title,
                      textBodyContent: textBody,
                      visibility: visibility,
                    )));
        break;
      case CardChoices.BULLET:
        print("Card Type - Bullet - was selected.");
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => StickyDisplay()));
        break;
      case CardChoices.CHECKBOX:
        print("Card Type - Checkbox - was selected.");
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => StickyDisplay()));
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
    var collectionOfCards = await Firestore.instance
        .collection("Cards/Personal/UIDs/${user.uid}/CardIDs")
        .getDocuments();
    return collectionOfCards.documents;
  }

  Future getCalendarPost(FirebaseUser user) async {
    var collectionOfCalendars = await Firestore.instance
        .collection("Cards/Personal/UIDs/${user.uid}/CardIDs")
        .getDocuments();
    return collectionOfCalendars.documents;
  }
}
