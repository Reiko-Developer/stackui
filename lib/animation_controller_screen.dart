import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimationControllerScreen extends StatefulWidget {
  static final routeName = '/animation-controller';

  @override
  _AnimationControllerScreenState createState() =>
      _AnimationControllerScreenState();
}

class _AnimationControllerScreenState extends State<AnimationControllerScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animationController.forward();
  }

  Card _myCard(String txt) {
    return Card(
      child: Container(
        height: 300,
        width: 300,
        child: Center(
          child: Text(txt),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AnimatedBuilder(
          animation: _animationController,
          child: _myCard('1'),
          builder: (context, child) {
            return Transform.rotate(
              angle: _animationController.value * math.pi * 2,
              child: child,
            );
          }),
    );
  }
}
