import 'package:flutter/material.dart';
import 'package:stackui/model/reiko_animation_exception.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class AnimationsList {
  AnimationsList({
    this.decorationList = const [],
    this.relativeRectList = const [],
    this.threeDList = const [],
    this.slideList = const [],
    this.colorList = const [],
    this.scaleList = const [],
    this.opacityList = const [],
    this.matrix4DepthPerspective = 0.001,
  }) {
    isValid();
    assert(matrix4DepthPerspective != null);
  }

  ///This value sets the depthPerspective for the given animation.
  ///By default the value is 0.001
  final double matrix4DepthPerspective;
  final List<OpacityAnimation> opacityList;
  final List<DecorationAnimation> decorationList;

  final List<RelativeRectAnimation> relativeRectList;
  final List<ThreeDAnimation> threeDList;

  final List<SlideAnimation> slideList;
  final List<ColorAnimation> colorList;
  final List<ScaleAnimation> scaleList;

  isValid() {
    if (colorList.isNotEmpty && decorationList.isNotEmpty) {
      throw ReikoAnimationException(
        message:
            "You can't use both color and decoration animations, choose only one.",
        reikoException: ReikoExceptions.DecorationException,
      );
    } else if (relativeRectList.isNotEmpty && slideList.isNotEmpty) {
      throw ReikoAnimationException(
        message: "You can't use both Position and Slide animations.\n" +
            'Choose one, or Slide or Position animation.',
        reikoException: ReikoExceptions.MovementException,
      );
    }
  }

  TweenSequence<double> get opacityTweenSequence {
    List<TweenSequenceItem<double>> tmp = [];
    for (var i in opacityList) {
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

    return tmp.isEmpty ? null : TweenSequence<double>(tmp);
  }

  TweenSequence<Decoration> get decorationTweenSequence {
    List<TweenSequenceItem<Decoration>> tmp = [];
    for (var i in decorationList) {
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
    return tmp.isEmpty ? null : TweenSequence<Decoration>(tmp);
  }

  ///An animation that must be inside a [Stack] widget, otherwise, will throw an exception.
  TweenSequence<RelativeRect> get relativeRectTweenSequence {
    List<TweenSequenceItem<RelativeRect>> tmp = [];
    for (var i in relativeRectList) {
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

    return relativeRectList.isEmpty ? null : TweenSequence<RelativeRect>(tmp);
  }

  TweenSequence<Offset> get slidetTweenSequence {
    List<TweenSequenceItem<Offset>> tmp = [];
    for (var i in slideList) {
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

    return slideList.isEmpty ? null : TweenSequence<Offset>(tmp);
  }

  TweenSequence<Offset> get scaleTweenSequence {
    List<TweenSequenceItem<Offset>> tmp = [];

    for (var i in scaleList) {
      if (i.endValue == null) {
        tmp.add(TweenSequenceItem<Offset>(
            tween: ConstantTween(i.value), weight: 1));
      } else
        tmp.add(TweenSequenceItem<Offset>(
          tween: Tween<Offset>(begin: i.value, end: i.endValue),
          weight: 1,
        ));
    }
    return scaleList.isEmpty ? null : TweenSequence<Offset>(tmp);
  }

  TweenSequence<math.Vector3> get threeDTweenSequence {
    List<TweenSequenceItem<math.Vector3>> tmp = [];

    for (var i in threeDList) {
      if (i.endValue == null) {
        tmp.add(TweenSequenceItem<math.Vector3>(
            tween: ConstantTween<math.Vector3>(i.value), weight: 1));
      } else
        tmp.add(TweenSequenceItem<math.Vector3>(
          tween: Tween<math.Vector3>(begin: i.value, end: i.endValue),
          weight: 1,
        ));
    }
    return scaleList.isEmpty ? null : TweenSequence<math.Vector3>(tmp);
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
  final math.Vector3 value;
  final math.Vector3 endValue;
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
