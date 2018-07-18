import './question.dart';

class Quiz {
  List<Question> _questions; // underscore makes the field private
  int _currentQuestionIndex = -1;
  int _score = 0;

  // our usual constructor
  // auti h paparia pairnei mia lista
  Quiz(this._questions) {
    _questions.shuffle(); // shuffles the elements of a list
  }

  // some nice one-line getters
  List<Question> get questions => _questions;
  int get length => _questions.length;
  int get questionNumber => _currentQuestionIndex+1;
  int get score => _score;

  // classic full body getters
  Question get nextQuestion {
    _currentQuestionIndex++;
    if (_currentQuestionIndex >= length) return null;
    return _questions[_currentQuestionIndex];
  }

  // classic method
  void answer(bool isCorrect) {
    if (isCorrect) _score++;
  }
}

//Quiz quiz = new Quiz([new Question("question", true)]);