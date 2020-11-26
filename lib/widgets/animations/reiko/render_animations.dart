import 'package:flutter/material.dart';
import 'package:stackui/widgets/animations/reiko/animations_list.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class RenderAnimations extends StatefulWidget {
  /// A const constructor that requires a [Duration], a [Function] to control the animation, an [AnimationsList] to be executed and the child [Widget].
  ///
  /// Can receive the alignment of the transformation
  const RenderAnimations({
    Key key,
    @required this.duration,
    @required this.configAnimation(AnimationController controller),
    this.transformAlignment = Alignment.center,

    //
    @required this.animationsList,
    @required this.child,
  })  : assert(duration != null),
        assert(child != null);

  /// A [Duration] for the animation controller
  final Duration duration;

  ///This is the alignment for the Transformation animation.
  final Alignment transformAlignment;

  ///The function that must controls the animation, at least, starting it.
  ///
  ///The following example put the animation in a loop, add the two listeners and print some data.
  ///
  ///```dart
  /// configAnimation(AnimationController controller) {
  ///   controller.repeat();
  ///   controller.addListener( () => print('${controller.value}'));
  ///   controller.addStatusListener( (status) => print('$status'));
  ///
  /// }
  /// ```
  /// As you can see, you can control all the animation.
  final Function configAnimation;

  ///The list of animations to executed on the passed child.
  ///
  ///The following example create a simple list of animations:
  ///
  ///```dart
  /// final animationLs = AnimationsList(
  ///  matrix4DepthPerspective: 0.001,
  ///   opacityList: const [
  ///     OpacityAnimation(weight: 1, value: 1, endValue: 0),
  ///     OpacityAnimation(weight: 1, value: 0, endValue: 1),
  ///   ],
  ///   decorationList: const [
  ///     DecorationAnimation(
  ///       weight: 1,
  ///       value: BoxDecoration(
  ///         color: Colors.red,
  ///         borderRadius: BorderRadius.all(Radius.circular(8)),
  ///       ),
  ///       endValue:
  ///           BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.zero),
  ///     ),
  ///     DecorationAnimation(
  ///       weight: 1,
  ///       value: BoxDecoration(
  ///         color: Colors.blue,
  ///       ),
  ///       endValue: BoxDecoration(
  ///         color: Colors.purple,
  ///         borderRadius: BorderRadius.all(Radius.circular(8)),
  ///       ),
  ///     )
  ///   ],
  ///   relativeRectList: const [
  ///     RelativeRectAnimation(
  ///       weight: 1,
  ///       value: RelativeRect.fromLTRB(0, 0, 250, 350),
  ///       endValue: RelativeRect.fromLTRB(250, 400, 0, 0),
  ///     ),
  ///   ],
  ///   threeDList: [
  ///     ThreeDAnimation(
  ///       weight: 1,
  ///       value: math.Vector3(0, 0, 0),
  ///       endValue: math.Vector3(0, 0, 3.14 / 3),
  ///     ),
  ///   ],
  /// );
  ///```
  final AnimationsList animationsList;

  ///The widget below this widget in the tree.
  ///
  ///This widget can only have one child.
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

  int buildNum = 0;

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

    widget.configAnimation(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Render Animations build method: ${(buildNum++)}');

    return AnimatedBuilder(
      key: Key('ab-3d'),
      animation: controller,
      child: opacity != null
          ? FadeTransition(
              key: Key('fa'),
              opacity: opacity,
              child: decoration != null
                  ? DecoratedBoxTransition(
                      key: Key('da'),
                      decoration: decoration,
                      child: widget.child,
                    )
                  : widget.child,
            )
          : decoration != null
              ? DecoratedBoxTransition(
                  key: Key('da'),
                  decoration: decoration,
                  child: widget.child,
                )
              : widget.child,
      builder: (_, child) {
        return rect != null
            ? Positioned.fromRelativeRect(
                key: Key('pa'),
                rect: rect.value,
                child: Transform(
                  key: Key('ab-ta'),
                  alignment: widget.transformAlignment ?? Alignment.center,

                  ///The order of the below cascade methods matter.
                  transform: Matrix4.identity()
                    ..setEntry(
                        3, 2, widget.animationsList.matrix4DepthPerspective)
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
            : Transform(
                key: Key('ab-ta'),
                alignment: widget.transformAlignment ?? Alignment.center,

                ///The order of the below cascade methods matter.
                transform: Matrix4.identity()
                  ..setEntry(
                      3, 2, widget.animationsList.matrix4DepthPerspective)
                  ..rotateX(threeD.value.x)
                  ..rotateY(threeD.value.y)
                  ..rotateZ(threeD.value.z)
                  ..translate(
                    slide == null ? 0.0 : slide.value.dx,
                    slide == null ? 0.0 : slide.value.dy,
                  )
                  ..scale(
                    scale == null ? 1.0 : scale.value.dx,
                    scale == null ? 1.0 : scale.value.dy,
                  ),
                child: child,
              );
      },
    );
  }
}
