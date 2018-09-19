import "package:flutter/material.dart";
import "../utils/object_list_item.dart";
import "../utils/object_list.dart";
import "../utils/camera.dart";

class CapturePage extends StatefulWidget {
  @override
  State createState() => new CapturePageState();
}

class CapturePageState extends State<CapturePage> {

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
