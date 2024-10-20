import 'package:flutter/material.dart';
import './question.dart';
import './answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> ques;
  final Function answerQuestion;
  final int questionindex;
  Quiz(
      {@required this.ques,
      @required this.answerQuestion,
      @required this.questionindex});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Question(ques[questionindex]['questionText']),
        ...(ques[questionindex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(() => answerQuestion(answer['score']), answer['text']);
        }).toList()
      ],
    );
  }
}
