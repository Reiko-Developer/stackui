import 'package:flutter/material.dart';
import 'package:stackui/model/reiko_animation_exception.dart';
import 'package:stackui/widgets/animations/reiko/animations/foo_animation.dart';

class SizeAnimation extends FooAnimation {
  @override
  Animation<Size> animation;

  @override
  Size beginValue = Size.zero, finalValue = Size(100, 100);

  SizeAnimation({
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

    animation = Tween<Size>(
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
    super.validateTimes(ReikoExceptions.SizeAnimations.index);

    if (beginValue.width == finalValue.width &&
        beginValue.height == finalValue.height) {
      throw ReikoAnimationException(
          reikoException: ReikoExceptions.SizeAnimations.index,
          message: 'The Begin and Final animation values can\'t be equal.',
          code: 3);
    }

    if (beginValue.width < 0 ||
        finalValue.width < 0 ||
        beginValue.height < 0 ||
        finalValue.height < 0)
      throw ReikoAnimationException(
          reikoException: ReikoExceptions.SizeAnimations.index,
          message:
              'The Begin and Final animation values can\'t be lower than zero.',
          code: 3);
  }
}
