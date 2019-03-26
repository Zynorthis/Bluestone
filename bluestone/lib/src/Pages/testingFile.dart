import 'package:bluestone/src/components/extras.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Dev Testing Page"),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.delete,
                semanticLabel: "Delete",
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Theme.of(context).platform == TargetPlatform.iOS
                    ? Icons.more_horiz
                    : Icons.more_vert,
                semanticLabel: 'Show menu actions',
              ),
              onPressed: () {},
            ),
          ],
        ),
        backgroundColor: ThemeSettings.themeData.backgroundColor,
        body: Scrollbar(
          child: ReorderableListView(
            children: <Widget>[],
            onReorder: _reorderHandling,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: ThemeSettings.themeData.accentColor,
          tooltip: "Floating Action Button",
          onPressed: () {
            print("Floating Action Button Tapped.");
            Scaffold.of(context).showSnackBar(
              const SnackBar(content: Text('Dev Testing, please hold...')),
            );
          },
          child: Icon(Icons.add, semanticLabel: "Action"),
        ),
        bottomNavigationBar: _BottomeAppBarContent(
          color: Colors.blue,
        ));
  }

  void _reorderHandling(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
    });
  }
}

class _ListItem {
  _ListItem(this.value, this.checkState);
  final String value;
  bool checkState;
}

class _BottomeAppBarContent extends StatelessWidget {
  const _BottomeAppBarContent({this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    final List<Widget> bottomAppBarContents = <Widget>[
      IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {},
      ),
      Expanded(
        child: SizedBox(),
      ),
      IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {},
      ),
    ];

    return BottomAppBar(
      color: color,
      child: Row(children: bottomAppBarContents),
    );
  }
}
