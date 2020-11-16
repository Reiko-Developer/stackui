import 'package:flutter/material.dart';

//Classe que gerencia animações de opacidade.
class DecorationAnimations {
  Animation<Decoration> animation;
  final AnimationController controller;
  final List<TweenSequenceItem<Decoration>> sequence;

  DecorationAnimations(this.controller, this.sequence)
      : animation = TweenSequence(sequence).animate(controller);
}
