import "package:flutter/material.dart";

import '../utils/question.dart';
import '../utils/quiz.dart';

import '../UI/answer_button.dart';
import '../UI/question_text.dart';
import '../UI/correct_wrong_overlay.dart';

import 'score_page.dart';

// a widget that can be rebuild, change visuals etc (mutable)
class QuizPage extends StatefulWidget {
  @override
  State createState() => new QuizPageState();
}

// this is what makes the above class mutable. They are connected
// Looks a lot like a Stateless Widget, like in Landing Page
// inhere we also make the visuals
// fainetai genika oti ola ta visuals stin periptwsi twn Statefull Widgets grafontai sto State
class QuizPageState extends State<QuizPage> {

  Question currentQuestion;
  Quiz quiz = new Quiz([
    new Question("Elon Musk is human", false),
    new Question("Pizza is healthy", false),
    new Question("Flutter is awesome", true)
  ]);
  String questionText;
  int questionNumber;
  bool isCorrect; // regarding current question
  bool overlayShouldBeVisible = false;

  // klassikos foul body constructoras
  @override
  void initState() {
    super.initState();
    currentQuestion = quiz.nextQuestion;
    questionText = currentQuestion.question;
    questionNumber = quiz.questionNumber;
  }

  void handleAnswer(bool answer) {
    isCorrect = (currentQuestion.answer == answer);
    quiz.answer(isCorrect);
    //we want to change something in the state (overlay should be visible) so we
    //use this function. This will result in rebuilding the widget
    this.setState(() {
      overlayShouldBeVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Stack looks like a column
    // stacks the children on top of each other
    return new Stack(
      fit: StackFit.expand, // we want the widgets to expand as much as possible
      children: <Widget>[
        new Column(// this is our main page
            children: <Widget>[
          // True button
          new AnswerButton(
              true,
              (/* inhere goes the lambda function's args*/) =>
                  handleAnswer(true)), //anonymous function
          // This is going to be the question (?)
          new QuestionText(questionText, questionNumber),
          // False button
          new AnswerButton(false, () => handleAnswer(false))
        ]
        ),
        overlayShouldBeVisible == true ? new CorrectWrongOverlay (
            isCorrect,
            // tis pername sto onTap mia function pou kanei ta eksis:
            () {
              if (quiz.length == questionNumber) {
                // xrisimopoioume tin pushAndRemoveUntil gia na min mproei o xristis na kanei back kai na vgainei stin teleutaia erwtisi
                // opote kanoume remove mexri na ftasoume sto null (?) => h efarmogi kleinei
                Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new ScorePage(quiz.score, quiz.length)), (Route route) => route == null);
                //!!! important (logika) we do not want any of the following code to be executed after going to the new page
                return;
              }
              currentQuestion = quiz.nextQuestion;
              this.setState(() {
                overlayShouldBeVisible = false;
                questionText = currentQuestion.question;
                questionNumber = quiz.questionNumber; // einai getter opote pairnei pliroforia apo current question
              });
            }
        ) : new Container()
      ],
    );
  }
}
