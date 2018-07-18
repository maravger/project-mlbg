import 'package:flutter/material.dart';

class QuestionText extends StatefulWidget {

  final String _question;
  final int _questionNumber;

  //custom one-line constructor
  QuestionText(this._question, this._questionNumber);

  @override
  // Stateful widget prepei na exoun concrete implementation autis tis methodou
  State createState() => new QuestionTextState();
}

// you need this SingleTickle when using animations in your state
// vasika to xreaizetai to vsync san ticker provider
// TODO ti einai omws to vsync? kati kanei ypologizei poia animations einai entos othonis,
// den katalava
// o singleticker kanei tick mono otan to widget einai sto paraskinio
// a isws auto ginetai, gia na min paizei to animation otan den einai energopoimeno to widget
class QuestionTextState extends State<QuestionText> with SingleTickerProviderStateMixin {

  // double giati animation einai ena pososto
  Animation<double> _fontSizeAnimation;
  AnimationController _fontSizeAnimationController;

  @override
  void initState() {
    super.initState();
    /// vsync einai o ticket provider (en prokeimenw h idia h klasi)
    _fontSizeAnimationController = new AnimationController(duration: new Duration(milliseconds: 500), vsync: this);
    // to animation exei mia timi h opoia allazei ana second. Ksekinaei apo 0, 0.1, 0.2 ... ws 1.0
    _fontSizeAnimation = new CurvedAnimation(parent: _fontSizeAnimationController, curve: Curves.bounceOut);
    // we have to provide a state for our animation
    // every time the font size value changes we want to rerender the text
    _fontSizeAnimation.addListener(() => this.setState(() {}));
    // to start the animation
    _fontSizeAnimationController.forward();
  }

  // !!! very important to free resources of controller
  // we should dispose the animation controllers everytime a wigdet is disposed (maybe when the navigator pushes/pops)
  // this is annoying
  @override
  void dispose() {
    _fontSizeAnimationController.dispose();
    super.dispose();
  }

  // every time the widget updates we will compare the new widget (question) with
  // the old one. It also "gives" us the old widget. The we can update the font animation.
  @override
  void didUpdateWidget(QuestionText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget._question != widget._question) {
      _fontSizeAnimationController.reset();
      _fontSizeAnimationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.white,
      child: new Padding(
        padding: new EdgeInsets.symmetric(vertical: 20.0),
        child: new Center(
          // *widget* gives state access to stateful widget
          child: new Text("Statement " + widget._questionNumber.toString() + ": " + widget._question,
            style: new TextStyle(fontSize: _fontSizeAnimation.value * 15),
          ),
        ),
      ),
    );
  }
}
