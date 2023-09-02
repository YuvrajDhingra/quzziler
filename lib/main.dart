import 'package:flutter/material.dart';
import 'quiz_dart.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();
void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  Quizzler({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: QuizPage(),
        backgroundColor: Colors.black,
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  QuizPage({super.key});
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late List<Icon> scoreKeeper= [];
  void checkAnswer(bool correctAnser){
    bool correctAnswer = quizBrain.getCorrectAnswer();
    setState(() {
      if (quizBrain.isFinished() == true) {
        Alert(context: context,
            title: "FINISHED",
            desc: "Thanks for participating").show();
        quizBrain.reset();
        scoreKeeper = [];
      }
      else {
        if (correctAnser == correctAnswer) {
          scoreKeeper.add(
              Icon(
                Icons.check,
                color: Colors.green,
              ));
        } else {
          quizBrain.NextQuestion();
          scoreKeeper.add(
              Icon(
                Icons.close,
                color: Colors.red,
              ));
        }
        quizBrain.NextQuestion();
      }
    });
}

  int questionNUm=0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  quizBrain.getQuestionText(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ),
        Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: Text(
                  'True',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                onPressed: (){
                  checkAnswer(true);
                }
              ),
            ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              onPressed: (){
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}
