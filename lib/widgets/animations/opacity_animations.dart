import 'package:flutter/material.dart';

import 'package:stackui/model/reiko_animation_exception.dart';

//Para que seja executada, deve ser passado um controlador.
class OpacityAnimations {
  AnimationController _controller;
  List<OpacityAnimation> animations = List<OpacityAnimation>();
  int aux = 0;

  set controller(AnimationController controller) {
    _controller = controller;

    for (int i = 0; i < animations.length; i++) {
      animations[i].createAnimation(newController: _controller);
    }
  }

  //Retorna falso se:
  //1º Valores de: valor inicial/final ou início/fim da animação, estiverem fora do intervalo [0-1]
  //2º Valor inicial e final da animação forem iguais.
  //3º Valor de início da animação for maior que o valor de fim da mesma.
  //4º Intervalo de tempo de animações não for sequencial.
  add({
    controller,
    beginValue = 0.0,
    finalValue = 1.0,
    start = 0.0,
    end = 1.0,
    curve = Curves.linear,
  }) {
    //
    var newAnimation = OpacityAnimation(
      controller: controller,
      beginValue: beginValue,
      finalValue: finalValue,
      startAnimation: start,
      endAnimation: end,
      curve: curve,
    );

    newAnimation.validate();
    animations.add(newAnimation);
    validateIntervalBetweenAnimations();
  }

  //Checks the interval between animations, select the current animation and returns it's value.
  //Problems:
  //1. There's no current animation to execute.
  //   a: In case there's a valid old value, return it.
  //   b: Otherwise, return the value of the first animation.

  double actualAnimationValue(
      {@required double controllerValue, double oldValidValue = -1}) {
    for (var a in animations) {
      if (a.endAnimation >= controllerValue) return a.finalValue;
    }

    //Se houver um valor antigo válido, retorne-o, caso contrário,
    //retorne o primeiro valor válido para esse tipo de animação.
    return oldValidValue == -1 ? animations[0].beginValue : oldValidValue;
  }

  validateIntervalBetweenAnimations() {
    for (var i = 0; i < animations.length - 1; i++) {
      for (var j = i + 1; j < animations.length; j++) {
        if (animations[i].endAnimation > animations[j].startAnimation)
          throw ReikoAnimationException(
              'The interval between same type animations must be sequencial.\n' +
                  'But, animation $i and $j don\'t follow the rule.\n' +
                  '$i: ${animations[i]} \n$j: ${animations[j]}',
              5);
      }
    }
  }
}

class OpacityAnimation {
  AnimationController controller;
  Animation<double> _animation;
  double beginValue, finalValue;
  double startAnimation, endAnimation;
  Curve curve;

  OpacityAnimation({
    this.controller,
    this.beginValue,
    this.finalValue,
    this.startAnimation,
    this.endAnimation,
    this.curve = Curves.linear,
  }) {
    if (this.controller != null) {
      createAnimation();
    }
  }

  Animation<double> get animation {
    return _animation;
  }

  //Atribui o controller para a animação
  createAnimation({newController}) {
    if (_animation != null) print('A animação já foi setada anteriormente');

    _animation = Tween<double>(
      begin: beginValue,
      end: finalValue,
    ).animate(
      CurvedAnimation(
        parent: newController,
        curve: Interval(
          startAnimation,
          endAnimation,
          curve: Curves.linear,
        ),
      ),
    );
  }

  //1º Retorna false se o valor inicial/final ou início/fim da animação,
  //estiverem fora do intervalo [0-1]
  validValues() {
    if (!isBetween(beginValue) || !isBetween(finalValue))
      throw ReikoAnimationException(
        'The Begin and Final animation values must be in the [0...1] interval.',
        1,
      );

    if (!isBetween(startAnimation) || !isBetween(endAnimation)) return false;
    throw ReikoAnimationException(
      'The Start and End time animation values must be in the [0...1] interval.',
      2,
    );
  }

  bool isBetween(value) {
    if (value == null || value < 0 || value > 1)
      return false;
    else
      return true;
  }

  //Retorna false se:
  //1º Valor inicial e final da animação forem iguais.
  //2º Valor de tempo de início da animação for maior ou igual ao valor de fim da mesma.
  validate() {
    if (beginValue == finalValue)
      throw ReikoAnimationException(
          'The Begin and Final animation values can\'t be equal.', 3);
    else if (startAnimation >= endAnimation)
      throw ReikoAnimationException(
          'The end animation value can\'t be lower than the start value.', 4);
  }

  @override
  String toString() {
    String result =
        'Start/end animation values: ($startAnimation, $endAnimation).';
    return result;
  }
}
