import 'package:flutter/material.dart';
import 'dart:math';

class CorrectWrongOverlay extends StatefulWidget {

  final bool _isCorrect;
  // remember! a signature for a function with zero arguments and void return
  // void _onTap();
  // leitourgei san placeholder oste na mporeis na tou pairnas ena function otan
  // to dimiourgeis kai theleis na kanei kati "onTap"
  final VoidCallback _onTap;

  CorrectWrongOverlay(this._isCorrect, this._onTap);

  @override
  State createState() => new CorrectWrongOverlayState();
}

class CorrectWrongOverlayState extends State<CorrectWrongOverlay> with SingleTickerProviderStateMixin{

  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(duration: new Duration(seconds: 2), vsync: this);
    _iconAnimation = new CurvedAnimation(parent: _iconAnimationController, curve: Curves.elasticOut);
    // a listener to change the state whenever the animation's value changes
    _iconAnimationController.addListener(() => this.setState(() {}));
    // start the animation
    _iconAnimationController.forward();
  }

  // !!! very important to free resources of controller
  // we should dispose the animation controllers everytime a wigdet is disposed (maybe when the navigator pushes/pops)
  // this is annoying
  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Material (
      color: Colors.black54, // black with a 54% opacity
      child: new InkWell( // once again invisible button that registers clicks or taps
        onTap: () => widget. _onTap(),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration( // only the containers have this property
                color: Colors.white,
                shape: BoxShape.circle
              ),
              child: new Transform.rotate(
                // rotation animation
                angle: _iconAnimation.value * 2 * PI, // auta ta values mallon allazoun mona tous (?)
                // size-growth animation
                child: new Icon(widget._isCorrect == true ? Icons.done : Icons.clear, size: _iconAnimation.value * 80.0,),
              ),
            ),
            new Padding(padding: new EdgeInsets.only(bottom: 20.0),
            ),
            new Text(widget._isCorrect == true ? "Correct!" : "Wrong", style: new TextStyle(color: Colors.white, fontSize: 30.0),) // "widget" is the magic word to get access to the State's widget
          ],
        ),
      ),
    );
  }
}