import 'package:flutter/material.dart';

//Classe que gerencia animações de opacidade.
class OpacityAnimations {
  Animation<double> animation;
  final AnimationController controller;
  final List<TweenSequenceItem<double>> sequence;

  OpacityAnimations(this.controller, this.sequence)
      : animation = TweenSequence(sequence).animate(controller);
}
