import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          title: Text('Quiz'),
          backgroundColor: Colors.amber.shade700,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userAnswer) {
    bool correctAnswer = quizBrain.getAnswer();
    setState(() {
      quizBrain.nextQuestion();
      if(quizBrain.isFinished()){
        Alert(context: context, title: "Finished", desc: "You've reached the end of the quiz.").show();
        quizBrain.reset();
        scoreKeeper = [];
      }
      else{

        if (userAnswer == correctAnswer) {
          scoreKeeper.add(Icon(Icons.check, color: Colors.green,));
        }
        else{
          scoreKeeper.add(Icon(Icons.close, color: Colors.red,));
        }
      }


    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  quizBrain.getQuestion(),
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      checkAnswer(false);
                    },
                    child: Text(
                      'False',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () {
                      checkAnswer(true);
                    },
                    child: Text(
                      'True',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: scoreKeeper,
          ),
        ],
      ),
    );
  }
}

/*
 'Hello! how are you?', Yes,
 'Am fine! how about you?', No,
 'Why?', no,
 'Tell my why?' no,
 'you don't want to tell to me?', yes,

*/
