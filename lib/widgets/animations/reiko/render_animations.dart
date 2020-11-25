import 'package:flutter/material.dart';
import 'package:stackui/widgets/animations/reiko/animations_list.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class RenderAnimations extends StatefulWidget {
  ///A constructor that needs a [Duration] for the controller
  const RenderAnimations({
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
  Animation<Offset> slide;
  Animation<Size> size;

  int buidlNum = 0;

  @override
  void initState() {
    super.initState();

    print(widget.animationsList.opacityList);

    controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    threeD = widget.animationsList.threeDTweenSequence?.animate(controller);

    ///if the sequence is null, the opacity will be null.
    opacity = widget.animationsList.opacityTweenSequence?.animate(controller);

    decoration =
        widget.animationsList.decorationTweenSequence?.animate(controller);

    scale = widget.animationsList.scaleTweenSequence?.animate(controller);

    rect = widget.animationsList.relativeRectTweenSequence?.animate(controller);

    slide = widget.animationsList.slidetTweenSequence?.animate(controller);

    controller.repeat();
  }

  void _controlAnimation() {
    if (controller.status == AnimationStatus.completed) {
      controller.reverse();
    } else if (controller.status == AnimationStatus.dismissed) {
      controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Render Animations build method: ${(buidlNum++)}');

    final bool transformHitTests = true;
    final textDirection = TextDirection.ltr;
    return AnimatedBuilder(
      key: Key('ab-3d'),
      child: GestureDetector(
        key: Key('gd'),
        onTap: _controlAnimation,
        child: opacity != null
            ? FadeTransition(
                opacity: opacity,
                child: decoration != null
                    ? DecoratedBoxTransition(
                        decoration: decoration,
                        child: widget.child,
                      )
                    : widget.child,
              )
            : decoration != null
                ? DecoratedBoxTransition(
                    decoration: decoration,
                    child: widget.child,
                  )
                : widget.child,
      ),
      animation: controller,
      builder: (_, child) {
        return rect != null
            ? Positioned.fromRelativeRect(
                key: Key('pa'),
                rect: rect.value,
                child: Transform(
                  key: Key('ab-ta'),
                  alignment: widget.transformAlignment ?? Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, widget.animationsList.depthPerspective)
                    ..rotateX(threeD.value.x)
                    ..rotateY(threeD.value.y)
                    ..rotateZ(threeD.value.z)
                    ..scale(
                      scale == null ? 1.0 : scale.value.dx,
                      scale == null ? 1.0 : scale.value.dy,
                    ),
                  child: child,
                ),
              )
            : FractionalTranslation(
                key: Key('slide a'),
                translation: textDirection == TextDirection.rtl
                    ? Offset(-slide.value.dx, slide.value.dy)
                    : slide.value,
                transformHitTests: transformHitTests,
                child: Transform(
                  key: Key('ab-ta'),
                  alignment: widget.transformAlignment ?? Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, widget.animationsList.depthPerspective)
                    ..rotateX(threeD.value.x)
                    ..rotateY(threeD.value.y)
                    ..rotateZ(threeD.value.z)
                    ..scale(
                      scale == null ? 1.0 : scale.value.dx,
                      scale == null ? 1.0 : scale.value.dy,
                    ),
                  child: child,
                ),
              );
      },
    );
  }
}
