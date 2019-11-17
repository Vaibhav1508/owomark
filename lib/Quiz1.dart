import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AnimalQuiz {
  var question = ["question1", "question2", "question3", "question4"];
  var choices = [
    ["a here", "b here", "c here", "d here"],
    ["a here", "b here", "c here", "d here"],
    ["a here", "b here", "c here", "d here"],
    ["a here", "b here", "c here", "d here"]
  ];

  var correctAnswers = ["a here", "b here", "c here", "d here"];
}

var finalScore = 0;
var questionNumber = 0;
var quiz = new AnimalQuiz();

class Quiz1 extends StatefulWidget {
  @override
  _Quiz1State createState() => _Quiz1State();
}

class _Quiz1State extends State<Quiz1> {
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: new Container(
          margin: const EdgeInsets.all(10.0),
          alignment: Alignment.topCenter,
          child: new Column(
            children: <Widget>[
              new Padding(padding: EdgeInsets.all(20.0)),
              new Container(
                alignment: Alignment.centerRight,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                      "question ${questionNumber + 1} of ${quiz.question.length}",
                      style: new TextStyle(fontSize: 22.0),
                    ),
                    new Text(
                      "Score ${finalScore}",
                      style: new TextStyle(fontSize: 22.0),
                    ),
                  ],
                ),
              ),
              new Padding(padding: EdgeInsets.all(10.0)),
              new Text(
                quiz.question[questionNumber],
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              new Padding(padding: EdgeInsets.all(40.0)),
              new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new MaterialButton(
                    minWidth: 300.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: () {
                      if (quiz.choices[questionNumber][0] ==
                          quiz.correctAnswers[questionNumber]) {
                        debugPrint("Correct");
                        finalScore++;
                      } else {
                        debugPrint("Incorrect");
                      }
                      updateQuestion();
                    },
                    color: Colors.blueAccent,
                    child: new Text(
                      quiz.choices[questionNumber][0],
                      style: new TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  new MaterialButton(
                    minWidth: 300.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: () {
                      if (quiz.choices[questionNumber][1] ==
                          quiz.correctAnswers[questionNumber]) {
                        debugPrint("Correct");
                        finalScore++;
                      } else {
                        debugPrint("Incorrect");
                      }
                      updateQuestion();
                    },
                    color: Colors.blueAccent,
                    child: new Text(
                      quiz.choices[questionNumber][1],
                      style: new TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new MaterialButton(
                    minWidth: 300.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: () {
                      if (quiz.choices[questionNumber][2] ==
                          quiz.correctAnswers[questionNumber]) {
                        debugPrint("Correct");
                        finalScore++;
                      } else {
                        debugPrint("Incorrect");
                      }
                      updateQuestion();
                    },
                    color: Colors.blueAccent,
                    child: new Text(
                      quiz.choices[questionNumber][2],
                      style: new TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  new MaterialButton(
                    minWidth: 300.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: () {
                      if (quiz.choices[questionNumber][3] ==
                          quiz.correctAnswers[questionNumber]) {
                        debugPrint("Correct");
                        finalScore++;
                      } else {
                        debugPrint("Incorrect");
                      }
                      updateQuestion();
                    },
                    color: Colors.blueAccent,
                    child: new Text(
                      quiz.choices[questionNumber][3],
                      style: new TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              new Padding(padding: EdgeInsets.all(10.0)),
            ],
          ),
        ),
      ),
    );
  }

  void resetQuiz() {
    setState(() {
      Navigator.pop(context);
      finalScore = 0;
      questionNumber = 0;
    });
  }

  void updateQuestion() {
    setState(() {
      if (questionNumber == quiz.question.length - 1) {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new Summary(score: finalScore)));
      } else {
        questionNumber++;
      }
    });
  }
}

class Summary extends StatelessWidget {
  final int score;

  Summary({Key key, @required this.score}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              "Final Score: $score",
              style: new TextStyle(
                fontSize: 25.0,
              ),
            ),
            new Padding(padding: EdgeInsets.all(10.0)),
            new MaterialButton(
              color: Colors.redAccent,
              onPressed: () {
                questionNumber = 0;
                finalScore = 0;
                Navigator.pop(context);
              },
            )
          ],
        ),
      )),
    );
  }
}
