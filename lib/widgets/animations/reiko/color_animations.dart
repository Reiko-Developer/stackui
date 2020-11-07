import 'package:flutter/material.dart';

//Classe que gerencia animações de opacidade.
class ColorAnimations {
  final Animation<Color> animation;
  final AnimationController controller;
  final List<TweenSequenceItem<Color>> sequenceList;

  ColorAnimations(this.controller, this.sequenceList)
      : animation = TweenSequence(sequenceList).animate(controller);
}
