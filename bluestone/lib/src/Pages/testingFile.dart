import 'package:bluestone/src/components/extras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;

class HomePage extends StatefulWidget {
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
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

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(2019, 2, 25): [
        new Event(
          date: new DateTime(2019, 2, 25),
          title: 'Event 1',
          icon: _eventIcon,
        ),
        new Event(
          date: new DateTime(2019, 2, 25),
          title: 'Event 2',
          icon: _eventIcon,
        ),
        new Event(
          date: new DateTime(2019, 2, 25),
          title: 'Event 3',
          icon: _eventIcon,
        ),
      ],
    },
  );

  CalendarCarousel _calendarCarousel;

  @override
  void initState() {
    /// Add more events to _markedDateMap EventList
    _markedDateMap.add(
        new DateTime(2018, 12, 25),
        new Event(
          date: new DateTime(2018, 12, 25),
          title: 'Event 5',
          icon: _eventIcon,
        ));

    _markedDateMap.add(
        new DateTime(2018, 12, 10),
        new Event(
          date: new DateTime(2018, 12, 10),
          title: 'Event 4',
          icon: _eventIcon,
        ));

    _markedDateMap.addAll(new DateTime(2018, 12, 11), [
      new Event(
        date: new DateTime(2018, 12, 11),
        title: 'Event 1',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2018, 12, 11),
        title: 'Event 2',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2018, 12, 11),
        title: 'Event 3',
        icon: _eventIcon,
      ),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _calendarCarousel = CalendarCarousel<Event>(
      todayBorderColor: Colors.lightGreen,
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));
        listEventDetails(events);
      },
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
      markedDatesMap: _markedDateMap,
      height: 350.0,
      selectedDateTime: _currentDate2,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
      markedDateMoreShowTotal:
          false, // null for not showing hidden events indicator
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
//      inactiveDateColor: Colors.black12,
      onCalendarChanged: (DateTime date) {
        this.setState(() => _currentMonth = DateFormat.yMMM().format(date));
      },
    );

    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Testing Grounds"),
        ),
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
                          switch (_currentDate2.month) {
                            case 1:
                              changePrevMonth(31);
                              break;
                            case 2:
                              changePrevMonth(31);
                              break;
                            case 3:
                              int monthCapture = _currentDate2.month;
                              if (_currentDate2.year.remainder(4) == 0) {
                                changePrevMonth(28);
                                if (monthCapture == _currentDate2.month) {
                                  changePrevMonth(2);
                                }
                              } else {
                                changePrevMonth(27);
                                if (monthCapture == _currentDate2.month) {
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
                          switch (_currentDate2.month) {
                            case 1:
                              changeNextMonth(31);
                              break;
                            case 2:
                              int monthCapture = _currentDate2.month;
                              if (_currentDate2.year.remainder(4) == 0) {
                                changeNextMonth(28);
                                if (monthCapture == _currentDate2.month) {
                                  changeNextMonth(2);
                                }
                              } else {
                                changeNextMonth(27);
                                if (monthCapture == _currentDate2.month) {
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
                child: (displayingEvents)
                    ? Container(
                        child: Column(
                          children: <Widget>[
                            Text(""),
                            Text(" No Events Selected. "),
                          ],
                        ),
                      )
                    : Container(
                        child: ListView.builder(
                        itemCount:
                            _calendarCarousel.markedDatesMap.events.length,
                        itemBuilder: (_, index) {
                          
                        },
                      )),
              ),
            ],
          ),
        ));
  }

  /// This method displays all of the event details below the given
  /// calendar being looked at. The method takes in a List of
  /// [Event]s
  Widget listEventDetails(List<Event> events) {
    events.forEach((event) {
      if (event.date == _currentDate2) {
        LocalData.events.add(event);
      }
    });
    displayingEvents = !displayingEvents;
  }

  void changePrevMonth(int days) {
    _currentDate2 = _currentDate2.subtract(Duration(days: days));
    _currentMonth = DateFormat.yMMM().format(_currentDate2);
  }

  void changeNextMonth(int days) {
    _currentDate2 = _currentDate2.add(Duration(days: days));
    _currentMonth = DateFormat.yMMM().format(_currentDate2);
  }
}
