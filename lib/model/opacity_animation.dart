import 'package:flutter/material.dart';
import 'package:stackui/model/reiko_animation_exception.dart';

class OpacityAnimation {
  final AnimationController controller;
  Animation<double> animation;
  double beginValue, endValue;
  double startAnimation, endAnimation;

  OpacityAnimation(
      {@required this.controller,
      this.beginValue,
      this.endValue,
      this.startAnimation,
      this.endAnimation}) {
    initialize();
  }

  initialize() {
    validate();
    animation = Tween<double>(
      begin: beginValue,
      end: endValue,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          startAnimation,
          endAnimation,
          curve: Curves.linear,
        ),
      ),
    );
  }

  void validate() {
    beginValue = isBetweenOneAndZero(beginValue) ? beginValue : 0;
    endValue = isBetweenOneAndZero(endValue) ? endValue : 1;

    startAnimation = isBetweenOneAndZero(startAnimation) ? startAnimation : 0;
    endAnimation = isBetweenOneAndZero(endAnimation) ? endAnimation : 1;

    if (beginValue == endValue)
      throw ReikoAnimationException(
          'The begin and end values of the animation are equal.', -1);
    else if (endAnimation <= startAnimation)
      throw ReikoAnimationException(
          'The end animation value can\'t be lower than the start value .', -2);
  }

  //is valid when the value is between 0 and 1
  bool isBetweenOneAndZero(value) {
    if (value == null || value < 0 || value > 1)
      return false;
    else
      return true;
  }
}
