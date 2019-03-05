import 'package:bluestone/src/Pages/calendars/calendarDisplay.dart';
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
  TextEditingController _searchBar = new TextEditingController();
  bool haveResults = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
                                        CurrentLoggedInUser.user = null;
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
              Tab(text: "Cards",),
              Tab(text: "Calendars",),
              Tab(text: "Search",),
            ],
          ),
        ),
        backgroundColor: ThemeSettings.themeData.backgroundColor,
        body: TabBarView(
          children: [
            FutureBuilder(
              future: getCardPost(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return new Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return new Text(" Error: Connnection Timeout. ");
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length + 1,
                    itemBuilder: (_, index) {
                      return (index == snapshot.data.length)
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Container(
                                margin:
                                    EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
                                decoration: BoxDecoration(
                                    color: ThemeSettings.themeData.accentColor,
                                    shape: BoxShape.rectangle),
                                child: FlatButton.icon(
                                  label: Expanded(
                                    child: Text(
                                      "Add A New Card",
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.add,
                                    size: 75.0,
                                  ),
                                  onPressed: () {
                                    print("New card button pressed.");
                                    showDialogBoxCard();
                                  },
                                ),
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Container(
                                margin:
                                    EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
                                decoration: BoxDecoration(
                                    color: ThemeSettings.themeData.accentColor,
                                    shape: BoxShape.rectangle),
                                child: FlatButton.icon(
                                  clipBehavior: Clip.antiAlias,
                                  label: Expanded(
                                    child: Text(
                                      "${snapshot.data[index].data["title"]}",
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.view_headline,
                                    size: 75.0,
                                  ),
                                  onPressed: () {
                                    print(
                                        "${snapshot.data[index].data["title"]} was tapped. DocumentID: ${snapshot.data[index].documentID}");
                                    FirestoreContent.cardSnap =
                                        snapshot.data[index];
                                    if (snapshot.data[index].data["type"] ==
                                        "Sticky") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  StickyDisplay()));
                                    } else if (snapshot
                                            .data[index].data["type"] ==
                                        "Bullet") {
                                    } else if (snapshot
                                            .data[index].data["type"] ==
                                        "Checkbox") {}
                                  },
                                ),
                              ),
                            );
                    },
                  );
                }
              },
            ),
            FutureBuilder(
              future: getCalendarPost(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return new Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return new Text(" Error: Connnection Timeout. ");
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length + 1,
                    itemBuilder: (_, index) {
                      return (index == snapshot.data.length)
                          ? Container(
                              margin:
                                  EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
                              decoration: BoxDecoration(
                                  color: ThemeSettings.themeData.accentColor,
                                  shape: BoxShape.rectangle),
                              child: FlatButton.icon(
                                label: Expanded(
                                  child: Text(
                                    "Add A New Calendar",
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ),
                                icon: Icon(Icons.add, size: 75.0),
                                onPressed: () async {
                                  print("New calendar button pressed.");
                                  Map<String, dynamic> data = <String, dynamic>{
                                    "title": "New Calendar",
                                    "visibility": true,
                                    "scope": false,
                                  };
                                  CollectionReference reference =
                                      Firestore.instance.collection(
                                          "Calendars/Live/UIDs/${CurrentLoggedInUser.user.uid}/CalendarIDs");
                                  FirestoreContent.calendarDoc = await reference
                                      .add(data)
                                      .whenComplete(() {
                                    setState(() {});
                                  });
                                  print(
                                      "New Calendar Created. Document ID: ${FirestoreContent.calendarDoc.documentID}");
                                  FirestoreContent.calendarSnap = await FirestoreContent.calendarDoc.get();
                                  navigateToCalendar(FirestoreContent
                                      .calendarSnap.data["title"]);
                                },
                              ),
                            )
                          : Container(
                              margin:
                                  EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
                              decoration: BoxDecoration(
                                  color: ThemeSettings.themeData.accentColor,
                                  shape: BoxShape.rectangle),
                              child: FlatButton.icon(
                                label: Expanded(
                                  child: Text(
                                    "${snapshot.data[index].data["title"]}",
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ),
                                icon: Icon(
                                  Icons.calendar_today,
                                  size: 75.0,
                                ),
                                onPressed: () {
                                  print(
                                      "${snapshot.data[index].data["title"]} was tapped. DocumentID: ${snapshot.data[index].documentID}");
                                  FirestoreContent.calendarSnap =
                                      snapshot.data[index];
                                  FirestoreContent.calendarDoc =
                                      Firestore.instance.document(
                                          "Calendars/Live/UIDs/${CurrentLoggedInUser.user.uid}/CalendarIDs/${FirestoreContent.calendarSnap.documentID}");
                                  navigateToCalendar(
                                      snapshot.data[index].data["title"]);
                                },
                              ),
                            );
                    },
                  );
                }
              },
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(20.0),
                    child: TextField(
                      controller: _searchBar,
                      maxLength: 18,
                      enableInteractiveSelection: true,
                      decoration: InputDecoration(icon: Icon(Icons.search)),
                    ),
                  ),
                  (haveResults)
                      ? FutureBuilder(
                          future: null,
                          builder: (_, builder) {},
                        )
                      : Expanded(
                          child: Text(
                            "Search For Calendars and Cards here.",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        )
                ],
              ),
            )
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
        // false visabilty means private, new cards are set to private by default
        Map<String, dynamic> data = <String, dynamic>{
          "title": "New Card",
          "textBody": "Tap the edit icon then enter text here!",
          "visibility": true,
          "type": "Sticky",
          "scope": false,
        };
        CollectionReference reference = Firestore.instance.collection(
            "Cards/Live/UIDs/${CurrentLoggedInUser.user.uid}/CardIDs");
        FirestoreContent.cardDoc = await reference.add(data).whenComplete(() {
          setState(() {});
        });
        print(
            "New Card Created. Document ID: ${FirestoreContent.cardDoc.documentID}");
        FirestoreContent.cardSnap = await FirestoreContent.cardDoc.get();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => StickyDisplay()));
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

  void navigateToCalendar(String title) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CalendarDisplay(
                  title: title,
                ),
            fullscreenDialog: true));
  }

  Future getCardPost() async {
    var collectionOfCards = await Firestore.instance
        .collection("Cards/Live/UIDs/${CurrentLoggedInUser.user.uid}/CardIDs/")
        .getDocuments();
    return collectionOfCards.documents;
  }

  Future getCalendarPost() async {
    var collectionOfCalendars = await Firestore.instance
        .collection(
            "Calendars/Live/UIDs/${CurrentLoggedInUser.user.uid}/CalendarIDs/")
        .getDocuments();
    return collectionOfCalendars.documents;
  }

  Future searchResults() async {
    var collectionOfResults;
    collectionOfResults += await Firestore.instance
        .collection("Cards/Live/UIDs/${CurrentLoggedInUser.user.uid}/CardIDs/")
        .getDocuments();
    return collectionOfResults;
  }

  Icon iconMapping() {
    // Make switch case for icons to be saved in database

    return Icon(Icons.developer_mode);
  }
}
