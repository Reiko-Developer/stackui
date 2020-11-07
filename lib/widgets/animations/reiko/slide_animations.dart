import 'package:flutter/material.dart';

/// The translation is expressed as an Offset scaled to the child's size.
///  For example, an Offset with a dx of 0.25 will result in a horizontal translation
///  of one quarter the width of the child.

class SlideAnimations {
  Animation<Offset> animation;
  final AnimationController controller;
  final List<TweenSequenceItem<Offset>> sequence;

  SlideAnimations(this.controller, this.sequence)
      : animation = TweenSequence(sequence).animate(controller);
}
