import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starter_app/utils/object_list_item.dart';
import 'package:starter_app/utils/object_list.dart';

// a widget that can be rebuild, change visuals etc (mutable)
class ObjectListPage extends StatefulWidget {
  @override
  State createState() => new ObjectListState();
}

class ObjectListState extends State<ObjectListPage> {

  List<Obj> _objs = [
    new Obj("Shopping Cart", 2, Icon(Icons.shopping_cart),
        Icon(Icons.radio_button_unchecked), false),
    new Obj("Birthday Cake", 3, Icon(Icons.cake),
        Icon(Icons.radio_button_unchecked), false),
    new Obj("Car", 1, Icon(Icons.directions_car),
        Icon(Icons.radio_button_unchecked), false)
  ];
  bool overlayShouldBeVisible = false;

  @override
  void initState() {
    super.initState();
    _objs.shuffle();
  }

  updateOLState(String objClass) {
    print("update ol state");
    print(objClass);
    setState(() {
      _objs
          .firstWhere((obj) => obj.description == objClass)
          .trailing
      = Icon(Icons.radio_button_checked);
      _objs
          .firstWhere((obj) => obj.description == objClass)
          .checked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Objects List"),
          backgroundColor: Colors.blueAccent,
        ),
//        backgroundColor: Colors.blueAccent,
        body: new ObjectList(_objs, updateOLState)
    );
  }
}