import 'package:flutter/material.dart';

class ReikoAnimations extends StatelessWidget {
  ReikoAnimations({Key key, @required this.child, this.controller})
      : firstOpacity = Tween<double>(
          begin: 0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.5,
              curve: Curves.linear,
            ),
          ),
        ),
        secondOpacity = Tween<double>(
          begin: 1,
          end: 0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.5,
              1,
              curve: Curves.linear,
            ),
          ),
        ),
        firstMove = Tween<double>(begin: 0, end: 100).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0,
              0.5,
              curve: Curves.linear,
            ),
          ),
        ),
        secondMove = Tween<double>(begin: 0, end: 100).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.5,
              1,
              curve: Curves.linear,
            ),
          ),
        ),
        firstSize = Tween<Size>(begin: Size(0, 0), end: Size(100, 100)).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0,
              0.5,
              curve: Curves.linear,
            ),
          ),
        ),
        secondSize =
            Tween<Size>(begin: Size(0, 0), end: Size(100, 100)).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.5,
              1,
              curve: Curves.linear,
            ),
          ),
        ),
        super(key: key);

  final AnimationController controller;
  final Animation<double> firstOpacity;
  final Animation<double> secondOpacity;
  final Animation<double> firstMove;
  final Animation<double> secondMove;
  final Animation<Size> firstSize;
  final Animation<Size> secondSize;

  final Widget child;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Container(
      child: Opacity(
        // Uses the first value for the first part (half)
        // of the animation.
        opacity:
            firstOpacity.value < 1 ? firstOpacity.value : secondOpacity.value,
        child: Stack(
          children: [
            Positioned(
              bottom: firstMove.value + secondMove.value,
              left: firstMove.value + secondMove.value,
              child: Container(
                width: firstSize.value.width + secondSize.value.width,
                height: firstSize.value.height + secondSize.value.height,
                color: Colors.red,
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
      child: child,
    );
  }
}
