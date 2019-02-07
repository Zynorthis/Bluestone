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
      throw new Exception("Error: invalid type - Type being passed in is not of type String.");
    }
    return list;
  }
}