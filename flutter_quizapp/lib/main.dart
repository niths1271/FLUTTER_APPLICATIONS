import 'package:flutter/material.dart';
import './quiz.dart';
import './result.dart';

void main() {
  runApp(MyFirstApp());
}

//void main() => runApp(MyFirstApp());

class MyFirstApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyFirstAppState();
  }
}

class _MyFirstAppState extends State<MyFirstApp> {
  var _questionindex = 0;
  var totalscore = 0;
  void _onanswering(int score) {
    totalscore += score;
    setState(() {
      _questionindex += 1;
    });
    print(_questionindex);
    if (_questionindex < _ques.length) {
      print('WE HAVE MORE QUESTIONS');
    }
  }

  void _resetquiz() {
    setState(() {
      _questionindex = 0;
      totalscore = 0;
    });
  }

  static const _ques = [
    {
      'questionText': 'WHAT\'s YOUR FAVOURITE COLOR',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 5},
        {'text': 'Green', 'score': 3},
        {'text': 'White', 'score': 1},
      ]
    },
    {
      'questionText': 'WHAT IS YOUR FAVOURITE ANIMAL',
      'answers': [
        {'text': 'Elephant', 'score': 10},
        {'text': 'Tiger', 'score': 5},
        {'text': 'Rabbit', 'score': 3},
        {'text': 'Hyena', 'score': 1},
      ]
    },
    {
      'questionText': 'WHO IS YOUR FAVOURITE CRICKETER',
      'answers': [
        {'text': 'KLR', 'score': 10},
        {'text': 'Vk', 'score': 5},
        {'text': 'MSD', 'score': 3},
        {'text': 'VadaPav', 'score': 1},
      ]
    },
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quiz App'),
        ),
        body: _questionindex < _ques.length
            ? Quiz(
                ques: _ques,
                answerQuestion: _onanswering,
                questionindex: _questionindex)
            : Result(totalscore, _resetquiz),
      ),
    );
  }
}
