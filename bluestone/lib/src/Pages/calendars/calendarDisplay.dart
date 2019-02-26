import 'package:bluestone/src/Pages/calendars/eventDetails.dart';
import 'package:bluestone/src/components/extras.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarDisplay extends StatefulWidget {
  CalendarDisplay({String title});
  String title;

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

  Future<List<Event>> getEventsFromDb() async {
    
    

    List<Event> thing;
    return thing;
  }

  @override
  Widget build(BuildContext context) {
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
      markedDateMoreShowTotal: false,
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
          title: Text("Placeholder"),
        ),
        floatingActionButton: new FloatingActionButton.extended(
          icon: Icon(Icons.add),
          label: Text("Add Event"),
          onPressed: () {},
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
        LocalData.setEvents(event);
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
}
