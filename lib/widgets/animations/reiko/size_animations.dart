import 'package:flutter/material.dart';

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
  }) : constant = false;
}
