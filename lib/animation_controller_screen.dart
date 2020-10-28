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
      borderOnForeground: false,
      // color: Colors.red,
      elevation: 30,
      child: Container(
        height: 300,
        width: 300,
        child: Center(
          child: Text(
            txt,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          child: _myCard('1'),
          builder: (context, child) {
            return Transform.rotate(
              alignment: Alignment.center,
              angle: _animationController.value * math.pi * 4,
              child: child,
            );
          },
        ),
      ),
    );
  }
}
