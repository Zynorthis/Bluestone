import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// MenuBuilder is a class used to call various static methods used
/// to make home screen menu items.
/// 
/// see [buildItems] and [creatItemMenu] for more details.
class MenuBuilder {

  /// The buildItems method is used to create a new list of [IconButton]s with
  /// the last one being a default IconButton used to make new Card or Calendar
  /// items. 
  /// 
  /// BuildItems takes in a [String] in its paramiter which is used to determine
  /// which type of IconButton it will be building a list for.
  static List<IconButton> buildItems(String type) {
    var list = new List<IconButton>();
    if (type == "Card"){
      // add all of the cards save for a user here.
    } else if (type == "Calendar"){
      // add all of the calendars save for a user here.
    }
    else {
      print("Error: invalid type - Type being passed in was unable to be determined. (menuBuilder.dart - line 24)");
      throw new Exception("Error: invalid type - Type being passed in was unable to be determined.");
    }

    var addIcon = new IconButton(
      icon: Icon( Icons.add ),
      iconSize: 125.0,
      color: Colors.blueAccent,
      //padding: EdgeInsets.all(25.0),
      splashColor: Colors.grey,
      tooltip: "Tap me to create a new $type!",
      onPressed: null, //create new item
    );

    list.add(addIcon);
    return list;
  }

  void _createNewItem() {
    
  }
}