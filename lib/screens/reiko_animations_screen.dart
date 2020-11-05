import 'dart:math';

import 'package:flutter/material.dart';

import 'package:stackui/widgets/animations/reiko/handlers/handle_3dX_animations.dart';
import 'package:stackui/widgets/animations/reiko/handlers/handle_color_animations.dart';
import 'package:stackui/widgets/animations/reiko/handlers/handle_translate_animations.dart';
import 'package:stackui/widgets/animations/reiko/handlers/opacity_animations.dart';
import 'package:stackui/widgets/animations/reiko/handlers/size_animations.dart';
import 'package:stackui/widgets/animations/reiko/render_animations.dart';

class ReikoAnimationsScreen extends StatefulWidget {
  static final routeName = '/reiko-animations-screen';

  final List<TweenSequenceItem<Size>> sizeSequenceList = [
    TweenSequenceItem<Size>(
      tween: Tween<Size>(
        begin: Size.zero,
        end: Size(100, 100),
      ).chain(
        CurveTween(curve: Curves.linear),
      ),
      weight: 1,
    ),
    TweenSequenceItem<Size>(
      tween: ConstantTween<Size>(
        Size(100, 100),
      ),
      weight: 1,
    ),
  ];

  final List<TweenSequenceItem<double>> opacitySequenceList = [
    TweenSequenceItem<double>(
      tween: Tween<double>(
        begin: 0,
        end: 1,
      ).chain(
        CurveTween(curve: Curves.linear),
      ),
      weight: 1,
    ),
    TweenSequenceItem<double>(
      tween: ConstantTween<double>(0),
      weight: 1,
    ),
  ];

  @override
  _ReikoAnimationsScreenState createState() => _ReikoAnimationsScreenState();
}

class _ReikoAnimationsScreenState extends State<ReikoAnimationsScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  OpacityAnimations opacityAnimations;
  SizeAnimations sizeAnimations;

  var translateAnimations = HandleTranslateAnimations();
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
    opacityAnimations = OpacityAnimations(_controller);

    //Setando configuração de animações de tamanho
    sizeAnimations = SizeAnimations(_controller, widget.sizeSequenceList);

    //Setando configuração de animações de movimento
    //Somente é possível dentro de um widget do tipo Stack.
    addTranslateAnimations();
    translateAnimations.controller = _controller;

    //Setando configuração de animações de cor
    // addColorAnimations();
    // colorAnimations.controller = _controller;

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
    opacityAnimations.add(OpacityAnimation(begin: 1, end: 0));
    opacityAnimations.add(OpacityAnimation());
    opacityAnimations.add(OpacityAnimation(begin: 1, end: 0));
    opacityAnimations.add(OpacityAnimation());
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
      finalValue: Colors.red,
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
      body: Center(
        child: Container(
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
      ),
    );
  }
}
