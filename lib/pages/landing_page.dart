import 'package:flutter/material.dart';
import 'capture_page.dart';
import '../utils/camera.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material (
      color: Colors.blueAccent,
      child: new InkWell( // invisible button that registers clicks or taps
        // praktika einai to stack to opoio kanei push kai pop full pages kathws kaneis navigate. 
        onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new CameraHome())),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center, // Y Axis Alignment
          children: <Widget>[
            new Text("MLBG", style: new TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold)),
            new Text("Tap to start", style: new TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}