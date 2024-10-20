import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function selectHandler;
  final String ans;
  Answer(this.selectHandler, this.ans);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: RaisedButton(
          child: Text(ans),
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: selectHandler,
        ));
  }
}
