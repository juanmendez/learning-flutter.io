import 'package:flutter/material.dart';
import 'package:quizzler/injection/injection.dart';
import 'package:quizzler/quiz_score.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  configuredInjection(Env.dev);
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  String questionContent = "";
  final quizScore = getIt.get<QuizScore>();
  final scores = <Icon>[];

  _QuizPageState() {
    reset();
  }

  void answerQuestion(bool response) {
    if (quizScore.isThisTheLastQuestion) {
      alertWeAreInLastQuestion();
    } else {
      scoreQuestion(response);
    }
  }

  void alertWeAreInLastQuestion() {
    Alert(
      context: context,
      title: "Finished!",
      desc: "You've reached the end of the quiz",
      buttons: [
        DialogButton(
          child: Text("CANCEL"),
          onPressed: () {
            Navigator.pop(context);
            clearView();
          },
        ),
      ]
    ).show();
  }

  void scoreQuestion(bool response) {
    setState(() {
      final score = quizScore.isAnswerCorrect(response);
      scores.add(addIcon(score));
      questionContent = quizScore.getNextQuestion();
    });
  }

  void clearView() {
    setState(() {
      reset();
    });
  }

  void reset() {
    quizScore.clear();
    scores.clear();
    questionContent = quizScore.getNextQuestion();
  }
  

  Icon addIcon(bool score) {
    if (score) {
      return Icon(Icons.check, color: Colors.green);
    } else {
      return Icon(Icons.close, color: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 7,
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Center(
              child: Text(
                questionContent,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'TRUE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                ),
              ),
              onPressed: () => answerQuestion(true),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'FALSE',
                style: TextStyle(
                  fontSize: 17.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () => answerQuestion(false),
            ),
          ),
        ),
        Row(
          children: scores,
        )
      ],
    );
  }
}
