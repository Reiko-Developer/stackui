import 'package:flutter/material.dart';

class IoioAnimation extends StatefulWidget {
  static final routeName = '/flutter-dev-anim';

  @override
  _IoioAnimationState createState() => _IoioAnimationState();
}

class _IoioAnimationState extends State<IoioAnimation>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  initState() {
    super.initState();

    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    animation = Tween<double>(begin: 1, end: 2).animate(controller)
      // #enddocregion print-state
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      })
      ..addStatusListener((state) => print('$state'))
      ..addListener(() => print('mudou o valor'));

    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedLogo(animation: animation);
}

class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          height: animation.value,
          width: animation.value,
          child: FlutterLogo(),
        ),
      ),
    );
  }
}
