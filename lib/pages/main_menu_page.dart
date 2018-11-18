import 'package:flutter/material.dart';
import 'package:starter_app/app.dart';
import 'package:starter_app/app_state_container.dart';
import 'package:starter_app/pages/object_list_page.dart';
import '../utils/camera.dart';

class MainMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material (
      color: Colors.blueAccent,
      child: new InkWell( // invisible button that registers clicks or taps
        // praktika einai to stack to opoio kanei push kai pop full pages kathws kaneis navigate.
//        onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new CameraHome())),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center, // Y Axis Alignment
          children: <Widget>[
            new FlatButton(
                onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new AppStateContainer(child: new AppRootWidget()))),
                child: new Text("Battle Ground",
                    style: new TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold))
            ),
            new FlatButton(
                onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new ObjectListPage())),
                child: new Text("Single Player",
                    style: new TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold))
            ),
            new FlatButton(
//                onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new ObjectListPage())),
                child: new Text("Settings",
                    style: new TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold))
            ),
            new FlatButton(
//                onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new ObjectListPage())),
                child: new Text("Profile",
                    style: new TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold))
            ),
          ],
        ),
      ),
    );
  }
}