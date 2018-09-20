import "package:flutter/material.dart";
import 'package:starter_app/utils/camera.dart';

class Obj {
  final String description;
  final int score;
  final Icon icon;

  Obj(this.description, this.score, this.icon); // one-line constructor

}

class ObjectListTile extends ListTile{
  ObjectListTile(Obj obj, BuildContext context) :
        super(
          title : new Text(obj.description),
          subtitle: new Text(obj.score.toString()),
          leading: obj.icon,
          trailing: Icon(Icons.radio_button_unchecked),
          onTap: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new CameraHome()))
        );
}