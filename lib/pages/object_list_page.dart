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

  ObjectList ol = new ObjectList([
    new Obj("Shopping Cart", 2, Icon(Icons.shopping_cart)),
    new Obj("Birthday Cake", 3, Icon(Icons.cake)),
    new Obj("Car", 1, Icon(Icons.directions_car))
  ]);
  bool overlayShouldBeVisible = false;

  @override
  void initState() {
    super.initState();
  }

//  Widget build(BuildContext context) {
//    final title = 'Objects List';
//
//    return MaterialApp(
//      title: title,
//      // Implements the basic material design visual layout structure.
//      home: Scaffold(
//        appBar: AppBar(
//          title: Text(title),
//        ),
//        body: ListView(
//          children: <Widget>[
//            ListTile(
//              leading: Icon(Icons.map),
//              title: Text('Map'),
//            ),
//            ListTile(
//              leading: Icon(Icons.photo_album),
//              title: Text('Album'),
//            ),
//            ListTile(
//              leading: Icon(Icons.phone),
//              title: Text('Phone'),
//            ),
//          ],
//        ),
//      ),
//    );
//  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Objects List"),
        ),
        body: ol
    );
  }
}