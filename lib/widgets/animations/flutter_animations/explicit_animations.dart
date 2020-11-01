import 'package:flutter/material.dart';

class ExplicitAnimations extends StatefulWidget {
  static final routeName = '/explicit-animations';
  @override
  _ExplicitAnimationsState createState() => _ExplicitAnimationsState();
}

class _ExplicitAnimationsState extends State<ExplicitAnimations>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  static final Image image = Image.asset('assets/images/smallwarrior.jpg');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (controller.isAnimating) {
                controller.stop();
              } else {
                controller.repeat();
              }
            },
            onDoubleTap: () => controller.forward(),
            child: Align(
              alignment: Alignment.center,
              child: RotationTransition(
                turns: controller,
                alignment: Alignment.center,
                child: Center(
                  child: image,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
