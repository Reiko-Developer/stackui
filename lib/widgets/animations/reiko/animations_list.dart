import 'package:flutter/material.dart';
import 'package:stackui/model/reiko_animation_exception.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class AnimationsList {
  AnimationsList({this.depthPerspective = 0.001});

  ///This value sets the depthPerspective for the given animation.
  ///By default the value is 0.001
  final double depthPerspective;
  final List<TweenSequenceItem<double>> opacityLs = [
    TweenSequenceItem(tween: ConstantTween<double>(1), weight: 1),
  ];
  final List<TweenSequenceItem<Decoration>> decorationLs = [];
  final List<TweenSequenceItem<RelativeRect>> rectLs = [];
  final List<TweenSequenceItem<math.Vector3>> threeDLs = [
    TweenSequenceItem(
      tween: ConstantTween<math.Vector3>(math.Vector3(0, 0, 0)),
      weight: 1,
    ),
  ];

  final List<TweenSequenceItem<Size>> sizeLs = [];
  final List<TweenSequenceItem<Offset>> slideLs = [];
  final List<TweenSequenceItem<Color>> colorLs = [];
  final List<TweenSequenceItem<Offset>> scaleLs = [
    TweenSequenceItem<Offset>(
      tween: ConstantTween(Offset(1, 1)),
      weight: 1,
    )
  ];

  isValid() {
    if (colorLs.isNotEmpty && decorationLs.isNotEmpty) {
      throw ReikoAnimationException(
        message:
            "You can't use both color and decoration animations, choose only one.",
        reikoException: ReikoExceptions.ColorAndDecorationException,
      );
    } else if (rectLs.isNotEmpty && (slideLs.isNotEmpty || sizeLs.isNotEmpty)) {
      throw ReikoAnimationException(
        message:
            "You can't use both Position and Slide, or Size, animations.\n" +
                'Choose Or Slide and Size, Or Position animation.',
        reikoException: ReikoExceptions.ColorAndDecorationException,
      );
    }
  }

  void addOpacityAnimations(List<OpacityAnimation> ls) {
    if (ls.isEmpty || ls == null) return;

    List<TweenSequenceItem<double>> tmp = [];
    for (var i in ls) {
      if (i.endValue == null) {
        tmp.add(TweenSequenceItem<double>(
          tween: ConstantTween<double>(i.value),
          weight: i.weight,
        ));
      } else
        tmp.add(TweenSequenceItem<double>(
          tween: Tween<double>(
            begin: i.value,
            end: i.endValue,
          ),
          weight: i.weight,
        ));
    }

    opacityLs.clear();
    opacityLs.addAll(tmp);
  }

  void addDecorationAnimations(List<DecorationAnimation> ls) {
    if (ls.isEmpty || ls == null) return;

    List<TweenSequenceItem<Decoration>> tmp = [];
    for (var i in ls) {
      if (i.endValue == null) {
        tmp.add(TweenSequenceItem<Decoration>(
          tween: ConstantTween<Decoration>(i.value),
          weight: i.weight,
        ));
      } else
        tmp.add(TweenSequenceItem<Decoration>(
          weight: i.weight,
          tween: DecorationTween(begin: i.value, end: i.endValue),
        ));
    }
    decorationLs.clear();
    decorationLs.addAll(tmp);
  }

  ///An animation that must be inside a [Stack] widget, otherwise, will throw an exception.
  void addPositionAnimations(List<RelativeRectAnimation> ls) {
    if (ls.isEmpty || ls == null) return;

    List<TweenSequenceItem<RelativeRect>> tmp = [];
    for (var i in ls) {
      if (i.endValue == null) {
        tmp.add(TweenSequenceItem<RelativeRect>(
          tween: ConstantTween<RelativeRect>(i.value),
          weight: i.weight,
        ));
      } else
        tmp.add(TweenSequenceItem<RelativeRect>(
          tween: RelativeRectTween(begin: i.value, end: i.endValue),
          weight: i.weight,
        ));
    }
    rectLs.clear();
    rectLs.addAll(tmp);
  }

  void addSizeAnimations(List<SizeAnimation> ls) {
    if (ls.isEmpty || ls == null) return;

    List<TweenSequenceItem<Size>> tmp = [];
    for (var i in ls) {
      if (i.endValue == null) {
        tmp.add(TweenSequenceItem(
          tween: ConstantTween<Size>(i.value),
          weight: i.weight,
        ));
      } else
        tmp.add(TweenSequenceItem(
          tween: Tween<Size>(
            begin: i.value,
            end: i.endValue,
          ),
          weight: i.weight,
        ));
    }
    sizeLs.clear();
    sizeLs.addAll(tmp);
  }

  void addSlideAnimations(List<SlideAnimation> ls) {
    if (ls.isEmpty || ls == null) return;

    List<TweenSequenceItem<Offset>> tmp = [];
    for (var i in ls) {
      if (i.endValue == null) {
        tmp.add(TweenSequenceItem(
          tween: ConstantTween<Offset>(i.value),
          weight: i.weight,
        ));
      } else
        tmp.add(TweenSequenceItem(
          tween: Tween<Offset>(begin: i.value, end: i.endValue),
          weight: i.weight,
        ));
    }
    slideLs.clear();
    slideLs.addAll(tmp);
  }

  void addScaleAnimations(List<ScaleAnimation> ls) {
    if (ls.isEmpty || ls == null) return;

    List<TweenSequenceItem<Offset>> tmp = [];

    for (var i in ls) {
      if (i.endValue == null) {
        tmp.add(TweenSequenceItem<Offset>(
            tween: ConstantTween(i.value), weight: 1));
      } else
        tmp.add(TweenSequenceItem<Offset>(
          tween: Tween<Offset>(begin: i.value, end: i.endValue),
          weight: 1,
        ));
    }
    scaleLs.clear();
    scaleLs.addAll(tmp);
  }
}

