import 'dart:math';

import 'package:flutter/material.dart';

import 'package:stackui/widgets/animations/reiko/handlers/handle_3dX_animations.dart';
import 'package:stackui/widgets/animations/reiko/handlers/handle_color_animations.dart';
import 'package:stackui/widgets/animations/reiko/handlers/handle_opacity_animations.dart';
import 'package:stackui/widgets/animations/reiko/handlers/handle_size_animations.dart';
import 'package:stackui/widgets/animations/reiko/handlers/handle_translate_animations.dart';
import 'package:stackui/widgets/animations/reiko/render_animations.dart';

class TesteScreen extends StatefulWidget {
  static final routeName = '/teste';

  @override
  _TesteScreenState createState() => _TesteScreenState();
}

class _TesteScreenState extends State<TesteScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  var opacityAnimations = HandleOpacityAnimations();
  var translateAnimations = HandleTranslateAnimations();
  var sizeAnimations = HandleSizeAnimations();
  var colorAnimations = HandleColorAnimations();
  var threeDAnimations = Handle3DXAnimations();

  @override
  void initState() {
    super.initState();
    //Creating the controller for the animations.
    _controller = new AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..addStatusListener((status) => print(status));

    //Setando configuração de animações de opacidade
    // addOpacityAnimations();
    // opacityAnimations.controller = _controller;

    //Setando configuração de animações de movimento
    //Somente é possível dentro de um widget do tipo Stack.
    addTranslateAnimations();
    translateAnimations.controller = _controller;

    //Setando configuração de animações de tamanho
    addSizeAnimations();
    sizeAnimations.controller = _controller;

    //Setando configuração de animações de cor
    addColorAnimations();
    colorAnimations.controller = _controller;

    //Setando configuração de animações 3d
    add3DAnimations();
    threeDAnimations.controller = _controller;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  addOpacityAnimations() {
    // opacityAnimations.add(
    //     beginValue: 0.0,
    //     finalValue: 1.0,
    //     startAnimation: 0.0,
    //     endAnimation: 0.25,
    //     curve: Curves.linear);

    // opacityAnimations.add(
    //     beginValue: 1.0,
    //     finalValue: 0.0,
    //     startAnimation: 0.25,
    //     endAnimation: 0.5,
    //     curve: Curves.linear);

    // opacityAnimations.add(
    //     beginValue: 0.0,
    //     finalValue: 1.0,
    //     startAnimation: 0.5,
    //     endAnimation: 0.75,
    //     curve: Curves.linear);

    // opacityAnimations.add(
    //     beginValue: 1.0,
    //     finalValue: 0.5,
    //     startAnimation: 0.75,
    //     endAnimation: 1.0,
    //     curve: Curves.linear);
  }

  addTranslateAnimations() {
    translateAnimations.add(
        beginValue: Offset(50.0, 50.0),
        finalValue: Offset(250.0, 50.0),
        startAnimation: 0.0,
        endAnimation: 0.25,
        curve: Curves.linear);

    translateAnimations.add(
        beginValue: Offset(250.0, 50.0),
        finalValue: Offset(250.0, 250.0),
        startAnimation: 0.25,
        endAnimation: 0.5,
        curve: Curves.linear);

    translateAnimations.add(
        beginValue: Offset(250.0, 250.0),
        finalValue: Offset(50.0, 250.0),
        startAnimation: 0.5,
        endAnimation: 0.75,
        curve: Curves.linear);

    translateAnimations.add(
        beginValue: Offset(50.0, 250.0),
        finalValue: Offset(50.0, 50.0),
        startAnimation: 0.75,
        endAnimation: 1.0,
        curve: Curves.linear);
  }

  addSizeAnimations() {
    sizeAnimations.add(
        beginValue: Size(50.0, 100),
        finalValue: Size(100.0, 100),
        startAnimation: 0.0,
        endAnimation: 0.5,
        curve: Curves.linear);

    sizeAnimations.add(
        beginValue: Size(100.0, 100),
        finalValue: Size(50.0, 100),
        startAnimation: 0.5,
        endAnimation: 1.0,
        curve: Curves.linear);
  }

  addColorAnimations() {
    colorAnimations.add(
      beginValue: Colors.red,
      finalValue: Colors.black87,
      start: 0.0,
      end: 0.33,
      curve: Curves.linear,
    );
    colorAnimations.add(
      beginValue: Colors.black87,
      finalValue: Colors.yellow,
      start: 0.33,
      end: 0.66,
      curve: Curves.linear,
    );
    colorAnimations.add(
      beginValue: Colors.yellow,
      finalValue: Colors.transparent,
      start: 0.66,
      end: 1.0,
      curve: Curves.linear,
    );
  }

  add3DAnimations() {
    threeDAnimations.add(
      x: true,
      y: true,
      z: false,
      beginValue: 0.0,
      finalValue: pi,
      startAnimation: 0.0,
      endAnimation: 1.0,
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black45,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ReikoRenderAnimations(
              controller: _controller.view,
              opacity: opacityAnimations,
              translate: translateAnimations,
              size: sizeAnimations,
              threeD: threeDAnimations,
              //To add color animation u can't set the color of the container
              color: colorAnimations,
              child: Container(
                width: 100,
                height: 100,
                // color: Colors.red,
                child: Icon(Icons.add_moderator),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
