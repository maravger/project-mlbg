import "obj.dart";

class ObjectList {
  List<Obj> _objects; // underscore makes the field private
  int _currentObjectIndex = -1;
  int _totalScore = 0;

  // our usual constructor
  // auti h paparia pairnei mia lista
  ObjectList(this._objects) {
    _objects.shuffle(); // shuffles the elements of a list
  }

  // some nice one-line getters
  List<Obj> get objects => _objects;
  int get length => _objects.length;
  int get objectNumber => _currentObjectIndex+1;
  int get totalScore => _totalScore;

  // classic full body getters
  Obj get nextObject {
    _currentObjectIndex++;
    if (_currentObjectIndex >= length) return null;
    return _objects[_currentObjectIndex];
  }

  // similar to "answer"
  void submit(bool isCorrect) {
    if (isCorrect) _totalScore += _objects[_currentObjectIndex].score;
  }
}