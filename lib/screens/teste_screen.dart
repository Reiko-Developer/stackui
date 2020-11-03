import 'package:flutter/material.dart';
import 'package:stackui/widgets/animations/opacity_animations.dart';
import 'package:stackui/widgets/animations/reiko_animations.dart';

class TesteScreen extends StatefulWidget {
  static final routeName = '/teste';

  @override
  _TesteScreenState createState() => _TesteScreenState();
}

class _TesteScreenState extends State<TesteScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  var opacityAnimations = new OpacityAnimations();

  @override
  void initState() {
    super.initState();
    //Creating the controller for the animations.
    _controller = new AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..addStatusListener((status) => print(status));

    addOpacityAnimations();
    opacityAnimations.controller = _controller;
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
        end: 0.33,
        curve: Curves.linear);

    opacityAnimations.add(
        beginValue: 1.0,
        finalValue: 0.0,
        start: 0.33,
        end: 0.66,
        curve: Curves.linear);

    opacityAnimations.add(
        beginValue: 0.0,
        finalValue: 1.0,
        start: 0.66,
        end: 0.8,
        curve: Curves.linear);

    opacityAnimations.add(
        beginValue: 1.0,
        finalValue: 0.5,
        start: 0.8,
        end: 1.0,
        curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReikoRenderAnimations(
        controller: _controller.view,
        opacityAnimations: opacityAnimations.animations,
        translateAnimations: [],
        child: Center(
          child: Container(
            width: 100,
            height: 100,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
