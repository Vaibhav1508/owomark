import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owomark/api_interface.dart';
import 'package:owomark/models/quiz_item.dart';
import 'package:owomark/quiz.dart';

List<QuizItem> books = new List();

class AnimalQuiz {
  var questions = [];
  var choices = [][4];

  var choice = [];

  var correctAnswers = [];
}

var finalScore = 0;
var questionNumber = 0;
var quiz = new AnimalQuiz();

class Quiz1 extends StatefulWidget {
  final String project_id;

  Quiz1({Key key, this.project_id}) : super(key: key);

  @override
  _Quiz1State createState() => _Quiz1State();
}

class _Quiz1State extends State<Quiz1> {
  ApiInterface apiInterface = new ApiInterface();

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('quiz'),
          elevation: 4,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => QuizScreen())),
            )
          ],
        ),
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
                      "question ${questionNumber + 1} of ${books.length}",
                      style: new TextStyle(fontSize: 22.0),
                    ),
                  ],
                ),
              ),
              new Padding(padding: EdgeInsets.all(10.0)),
              new Text(
                books[questionNumber].que,
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
                      if (books[questionNumber].a ==
                          books[questionNumber].ans) {
                        debugPrint("Correct");
                        finalScore++;
                      } else {
                        debugPrint("Incorrect");
                      }
                      updateQuestion();
                    },
                    color: Colors.blueAccent,
                    child: new Text(
                      books[questionNumber].a,
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
                      if (books[questionNumber].b ==
                          books[questionNumber].ans) {
                        debugPrint("Correct");
                        finalScore++;
                      } else {
                        debugPrint("Incorrect");
                      }
                      updateQuestion();
                    },
                    color: Colors.blueAccent,
                    child: new Text(
                      books[questionNumber].b,
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
                      if (books[questionNumber].c ==
                          books[questionNumber].ans) {
                        debugPrint("Correct");
                        finalScore++;
                      } else {
                        debugPrint("Incorrect");
                      }
                      updateQuestion();
                    },
                    color: Colors.blueAccent,
                    child: new Text(
                      books[questionNumber].c,
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
                      if (books[questionNumber].d ==
                          books[questionNumber].ans) {
                        debugPrint("Correct");
                        finalScore++;
                      } else {
                        debugPrint("Incorrect");
                      }
                      updateQuestion();
                    },
                    color: Colors.blueAccent,
                    child: new Text(
                      books[questionNumber].d,
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

  @override
  void initState() {
    super.initState();

    getEvents(context);
  }

  getEvents(context) async {
    setState(() {});

    Future<dynamic> response = apiInterface.getSingleQuiz(widget.project_id);

    response.then((action) async {
      print(action.toString());
      if (action != null) {
        Map data = jsonDecode(action.toString());
        if (data["status"] == "200") {
          List<dynamic> list = data['result'];
          for (int i = 0; i < list.length; i++) {
            QuizItem notificationItem = QuizItem.fromMap(list[i]);
            books.add(notificationItem);
          }

          setState(() {
            for (int i = 0; i < list.length; i++) {
              quiz.questions.add(books[i].que);
              quiz.correctAnswers.add(books[i].ans);

              quiz.choice[i][0] = [books[i].a];
              quiz.choice[i][1] = [books[i].a];
              quiz.choice[i][2] = [books[i].a];
              quiz.choice[i][3] = [books[i].a];

              /* quiz.choices[i][0].add(books[i].a);
            quiz.choices[i][1].add(books[i].b);
            quiz.choices[i][2].add(books[i].c);
            quiz.choices[i][3].add(books[i].d);

            */
            }
          });
        } else {
          print('error');
        }
      }
    }, onError: (value) {
      print(value);
    });
  }

  void resetQuiz() {
    setState(() {
      Navigator.pop(context);
      finalScore = 0;
      questionNumber = 0;
    });
  }

  void updateQuestion() {
    Fluttertoast.showToast(
        msg: questionNumber.toString() + " : " + books.length.toString(),
        toastLength: Toast.LENGTH_SHORT);

    setState(() {
      if (questionNumber == books.length - 1) {
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
              style: new TextStyle(fontSize: 25.0, color: Colors.black),
            ),
            new Padding(padding: EdgeInsets.all(10.0)),
            new MaterialButton(
              color: Colors.redAccent,
              textColor: Colors.white,
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
