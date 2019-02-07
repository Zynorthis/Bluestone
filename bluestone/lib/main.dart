import 'package:flutter/material.dart';
import 'package:bluestone/src/components/appBar.dart';

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    int _display = _counter + 5;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          textAlign: TextAlign.left,
          ),
        flexibleSpace: Container(
          alignment: Alignment(0.85,1),
          child: IconButton(
            icon: Icon(Icons.person),
            iconSize: 35.0,
            color: Colors.blueAccent,
            tooltip: "Placeholder button user profile access.",
            onPressed: null,
          ),
        ),
      ),
      body: Expanded(
        child: Flex(
          mainAxisAlignment: MainAxisAlignment.center,
          direction: Axis.vertical,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                )
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  '$_display',
                  style: Theme.of(context).textTheme.display1,
                )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
