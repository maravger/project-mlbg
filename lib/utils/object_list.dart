import 'package:flutter/material.dart';

import "object_list_item.dart";

class ObjectList extends StatelessWidget{
  List<Obj> _objects; // underscore makes the field private
  int _currentObjectIndex = -1;
  int _totalScore = 0;
  final Function(String) refresh;

  // our usual constructor
  // auti h paparia pairnei mia lista
  ObjectList(this._objects, this.refresh) {
  // _objects.shuffle(); // shuffles the elements of a list
  }

  // some nice one-line getters
  List<Obj> get objects => _objects;
  int get length => _objects.length;
  int get objectNumber => _currentObjectIndex+1;
  int get totalScore => _totalScore;

  // similar to "answer"
  void submit(bool isCorrect) {
    if (isCorrect) _totalScore += _objects[_currentObjectIndex].score;
  }

  @override
  Widget build(BuildContext context) {
    return new ListView(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: _buildObjectList(context)
    );
  }

  List<ObjectListTile> _buildObjectList(context) {
    return _objects.map((obj) => new ObjectListTile(obj, context, refresh))
        .toList();
  }

}