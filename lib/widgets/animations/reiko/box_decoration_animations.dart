import 'package:flutter/material.dart';

//Classe que gerencia animações de opacidade.
class BoxDecorationAnimations {
  Animation<Decoration> animation;
  final AnimationController controller;
  final List<TweenSequenceItem<Decoration>> sequence;

  BoxDecorationAnimations(this.controller, this.sequence)
      : animation = TweenSequence(sequence).animate(controller);
}
