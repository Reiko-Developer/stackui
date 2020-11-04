import 'package:flutter/material.dart';
import 'package:stackui/model/reiko_animation_exception.dart';
import 'package:stackui/widgets/animations/reiko/animations/foo_animation.dart';

class TranslateAnimation extends FooAnimation {
  @override
  Animation<Offset> animation;

  @override
  Offset beginValue = Offset.zero, finalValue = Offset(100, 100);

  TranslateAnimation({
    this.beginValue,
    this.finalValue,
    startAnimation,
    endAnimation,
    curve,
  }) : super(
          startAnimation: startAnimation,
          endAnimation: endAnimation,
          curve: curve,
        );

  @override
  createAnimation(newController) {
    validateValues();
    animation = Tween<Offset>(
      begin: beginValue,
      end: finalValue,
    ).animate(
      CurvedAnimation(
        parent: newController,
        curve: Interval(
          startAnimation,
          endAnimation,
          curve: curve,
        ),
      ),
    );
  }

  @override
  //1º Valor inicial e final da animação forem iguais.
  //2º Valor de tempo de início da animação for maior ou igual ao valor de fim da mesma.
  validateValues() {
    super.validateTimes(ReikoExceptions.TranslateAnimations.index);

    if (beginValue.dx == finalValue.dx && beginValue.dy == finalValue.dy)
      throw ReikoAnimationException(
          reikoException: ReikoExceptions.SizeAnimations.index,
          message: 'The Begin and Final animation values can\'t be equal.',
          code: 3);
  }
}
