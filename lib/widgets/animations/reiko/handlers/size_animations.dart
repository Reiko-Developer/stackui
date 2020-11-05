import 'package:flutter/material.dart';
import 'package:stackui/model/reiko_animation_exception.dart';

//Classe que gerencia animações de opacidade.
class SizeAnimations {
  final Animation<Size> animation;
  final AnimationController controller;
  final List<TweenSequenceItem<Size>> sequenceList;

  SizeAnimations(this.controller, this.sequenceList)
      : animation = TweenSequence(sequenceList).animate(controller);
}

class SizeAnimation {
  final Size begin, end;
  final double weight;
  final Curve curve;
  final bool constant;

  SizeAnimation({
    this.begin = Size.zero,
    this.end = const Size(100, 100),
    this.weight = 1,
    this.curve = Curves.linear,
  }) : constant = false {
    validate();
  }

  SizeAnimation.constant({
    @required value,
    this.weight = 1,
    this.curve = Curves.linear,
  })  : end = value,
        begin = value,
        this.constant = true {
    validate();
  }

  validate() {
    if (begin == end) {
      throw ReikoAnimationException(
        reikoException: ReikoExceptions.SizeAnimations.index,
        message: 'The Begin and Final animation values can\'t be equal.\n' +
            'For constant values use the constructor SizeAnimation.constant().',
        code: 3,
      );
    }
  }
}
