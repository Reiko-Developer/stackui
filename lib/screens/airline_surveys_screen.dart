import 'package:flutter/material.dart';
import 'package:stackui/widgets/question_widget.dart';
import 'dart:math';

import '../model/question_model.dart';

class AirlineSurveysScreen extends StatefulWidget {
  static final routeName = '/airline-surveys';

  AirlineSurveysScreen();
  @override
  _AirlineSurveysScreenState createState() => _AirlineSurveysScreenState();
}

class _AirlineSurveysScreenState extends State<AirlineSurveysScreen> {
  var _questionIndex = 0;

  var _isVisible = true;

  void toggleVisibility() {
    _isVisible = !_isVisible;
  }

  final questions = <QuestionModel>[
    QuestionModel(
      'What is your favorite air company?',
      ['Latam', 'Gol Airlines', 'Azul Airlines'],
    ),
    QuestionModel(
      'Best time to fly?',
      ['Morning', 'Night, because we can see the stars shining', 'Afternoon'],
    ),
    QuestionModel(
      'Favorite board service?',
      ['Cookies', 'Water', 'Champagne, Wine i love wine, i already told ya?'],
    ),
    QuestionModel(
      'Favorite board service?',
      [
        'Nothing at all, i just want some peace, please.',
        'Water, cuz i love so much it!!!!',
        'What are you talking about? Please give me space!!!'
      ],
    )
  ];

  void _nextQuestion({forward = true}) {
    setState(
      () {
        //Se forward == true? passa para a próxima questão, caso contrário,
        //retorna à questão anterior.
        if (forward) {
          if (_questionIndex + 1 >= questions.length)
            _questionIndex = 0;
          else
            _questionIndex++;
        } else {
          if (_questionIndex - 1 < 0)
            _questionIndex = questions.length - 1;
          else
            _questionIndex--;
        }
      },
    );
  }

  List<Widget> staticElements() {
    return [
      Positioned(
        top: 20,
        left: 35,
        child: Transform.rotate(
          angle: -pi,
          child: Icon(
            Icons.airplanemode_active_rounded,
            size: 46,
            color: Colors.white,
          ),
        ),
      ),
      Positioned(
        top: 65,
        bottom: 3,
        left: 57,
        child: Container(
          width: 3,
          color: Colors.white24,
        ),
      ),
      Positioned(
        bottom: 38,
        left: 0,
        child: IconButton(
          icon: Icon(Icons.arrow_upward, size: 23, color: Colors.white),
          onPressed: () => _nextQuestion(forward: false),
        ),
      ),
      Positioned(
        bottom: 10,
        left: 6,
        child: ClipOval(
          child: Material(
            color: Colors.white, // button color
            child: InkWell(
              splashColor: Colors.grey[350], // inkwell color
              child: SizedBox(
                  width: 35,
                  height: 35,
                  child: Icon(Icons.arrow_downward,
                      size: 21, color: Colors.grey[800])),
              onTap: _nextQuestion,
            ),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.indigo, Colors.deepPurple],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.5, 0.7]),
        ),
        child: Stack(
          children: [
            ...staticElements(),
            AnimatedOpacity(
              duration: Duration(seconds: 2),
              opacity: _isVisible ? 1 : 0,
              child: QuestionWidget(
                questionIndex: _questionIndex,
                question: questions[_questionIndex],
                nextQuestion: _nextQuestion,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
