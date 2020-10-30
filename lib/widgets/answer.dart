import 'package:flutter/material.dart';

class Answer extends StatefulWidget {
  final String answer;
  final Function nextQuestion;
  Answer(this.answer, this.nextQuestion);

  @override
  _AnswerState createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(Icons.circle, size: 11, color: Colors.white),
          SizedBox(width: 20),
          Expanded(
            key: UniqueKey(),
            child: GestureDetector(
              onTap: () {
                print(widget.answer);
                widget.nextQuestion();
              },
              child: Text(
                widget.answer,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                softWrap: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
