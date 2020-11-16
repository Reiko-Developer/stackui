import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vector_math/vector_math.dart' as math;
import 'package:stackui/widgets/animations/reiko/render_animations.dart';

class ReikoAnimationsScreen extends StatelessWidget {
  const ReikoAnimationsScreen();
  static final routeName = '/reiko-animations-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const RContainer(),
          const MyWidget(),
        ],
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget();

  @override
  createState() => _MyWidget();
}

class _MyWidget extends State<MyWidget> {
  _MyWidget() {
    init();
  }
  var animationsList = AnimationsList();

  void init() {
    animationsList.addOpacityAnimations(
      [const OpacityAnimation(weight: 1, value: 0, endValue: 1)],
    );

    animationsList.addPositionAnimations(
      [
        const RelativeRectAnimation(
          weight: 1,
          value: const RelativeRect.fromLTRB(0, 0, 250, 350),
          endValue: const RelativeRect.fromLTRB(200, 200, 0, 0),
        )
      ],
    );

    animationsList.addDecorationAnimations([
      DecorationAnimation(
        weight: 1,
        value: BoxDecoration(
          color: Colors.red,
          border: Border.all(style: BorderStyle.none),
          borderRadius: BorderRadius.circular(60.0),
          shape: BoxShape.rectangle,
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color(0x66666666),
              blurRadius: 10.0,
              spreadRadius: 3.0,
              offset: const Offset(0, 6.0),
            )
          ],
        ),
        endValue: BoxDecoration(
          color: Colors.blue,
          border: Border.all(
            style: BorderStyle.none,
          ),
          borderRadius: BorderRadius.zero,
          // No shadow.
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return RenderAnimations(
      duration: const Duration(seconds: 2),
      alignment: Alignment.center,
      runAnimation: () => print('clicked'),
      animationsList: animationsList,
      child: const Text('Reiko-Dev'),
    );
  }
}

class AnimationsList {
  //TODO: add default Values
  List<TweenSequenceItem<double>> opacityLs = [
    TweenSequenceItem(tween: ConstantTween<double>(1), weight: 1),
  ];
  List<TweenSequenceItem<Decoration>> decorationLs = [];
  List<TweenSequenceItem<RelativeRect>> rectLs = [];
  List<TweenSequenceItem<math.Vector3>> threeDLs = [];
  List<TweenSequenceItem<Size>> sizeLs = [];
  List<TweenSequenceItem<Offset>> slideLs = [];
  List<TweenSequenceItem<Color>> colorLs = [];

  void addOpacityAnimations(List<OpacityAnimation> ls) {
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

    opacityLs = tmp;
  }

  //TODO: set the values as a new List.
  void addDecorationAnimations(List<DecorationAnimation> ls) {
    for (var i in ls) {
      if (i.endValue == null) {
        decorationLs.add(TweenSequenceItem<Decoration>(
          tween: ConstantTween<Decoration>(i.value),
          weight: i.weight,
        ));
      } else
        decorationLs.add(TweenSequenceItem<Decoration>(
          weight: i.weight,
          tween: DecorationTween(begin: i.value, end: i.endValue),
        ));
    }
  }

  void addPositionAnimations(List<RelativeRectAnimation> ls) {
    for (var i in ls) {
      if (i.endValue == null) {
        rectLs.add(TweenSequenceItem<RelativeRect>(
          tween: ConstantTween<RelativeRect>(i.value),
          weight: i.weight,
        ));
      } else
        rectLs.add(TweenSequenceItem<RelativeRect>(
          tween: RelativeRectTween(begin: i.value, end: i.endValue),
          weight: i.weight,
        ));
    }
  }

  void addThreeDAnimations(List<ThreeDAnimation> ls) {
    for (var i in ls) {
      if (i.endValue == null) {
        threeDLs.add(TweenSequenceItem(
          tween: ConstantTween<math.Vector3>(i.value),
          weight: i.weight,
        ));
      } else
        threeDLs.add(TweenSequenceItem(
          tween: Tween<math.Vector3>(begin: i.value, end: i.endValue),
          weight: i.weight,
        ));
    }
  }

  void addSizeAnimations(List<SizeAnimation> ls) {
    for (var i in ls) {
      if (i.endValue == null) {
        sizeLs.add(TweenSequenceItem(
          tween: ConstantTween<Size>(i.value),
          weight: i.weight,
        ));
      } else
        sizeLs.add(TweenSequenceItem(
          tween: Tween<Size>(
            begin: i.value,
            end: i.endValue,
          ),
          weight: i.weight,
        ));
    }
  }

  void addSlideAnimations(List<SlideAnimation> ls) {
    for (var i in ls) {
      if (i.endValue == null) {
        slideLs.add(TweenSequenceItem(
          tween: ConstantTween<Offset>(i.value),
          weight: i.weight,
        ));
      } else
        slideLs.add(TweenSequenceItem(
          tween: Tween<Offset>(begin: i.value, end: i.endValue),
          weight: i.weight,
        ));
    }
  }

  void addColorAnimations(List<ColorAnimation> ls) {
    for (var i in ls) {
      if (i.endValue == null) {
        colorLs.add(TweenSequenceItem(
          tween: ConstantTween<Color>(i.value),
          weight: i.weight,
        ));
      } else
        colorLs.add(TweenSequenceItem(
          weight: i.weight,
          tween: ColorTween(begin: i.value, end: i.endValue),
        ));
    }
  }

  // List<TweenSequenceItem<double>> get opacityLs => _opacityLs;

  // List<TweenSequenceItem<Decoration>> get decorationLs => _decorationLs;

  // List<TweenSequenceItem<RelativeRect>> get rectLs => _rectLs;

  // List<TweenSequenceItem<math.Vector3>> get threeDLs => _threeDLs;

  // List<TweenSequenceItem<Size>> get sizeLs => _sizeLs;

  // List<TweenSequenceItem<Offset>> get slideLs => _slideLs;

  // List<TweenSequenceItem<Color>> get colorLs => _colorLs;
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
  const ThreeDAnimation(this.weight, this.value, this.endValue);
  final double weight;
  final math.Vector3 value, endValue;
}

class SizeAnimation {
  const SizeAnimation(this.weight, this.value, this.endValue);
  final double weight;
  final Size value, endValue;
}

class SlideAnimation {
  const SlideAnimation(this.weight, this.value, this.endValue);
  final double weight;
  final Offset value, endValue;
}

class ColorAnimation {
  const ColorAnimation(this.weight, this.value, this.endValue);
  final double weight;
  final Color value, endValue;
}

class RContainer extends StatelessWidget {
  const RContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.green,
    );
  }
}
