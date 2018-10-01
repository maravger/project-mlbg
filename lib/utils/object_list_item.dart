import "package:flutter/material.dart";
import 'package:starter_app/utils/camera.dart';

class Obj {
  final String description;
  final int score;
  final Icon leading;
  Icon trailing;
  bool checked;

  Obj(this.description, this.score, this.leading, this.trailing, this.checked); // one-line constructor

}

class ObjectListTile extends ListTile{
  ObjectListTile(Obj obj, BuildContext context, Function refresh) :
        super(
          title : new Text(obj.description),
          subtitle: new Text(obj.score.toString()),
          leading: obj.leading,
          trailing: obj.trailing,
          onTap: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new CameraHome(obj.description, refresh, context)))
        );
}