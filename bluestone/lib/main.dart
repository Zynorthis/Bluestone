import 'package:flutter/material.dart';
import 'package:bluestone/src/components/menuBuilder.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bluestone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Bluestone [Local dev build]'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  var _cardItems = MenuBuilder.buildItem("Card");
  var _calendarItems = MenuBuilder.buildItem("Calendar");

  //   for(var index in _cardItems){
  //   new IconButton(
  //     icon: index.icon,
  //     iconSize: index.iconSize,
  //     color: index.color,
  //     tooltip: index.tooltip,
  //     onPressed: index.onPressed,
  //   );
  // }
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
            alignment: Alignment(0.85,-0.3),
            child: IconButton(
              icon: Icon(Icons.person),
              iconSize: 35.0,
              color: Colors.blueAccent,
              tooltip: "Placeholder button user profile access.",
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
        body: TabBarView(
          children: [
            ListView.builder( 
              itemCount: _cardItems.length,
              itemBuilder: (context, index){
                return IconButton(
                  icon: _cardItems[index].icon,
                  iconSize: _cardItems[index].iconSize,
                  color: _cardItems[index].color,
                  tooltip: _cardItems[index].tooltip,
                  onPressed: _cardItems[index].onPressed,
                );
              },
            ),// Display list of cards here
            ListView( 
              children: [

              ],
            ), // display list of calendars here
          ],
        ),
      ),
    );
  }
}
