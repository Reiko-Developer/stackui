import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  // Leave out the height and width so it fills the animating parent
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: FlutterLogo(),
      );
}

//
class GrowTransition extends StatelessWidget {
  GrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  Widget build(BuildContext context) => Center(
        child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) => Container(
                  height: animation.value,
                  width: animation.value,
                  child: child,
                ),
            child: child),
      );
}

//Main class
class ReusableAnimation extends StatefulWidget {
  static final routeName = '/reusable-animation';

  @override
  _ReusableAnimationState createState() => _ReusableAnimationState();
}

class _ReusableAnimationState extends State<ReusableAnimation>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller);
    controller.forward();
  }
  // #enddocregion print-state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GrowTransition(
        child: LogoWidget(),
        animation: animation,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  // #docregion print-state
}
