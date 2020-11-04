import 'package:flutter/material.dart';

import 'package:stackui/model/reiko_animation_exception.dart';

abstract class FooAnimation {
  final animation;

  final beginValue, finalValue;

  Curve curve = Curves.linear;

  double startAnimation = 0, endAnimation = 1;

  FooAnimation({
    this.beginValue,
    this.finalValue,
    this.animation,
    this.startAnimation,
    this.endAnimation,
    this.curve,
  }) {
    validateValues();
  }

  //Implementar
  createAnimation(newController);

  //herdar
  //1º Retorna false se o valor inicial/final ou início/fim da animação,
  //estiverem fora do intervalo [0-1]
  validValues() {
    if (!isBetween(startAnimation) || !isBetween(endAnimation)) return false;
    throw ReikoAnimationException(
      reikoException: ReikoExceptions.OpacityAnimations.index,
      message:
          'The Start and End time animation values must be in the [0...1] interval.',
      code: 2,
    );
  }

  bool isBetween(value) {
    if (value == null || value < 0 || value > 1)
      return false;
    else
      return true;
  }

  //If the values for the class aren't valid, must throw an ReikoAnimationException
  validateValues();

  //herdar
  validateTimes(exception) {
    if (startAnimation >= endAnimation)
      throw ReikoAnimationException(
          reikoException: exception,
          message:
              'The end animation value can\'t be lower than the start value.\n' +
                  'Start: $startAnimation, end: $endAnimation',
          code: 4);
  }

  //herdar
  @override
  String toString() {
    String result =
        'Start/end animation values: ($startAnimation, $endAnimation).';
    return result;
  }
}
