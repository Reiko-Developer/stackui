import 'package:flutter/material.dart';
import 'package:stackui/model/question_model.dart';
import 'package:stackui/widgets/answer.dart';

class QuestionWidget extends StatefulWidget {
  final Function nextQuestion;
  final QuestionModel question;
  final int questionIndex;
  QuestionWidget(
      {Key key, this.question, this.questionIndex, this.nextQuestion})
      : super(key: key);

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  List<Widget> getAnswers() {
    var lsAnswer = List<Widget>();

    for (var i = 0; i < widget.question.answers.length; i++) {
      lsAnswer.add(Answer(
        widget.question.answers[i],
        widget.nextQuestion,
      ));
      lsAnswer.add(SizedBox(height: 24));
    }

    return lsAnswer;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 10,
          left: 80,
          child: Text(
            widget.questionIndex < 9
                ? '0${widget.questionIndex + 1}'
                : '${widget.questionIndex + 1}',
            style: TextStyle(
              fontSize: 70,
              fontWeight: FontWeight.bold,
              color: Colors.grey[400],
            ),
          ),
        ),
        Positioned(
          left: 80,
          right: 0,
          top: 90,
          child: Text(
            '${widget.question.header}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
            ),
            softWrap: true,
          ),
        ),
        Positioned(
          top: 200,
          bottom: 50,
          left: 53,
          right: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: getAnswers(),
          ),
        ),
      ],
    );
  }
}
