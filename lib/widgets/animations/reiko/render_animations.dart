import 'package:flutter/material.dart';
import 'package:stackui/widgets/animations/reiko/animations_list.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class RenderAnimations extends StatefulWidget {
  ///A constructor that needs a [Duration] for the controller
  RenderAnimations({
    Key key,
    @required this.duration,

    ///This is the alignment for the whole animation
    this.alignment = Alignment.center,

    ///This is the alignment for the Transform widget.
    this.transformAlignment = Alignment.center,

    //
    @required this.runAnimation,
    @required this.animationsList,
    @required this.child,
  }) : assert(duration != null);

  final Duration duration;
  final Alignment alignment;
  final Alignment transformAlignment;
  final Function runAnimation;
  final AnimationsList animationsList;
  final Widget child;

  @override
  _RenderAnimationsState createState() => _RenderAnimationsState();
}

class _RenderAnimationsState extends State<RenderAnimations>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<math.Vector3> threeD;
  Animation<double> opacity;
  Animation<Decoration> decoration;
  Animation<Offset> scale;
  Animation<RelativeRect> rect;

  int buidlNum = 0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    threeD = TweenSequence<math.Vector3>(
      [
        TweenSequenceItem<math.Vector3>(
          tween: Tween<math.Vector3>(
            begin: math.Vector3(0, 0, 0),
            end: math.Vector3(0, 3.14 / 3, 3.14 / 2),
          ).chain(
            CurveTween(curve: Curves.elasticIn),
          ),
          weight: 1,
        ),
        TweenSequenceItem<math.Vector3>(
          tween: Tween<math.Vector3>(
            begin: math.Vector3(0, 3.14 / 3, 3.14 / 2),
            end: math.Vector3(0, 0, 0),
          ).chain(
            CurveTween(curve: Curves.linear),
          ),
          weight: 1,
        )
      ],
    ).animate(controller);

    opacity = TweenSequence<double>([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: 1).chain(
            CurveTween(curve: Curves.linear),
          ),
          weight: 1)
    ]).animate(controller);

    decoration = TweenSequence<Decoration>([
      TweenSequenceItem(
        tween: DecorationTween(
          begin: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          end: BoxDecoration(
            color: Colors.blue,
          ),
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: DecorationTween(
          begin: BoxDecoration(
            color: Colors.blue,
          ),
          end: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        weight: 1,
      ),
    ]).animate(controller);

    scale = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: Offset(1, 1),
          end: Offset(1.5, 2),
        ),
        weight: 1,
      ),
    ]).animate(controller);

    rect = TweenSequence<RelativeRect>([
      TweenSequenceItem(
        tween: RelativeRectTween(
          begin: RelativeRect.fromLTRB(0, 0, 250, 450),
          end: RelativeRect.fromLTRB(250, 450, 0, 0),
        ),
        weight: 1,
      ),
    ]).animate(controller);

    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    print('Render Animations build method: ${(buidlNum++)}');
    int animatedBuilderNum = 0;
    return AnimatedBuilder(
        key: Key('ab-3d'),
        child: DecoratedBoxTransition(
          key: Key('da'),
          decoration: decoration,
          child: FadeTransition(
            key: Key('fa'),
            opacity: opacity,
            child: GestureDetector(
              key: Key('gd'),
              onTap: () {
                if (controller.status == AnimationStatus.completed) {
                  controller.reverse();
                } else if (controller.status == AnimationStatus.dismissed) {
                  controller.forward();
                }
              },
              child: widget.child,
            ),
          ),
        ),
        animation: controller,
        builder: (_, child) {
          print('Render AnimatedBuilder: ${(animatedBuilderNum++)}');
          return Positioned.fromRelativeRect(
            key: Key('pa'),
            rect: rect.value,
            child: Transform(
              key: Key('ab-ta'),
              alignment: widget.alignment,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(threeD.value.x)
                ..rotateY(threeD.value.y)
                ..rotateZ(threeD.value.z)
                ..scale(scale.value.dx, scale.value.dy),
              child: child,
            ),
          );
        });
  }
}

class RTransformXYZ extends StatefulWidget {
  const RTransformXYZ({
    Key key,
    @required this.duration,
    @required this.threeDLs,
    this.depthPerspective = 0.001,
    this.alignment = Alignment.center,
    @required this.child,
  }) : super(key: key);

  final List<ThreeDAnimation> threeDLs;
  final Duration duration;
  final double depthPerspective;
  final Alignment alignment;
  final Widget child;

  @override
  createState() => _RTransformXYZ();
}

class _RTransformXYZ extends State<RTransformXYZ>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  TweenSequence<math.Vector3> threeD;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    init();

    controller.repeat(reverse: true);
  }

  void init() {
    final List<TweenSequenceItem<math.Vector3>> threeDSequence = [];

    if (widget.threeDLs == null || widget.threeDLs.isEmpty) return;

    for (var i in widget.threeDLs) {
      if (i.endValue != null) {
        threeDSequence.add(TweenSequenceItem<math.Vector3>(
            tween: Tween<math.Vector3>(
                begin: math.Vector3(i.value.x, i.value.y, i.value.z),
                end: math.Vector3(i.endValue.x, i.endValue.y, i.endValue.z)),
            weight: i.weight));
      } else
        threeDSequence.add(TweenSequenceItem<math.Vector3>(
          tween: ConstantTween<math.Vector3>(
              math.Vector3(i.value.x, i.value.y, i.value.z)),
          weight: i.weight,
        ));
    }
    threeD = TweenSequence(threeDSequence);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int aux = 0;
    return AnimatedBuilder(
        key: Key('ab-3d'),
        child: widget.child,
        animation: controller,
        builder: (_, child) {
          print('RTransformXYZ builder ${(aux++)}');
          return Transform(
            key: Key('tb'),
            alignment: widget.alignment,
            transform: Matrix4.identity()
              ..setEntry(3, 2, widget.depthPerspective)
              ..rotateX(threeD.evaluate(controller).x)
              ..rotateY(threeD.evaluate(controller).y)
              ..rotateZ(threeD.evaluate(controller).z),
            child: child,
          );
        });
  }
}

class RColor extends StatefulWidget {
  const RColor({
    key,
    @required this.duration,
    @required this.colors,
    @required this.child,
  }) : super(key: key);

  final List<ColorAnimation> colors;
  final Duration duration;
  final Widget child;

  @override
  _RColorState createState() => _RColorState();
}

class _RColorState extends State<RColor> with SingleTickerProviderStateMixin {
  AnimationController controller;
  TweenSequence<Color> color;
  final List<TweenSequenceItem<Color>> sequenceList = [];

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    controller.repeat(reverse: true);
    parseList();

    color = TweenSequence(sequenceList);
  }

  @override
  dispose() {
    super.dispose();
    controller.dispose();
  }

  void parseList() {
    if (widget.colors.isEmpty || widget.colors == null) return;

    for (var i in widget.colors) {
      if (i.endValue == null) {
        sequenceList.add(TweenSequenceItem(
            tween: ConstantTween<Color>(i.value), weight: i.weight));
      } else
        sequenceList.add(TweenSequenceItem(
          weight: i.weight,
          tween: ColorTween(begin: i.value, end: i.endValue),
        ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      key: Key('ab-color'),
      child: widget.child,
      animation: controller,
      builder: (_, child) {
        return DecoratedBox(
          key: Key('db'),
          decoration: BoxDecoration(color: color.evaluate(controller)),
          child: child,
        );
      },
    );
  }
}
