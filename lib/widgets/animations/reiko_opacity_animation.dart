import 'package:flutter/material.dart';

class ReikoOpacityAnimation extends StatelessWidget {
  ReikoOpacityAnimation(
      {Key key,
      @required this.child,
      @required this.opacityAnimation,
      this.controller})
      : super(key: key);

  final AnimationController controller;
  final Animation<double> opacityAnimation;

  final Widget child;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Opacity(
      opacity: opacityAnimation.value,
      child: child,
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
