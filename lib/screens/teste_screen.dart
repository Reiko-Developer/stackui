import 'package:flutter/material.dart';
import 'package:stackui/widgets/animations/opacity_animations.dart';
import 'package:stackui/widgets/animations/reiko_render_animations.dart';
import 'package:stackui/widgets/animations/size_animations.dart';
import 'package:stackui/widgets/animations/translate_animations.dart';

class TesteScreen extends StatefulWidget {
  static final routeName = '/teste';

  @override
  _TesteScreenState createState() => _TesteScreenState();
}

class _TesteScreenState extends State<TesteScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  var opacityAnimations = new OpacityAnimations();
  var translateAnimations = new TranslateAnimations();
  var sizeAnimations = new SizeAnimations();

  @override
  void initState() {
    super.initState();
    //Creating the controller for the animations.
    _controller = new AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..addStatusListener((status) => print(status));

    //Setando configuração de animações de opacidade
    addOpacityAnimations();
    opacityAnimations.controller = _controller;

    //Setando configuração de animações de movimento
    //Somente é possível dentro de um widget do tipo Stack.
    addTranslateAnimations();
    translateAnimations.controller = _controller;

    //Setando configuração de animações de movimento
    addSizeAnimations();
    sizeAnimations.controller = _controller;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  addOpacityAnimations() {
    opacityAnimations.add(
        beginValue: 0.0,
        finalValue: 1.0,
        start: 0.0,
        end: 0.25,
        curve: Curves.linear);

    opacityAnimations.add(
        beginValue: 1.0,
        finalValue: 0.0,
        start: 0.25,
        end: 0.5,
        curve: Curves.linear);

    opacityAnimations.add(
        beginValue: 0.0,
        finalValue: 1.0,
        start: 0.5,
        end: 0.75,
        curve: Curves.linear);

    opacityAnimations.add(
        beginValue: 1.0,
        finalValue: 0.5,
        start: 0.75,
        end: 1.0,
        curve: Curves.linear);
  }

  addTranslateAnimations() {
    translateAnimations.add(
        beginValue: Offset(50.0, 50.0),
        finalValue: Offset(250.0, 50.0),
        start: 0.0,
        end: 0.25,
        curve: Curves.linear);

    translateAnimations.add(
        beginValue: Offset(250.0, 50.0),
        finalValue: Offset(250.0, 250.0),
        start: 0.25,
        end: 0.5,
        curve: Curves.linear);

    translateAnimations.add(
        beginValue: Offset(250.0, 250.0),
        finalValue: Offset(50.0, 250.0),
        start: 0.5,
        end: 0.75,
        curve: Curves.linear);

    translateAnimations.add(
        beginValue: Offset(50.0, 250.0),
        finalValue: Offset(50.0, 50.0),
        start: 0.75,
        end: 1.0,
        curve: Curves.linear);
  }

  addSizeAnimations() {
    // sizeAnimations.add(
    //     beginValue: Size(50.0, 50.0),
    //     finalValue: Size(200.0, 200.0),
    //     start: 0.0,
    //     end: 0.5,
    //     curve: Curves.linear);

    // sizeAnimations.add(
    //     beginValue: Size(200.0, 200.0),
    //     finalValue: Size(50.0, 50.0),
    //     start: 0.5,
    //     end: 1.0,
    //     curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black45,
        child: Stack(
          children: [
            ReikoRenderAnimations(
              controller: _controller.view,
              opacityAnimations: opacityAnimations,
              translateAnimations: translateAnimations,
              sizeAnimations: sizeAnimations,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.red,
                child: Icon(Icons.add_moderator),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
