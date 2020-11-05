import 'package:flutter/material.dart';

//Classe que gerencia animações de opacidade.
class OpacityAnimations {
  Animation<double> animation;
  final AnimationController controller;
  var sequence = List<TweenSequenceItem<double>>();

  OpacityAnimations(this.controller);

  animate() {
    animation = TweenSequence(sequence).animate(controller);
  }

  add(OpacityAnimation item) {
    TweenSequenceItem tmp;
    //Possui valor constante?
    if (item.constant) {
      tmp = TweenSequenceItem<double>(
        tween: ConstantTween<double>(item.end),
        weight: item.weight,
      );
    } else
      tmp = TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: item.begin,
          end: item.end,
        ).chain(CurveTween(curve: item.curve)),
        weight: item.weight,
      );

    sequence.add(tmp);
  }
}

class OpacityAnimation {
  final double begin, end;
  final double weight;
  final Curve curve;
  final bool constant;

  OpacityAnimation({
    this.begin = 0,
    this.end = 1,
    this.weight = 1,
    this.curve = Curves.linear,
  }) : constant = false;

  OpacityAnimation.constant({
    @required value,
    this.weight = 1,
    this.curve = Curves.linear,
  })  : end = value,
        begin = value,
        this.constant = true;
}
