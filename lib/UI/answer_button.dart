import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {

  final bool _answer;
  // underscore makes the field private
  final VoidCallback _onTap; // = typedef, creates a signature for a function
  // e.g void _onTap()
  // leitourgei san placeholder oste na mporeis na tou pairnas ena function otan
  // to dimiourgeis kai theleis na kanei kati "onTap

  AnswerButton(this._answer, this._onTap);

  @override
  Widget build(BuildContext context) {
    // when a widget is the child of a column, it tries to take as
    // little space as possible. That's why we make it expanded
    return new Expanded(
      child: new Material(
        color: _answer == true ? Colors.greenAccent : Colors.redAccent,
        child: new InkWell( // because we obviously want to press on this button
          onTap: () => _onTap(),
          child: new Center( // centers the context
            child: new Container(
              decoration: new BoxDecoration( // container was selected because of this property
                border: new Border.all(color: Colors.white, width: 5.0)
              ),
              padding: new EdgeInsets.all(20.0), // all means "in all dimensions
              child: new Text(_answer == true ? "True" : "False",
              style: new TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
            ),
          ),
        ),
      ),
    );
  }
}