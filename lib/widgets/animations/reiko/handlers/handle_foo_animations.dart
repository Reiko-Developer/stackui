import 'package:flutter/material.dart';

import 'package:stackui/model/reiko_animation_exception.dart';
import 'package:stackui/widgets/animations/reiko/animations/foo_animation.dart';

//Classe genérica
abstract class HandleFooAnimations {
  AnimationController _controller;
  final animations = List<FooAnimation>();

//herdar
  set controller(AnimationController controller) {
    _controller = controller;

    for (int i = 0; i < animations.length; i++) {
      animations[i].createAnimation(_controller);
    }
  }

  get controller {
    return _controller;
  }

  add();

  //Retorna o valor da animação (entre beginValue e finalValue)
  dynamic currentAnimationValue(double controllerValue);

  //Herdar
  //Intervalo de tempo de animações deve ser sequencial.
  validateIntervalBetweenAnimations() {
    for (var i = 0; i < animations.length - 1; i++) {
      for (var j = i + 1; j < animations.length; j++) {
        if (animations[i].endAnimation > animations[j].startAnimation)
          throw ReikoAnimationException(
            reikoException: ReikoExceptions.OpacityAnimations.index,
            message:
                'The interval between same type animations must be sequencial.\n' +
                    'But, animation $i and $j don\'t follow the rule.\n' +
                    '$i: ${animations[i]} \n$j: ${animations[j]}',
            code: 5,
          );
      }
    }
  }
}
