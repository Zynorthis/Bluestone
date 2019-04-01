import 'package:bluestone/src/Pages/calendars/calendarEditPage.dart';
import 'package:bluestone/src/Pages/calendars/eventDetails.dart';
import 'package:bluestone/src/components/extras.dart';
import 'package:bluestone/src/components/firebaseContent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarDisplay extends StatefulWidget {
  CalendarDisplay({String title});
  final String title = "";

  @override
  _CalendarDisplayState createState() => _CalendarDisplayState(title: title);
}

class _CalendarDisplayState extends State<CalendarDisplay> {
  _CalendarDisplayState({String title});

  String title;
  DateTime _currentDate = DateTime.now();
  String _currentMonth = '';
  bool displayingEvents = false;

  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.event,
      color: Colors.amber,
    ),
  );

  CalendarCarousel _calendarCarousel;
  EventList<Event> _eventsFromDb = new EventList<Event>();

  Future<void> getEventsFromDb() async {
    var events = await Firestore.instance
        .collection(
            "/Calendars/Live/UIDs/${CurrentLoggedInUser.user.uid}/CalendarIDs/${FirestoreContent.calendarDoc.documentID}/Events")
        .getDocuments();
    _eventsFromDb.clear();
    events.documents.forEach((doc) {
      Event event = new Event(
        date: doc.data["date"],
        title: doc.data["title"],
        description: doc.data["description"],
        startTime: TimeOfDay(
            hour: doc.data["startTime"].hour,
            minute: doc.data["startTime"].minute),
        endTime: TimeOfDay(
            hour: doc.data["endTime"].hour, minute: doc.data["endTime"].minute),
        icon: _eventIcon,
        fbID: doc.documentID,
      );
      _eventsFromDb.add(doc.data["date"], event);
    });
  }

  @override
  Widget build(BuildContext context) {
    getEventsFromDb();
    _calendarCarousel = CalendarCarousel<Event>(
      todayBorderColor: Colors.lightGreen,
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate = date);
        if (events.length != 0) {
          events.forEach((event) => print(event.title));
          displayingEvents = true;
          listEventDetails(events);
        } else {
          displayingEvents = false;
        }
        displayingEvents
            ? print("Display Events: True")
            : print("Display Events: False");
      },
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
      markedDatesMap: _eventsFromDb,
      height: 350.0,
      selectedDateTime: _currentDate,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
      markedDateMoreShowTotal: true,
      showHeader: false,
      markedDateIconBuilder: (event) {
        return event.icon;
      },
      todayTextStyle: TextStyle(
        color: Colors.lightBlue[300],
      ),
      todayButtonColor: Colors.grey[350],
      selectedDayTextStyle: TextStyle(
        color: Colors.lightGreenAccent,
      ),
      minSelectedDate: _currentDate.subtract(Duration(days: 365)),
      maxSelectedDate: _currentDate.add(Duration(days: 365)),
      onCalendarChanged: (DateTime date) {
        this.setState(() => _currentMonth = DateFormat.yMMM().format(date));
      },
    );

    return new Scaffold(
        appBar: AppBar(
          title: Text(FirestoreContent.calendarSnap.data["title"]),
          actions: <Widget>[
            (FirestoreContent.calendarSnap.data["scope"] == true)
                ? IconButton(
                    icon: Icon(Icons.edit),
                    tooltip: "Edit calendar settings",
                    onPressed: () {
                      print("Begin Calendar Edit");
                      print(
                          "Current Calendar: ${FirestoreContent.calendarSnap.documentID}");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CalendarEditPage()));
                    },
                  )
                : IconButton(
                  icon: Icon(Icons.delete_forever),
                  onPressed: null,
                ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                print("Delete button Tapped.");
                return showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return new AlertDialog(
                        content:
                            new Text("Are you sure you want to delete this?"),
                        actions: <Widget>[
                          new FlatButton(
                            child: new Text("Yes"),
                            onPressed: () {
                              print(
                                  "Removing ${FirestoreContent.calendarSnap.documentID}...");
                              FirestoreContent.setDocumentReference(
                                  "${FirestoreContent.calendarSnap.documentID}",
                                  "Calendars");
                              FirestoreContent.calendarDoc = Firestore.instance
                                  .document(
                                      "Calendars/Live/UIDs/${CurrentLoggedInUser.user.uid}/CalendarIDs/${FirestoreContent.calendarSnap.documentID}");
                              FirestoreContent.calendarDoc
                                  .delete()
                                  .whenComplete(() {
                                setState(() {});
                              }).catchError((e) => print(e));
                              print("Document Deleted.");
                              print("Removing Duplicate Document...");
                              FirestoreContent.duplicateData
                                  .delete()
                                  .whenComplete(() {
                                setState(() {});
                              }).catchError((e) => print(e));
                              print("Duplicate Deleted.");
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          ),
                          new FlatButton(
                            child: new Text("No"),
                            onPressed: () {
                              print(
                                  "${FirestoreContent.calendarSnap.documentID} will not be deleted.");
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });
              },
              color: Colors.white,
              tooltip: "Tap to Delete",
              iconSize: 25.0,
            ),
          ],
        ),
        floatingActionButton: new FloatingActionButton.extended(
          icon: Icon(Icons.add),
          label: Text("Add Event"),
          onPressed: () {
            print("Begin Event Creation.");
            _addNewEventToDb();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EventDetailsPage()));
          },
        ),
        backgroundColor: ThemeSettings.themeData.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: 30.0,
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: new Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      _currentMonth,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    )),
                    FlatButton(
                      child: Text('PREV'),
                      onPressed: () {
                        setState(() {
                          switch (_currentDate.month) {
                            case 1:
                              changePrevMonth(31);
                              break;
                            case 2:
                              changePrevMonth(31);
                              break;
                            case 3:
                              int monthCapture = _currentDate.month;
                              if (_currentDate.year.remainder(4) == 0) {
                                changePrevMonth(28);
                                if (monthCapture == _currentDate.month) {
                                  changePrevMonth(2);
                                }
                              } else {
                                changePrevMonth(27);
                                if (monthCapture == _currentDate.month) {
                                  changePrevMonth(2);
                                }
                              }
                              break;
                            case 4:
                              changePrevMonth(31);
                              break;
                            case 5:
                              changePrevMonth(30);
                              break;
                            case 6:
                              changePrevMonth(31);
                              break;
                            case 7:
                              changePrevMonth(30);
                              break;
                            case 8:
                              changePrevMonth(31);
                              break;
                            case 9:
                              changePrevMonth(31);
                              break;
                            case 10:
                              changePrevMonth(30);
                              break;
                            case 11:
                              changePrevMonth(31);
                              break;
                            case 12:
                              changePrevMonth(30);
                              break;
                            default:
                              print(
                                  "Error Changing Date to Previous Month: could not find current month.");
                          }
                        });
                      },
                    ),
                    FlatButton(
                      child: Text('NEXT'),
                      onPressed: () {
                        setState(() {
                          switch (_currentDate.month) {
                            case 1:
                              changeNextMonth(31);
                              break;
                            case 2:
                              int monthCapture = _currentDate.month;
                              if (_currentDate.year.remainder(4) == 0) {
                                changeNextMonth(28);
                                if (monthCapture == _currentDate.month) {
                                  changeNextMonth(2);
                                }
                              } else {
                                changeNextMonth(27);
                                if (monthCapture == _currentDate.month) {
                                  changeNextMonth(2);
                                }
                              }
                              break;
                            case 3:
                              changeNextMonth(31);
                              break;
                            case 4:
                              changeNextMonth(30);
                              break;
                            case 5:
                              changeNextMonth(31);
                              break;
                            case 6:
                              changeNextMonth(30);
                              break;
                            case 7:
                              changeNextMonth(31);
                              break;
                            case 8:
                              changeNextMonth(31);
                              break;
                            case 9:
                              changeNextMonth(30);
                              break;
                            case 10:
                              changeNextMonth(31);
                              break;
                            case 11:
                              changeNextMonth(30);
                              break;
                            case 12:
                              changeNextMonth(31);
                              break;
                            default:
                              print(
                                  "Error Changing Date to Previous Month: could not find current month.");
                          }
                        });
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: _calendarCarousel,
              ),
              Divider(),
              Container(
                height: 300.0,
                child: (displayingEvents)
                    ? Container(
                        child: Column(
                          children: <Widget>[
                            Flexible(
                              child: ListView.builder(
                                itemCount: LocalData.events.length,
                                itemBuilder: (_, index) {
                                  return Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: ListTile(
                                          title: Text(
                                            LocalData.events[index].title,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(LocalData
                                              .events[index].description),
                                          onTap: () {
                                            print(
                                                "Event ${LocalData.events[index].title} was Tapped.");
                                            LocalData.currentEvent =
                                                LocalData.events[index];
                                            navigateToEventDetails();
                                          },
                                          onLongPress: () {
                                            print(
                                                "Event ${LocalData.events[index].title} was Long Tapped.");
                                            LocalData.currentEvent =
                                                LocalData.events[index];
                                            navigateToEventDetails();
                                          },
                                          isThreeLine: false,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(""),
                            Text(
                              " No Events Selected. ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24.0,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ));
  }

  /// This method displays all of the event details below the given
  /// calendar being looked at. The method takes in a List of
  /// [Event]s
  void listEventDetails(List<Event> events) {
    if (LocalData.events.isNotEmpty) {
      LocalData.events.clear();
    }
    events.forEach((event) {
      if (event.date == _currentDate) {
        LocalData.events.add(event);
      }
    });
  }

  void changePrevMonth(int days) {
    _currentDate = _currentDate.subtract(Duration(days: days));
    _currentMonth = DateFormat.yMMM().format(_currentDate);
  }

  void changeNextMonth(int days) {
    _currentDate = _currentDate.add(Duration(days: days));
    _currentMonth = DateFormat.yMMM().format(_currentDate);
  }

  void navigateToEventDetails() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EventDetailsPage(), fullscreenDialog: true));
  }

  void _addNewEventToDb() async {
    Map<String, dynamic> data = <String, dynamic>{
      "title": "New Event",
      "description":
          "Beep boop, I am a new Event! Tap the edit button to change me!",
      "date": _currentDate,
      "startTime": DateTime(
          _currentDate.year, _currentDate.month, _currentDate.day, 0, 0),
      "endTime": DateTime(
          _currentDate.year, _currentDate.month, _currentDate.day, 0, 0),
    };

    CollectionReference reference = Firestore.instance.collection(
        "Calendars/Live/UIDs/${CurrentLoggedInUser.user.uid}/CalendarIDs/${FirestoreContent.calendarDoc.documentID}/Events");
    FirestoreContent.eventDoc = await reference.add(data).whenComplete(() {
      setState(() {});
    }).catchError((e) => print(e));
    print(
        "New Event Created. Document ID: ${FirestoreContent.eventDoc.documentID}");
    FirestoreContent.eventSnap = await FirestoreContent.eventDoc.get();

    LocalData.currentEvent = new Event(
        title: FirestoreContent.eventSnap["title"],
        description: FirestoreContent.eventSnap["description"],
        date: FirestoreContent.eventSnap["date"],
        startTime: TimeOfDay(
            hour: FirestoreContent.eventSnap["startTime"].hour,
            minute: FirestoreContent.eventSnap["startTime"].minute),
        endTime: TimeOfDay(
            hour: FirestoreContent.eventSnap["endTime"].hour,
            minute: FirestoreContent.eventSnap["endTime"].minute),
        icon: _eventIcon,
        fbID: FirestoreContent.eventSnap.documentID);
  }
}
