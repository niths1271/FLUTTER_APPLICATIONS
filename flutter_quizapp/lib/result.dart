import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int total;
  final Function reset;
  Result(this.total, this.reset);
  String get resultPhrase {
    String resultText;
    if (total <= 8) {
      resultText = 'You are awesome and innocent';
    } else if (total <= 12) {
      resultText = 'Pretty Likeable';
    } else if (total <= 16) {
      resultText = 'You are Strange';
    } else {
      resultText = 'You Suck!!';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: <Widget>[
      Text(
        resultPhrase,
        style: TextStyle(
            color: Colors.black, fontSize: 36, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      FlatButton(
        child: Text('Restart Quiz!'),
        onPressed: reset,
        textColor: Colors.blue,
      ),
    ]));
  }
}
