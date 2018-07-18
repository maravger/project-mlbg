import "package:flutter/material.dart";
import "../utils/obj.dart";
import "../utils/object_list.dart";
import "../utils/camera.dart";

class CapturePage extends StatefulWidget {
  @override
  State createState() => new CapturePageState();
}

class CapturePageState extends State<CapturePage> {
  Obj currentObject;
  ObjectList objectlist = new ObjectList([
    new Obj("Buggy", 4, new Icon(Icons.child_friendly)),
    new Obj("Key", 3, new Icon(Icons.vpn_key)),
    new Obj("Pen", 1, new Icon(Icons.create))
  ]);
  String objectText;
  int objectNumber;
  bool isCorrect; // regarding current question
  bool overlayShouldBeVisible = false;

  @override
  Widget build(BuildContext context) {
    // Stack looks like a column
    // stacks the children on top of each other
    return new Stack(
        fit: StackFit
            .expand, // we want the widgets to expand as much as possible
        children: <Widget>[
          new Column(// this is our main page
              children: <Widget>[
                new CameraHome()
              ]),
        ]);
  }
}
