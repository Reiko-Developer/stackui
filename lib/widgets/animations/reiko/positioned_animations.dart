import 'package:flutter/material.dart';

//Classe que gerencia animações de deslocamento
//TODO: Permitir que o usuário escolha a direção dos deslocamento, ex.:
//bottom or top, left or right,
class PositionedAnimations {
  final Animation<RelativeRect> animation;
  final AnimationController controller;
  final List<TweenSequenceItem<RelativeRect>> sequenceList;

  PositionedAnimations(this.controller, this.sequenceList)
      : animation = TweenSequence(sequenceList).animate(controller);
}
