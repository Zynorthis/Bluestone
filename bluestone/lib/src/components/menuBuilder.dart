import 'package:flutter/material.dart';


/// MenuBuilder is a class used to call the static buildItem method.
/// see [buildItem] for more details. 
class MenuBuilder {

  static List<IconButton> buildItem(String type) {
    var list = new List<IconButton>();
    if (type == "Card"){
      // add all of the cards save for a user here.
    } else if (type == "Calendar"){
      // add all of the calendars save for a user here.
    }
    else {
      throw new Exception("Error: invalid type - Type being passed in was unable to be determined.");
    }

    var addIcon = new IconButton(
      icon: Icon(Icons.add),
      iconSize: 125.0,
      color: Colors.blueAccent,
      //padding: EdgeInsets.all(25.0),
      splashColor: Colors.grey,
      tooltip: "Tap me to create a new $type!",
      onPressed: null,
    );

    list.add(addIcon);
    return list;
  }
}