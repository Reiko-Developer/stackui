import 'package:vector_math/vector_math.dart';

import 'package:flutter/material.dart';

//Classe que gerencia animações de opacidade.
class ThreeDAnimations {
  Animation<Vector3> animation;

  final AnimationController controller;

  List<TweenSequenceItem<Vector3>> sequenceList;

  ThreeDAnimations(this.controller, this.sequenceList)
      : animation = TweenSequence(sequenceList).animate(controller);
}