class OpacityAnimation {
  const OpacityAnimation(
      {@required this.weight, @required this.value, this.endValue});
  final double weight;
  final double value, endValue;
}

class DecorationAnimation {
  const DecorationAnimation(
      {@required this.weight, @required this.value, this.endValue});

  final double weight;
  final Decoration value, endValue;
}

class RelativeRectAnimation {
  const RelativeRectAnimation(
      {@required this.weight, @required this.value, this.endValue});
  final double weight;
  final RelativeRect value, endValue;
}

class ThreeDAnimation {
  const ThreeDAnimation({this.weight, this.value, this.endValue});

  final double weight;
  final Vector3 value;
  final Vector3 endValue;
}

class Vector3 {
  const Vector3(this.x, this.y, this.z);
  final double x, y, z;
}

class SizeAnimation {
  const SizeAnimation(
      {@required this.weight, @required this.value, this.endValue});
  final double weight;
  final Size value, endValue;
}

class SlideAnimation {
  const SlideAnimation(
      {@required this.weight, @required this.value, this.endValue});
  final double weight;
  final Offset value, endValue;
}

class ColorAnimation {
  const ColorAnimation(
      {@required this.weight, @required this.value, this.endValue});
  final double weight;
  final Color value, endValue;
}

class ScaleAnimation {
  const ScaleAnimation(
      {@required this.weight, @required this.value, this.endValue});
  final double weight;
  final Offset value, endValue;
}

class PositionedAnimations {
  final Animation<RelativeRect> animation;
  final AnimationController controller;
  final List<TweenSequenceItem<RelativeRect>> sequenceList;

  PositionedAnimations(this.controller, this.sequenceList)
      : animation = TweenSequence(sequenceList).animate(controller);
}

class OpacityAnimations {
  Animation<double> animation;
  final AnimationController controller;
  final List<TweenSequenceItem<double>> sequence;

  OpacityAnimations(this.controller, this.sequence)
      : animation = TweenSequence(sequence).animate(controller);
}

class DecorationAnimations {
  Animation<Decoration> animation;
  final AnimationController controller;
  final List<TweenSequenceItem<Decoration>> sequence;

  DecorationAnimations(this.controller, this.sequence)
      : animation = TweenSequence(sequence).animate(controller);
}

class ScaleAnimations {
  final Animation<Offset> animation;
  final AnimationController controller;
  final List<TweenSequenceItem<Offset>> sequenceList;

  ScaleAnimations(this.controller, this.sequenceList)
      : animation = TweenSequence(sequenceList).animate(controller);
}

class ColorAnimations {
  final Animation<Color> animation;
  final AnimationController controller;
  final List<TweenSequenceItem<Color>> sequenceList;

  ColorAnimations(this.controller, this.sequenceList)
      : animation = TweenSequence(sequenceList).animate(controller);
}

class SizeAnimations {
  final Animation<Size> animation;
  final AnimationController controller;
  final List<TweenSequenceItem<Size>> sequenceList;

  SizeAnimations(this.controller, this.sequenceList)
      : animation = TweenSequence(sequenceList).animate(controller);
}

class SlideAnimations {
  Animation<Offset> animation;
  final AnimationController controller;
  final List<TweenSequenceItem<Offset>> sequence;

  SlideAnimations(this.controller, this.sequence)
      : animation = TweenSequence(sequence).animate(controller);
}

class ThreeDAnimations {
  ThreeDAnimations(this.controller, this.sequenceList)
      : animation = TweenSequence(sequenceList).animate(controller);

  final Animation<math.Vector3> animation;

  final AnimationController controller;

  final List<TweenSequenceItem<math.Vector3>> sequenceList;
}
