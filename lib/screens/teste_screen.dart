import 'package:flutter/material.dart';
import 'package:stackui/model/opacity_animation.dart';
import 'package:stackui/widgets/animations/reiko_opacity_animation.dart';

class TesteScreen extends StatefulWidget {
  TesteScreen({Key key}) : super(key: key);
  static final routeName = '/teste';

  @override
  _TesteScreenState createState() => _TesteScreenState();
}

class _TesteScreenState extends State<TesteScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  OpacityAnimation opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    opacityAnimation = OpacityAnimation(controller: _controller);

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ReikoOpacityAnimation(
          controller: _controller.view,
          opacityAnimation: opacityAnimation.animation,
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
