import 'package:flutter/material.dart';
import 'package:stackui/widgets/animations/reiko/decoration_animations.dart';
import 'package:stackui/widgets/animations/reiko/color_animations.dart';
import 'package:stackui/widgets/animations/reiko/slide_animations.dart';
import 'package:stackui/widgets/animations/reiko/threed_animations.dart';
import 'package:stackui/widgets/animations/reiko/positioned_animations.dart';
import 'package:stackui/widgets/animations/reiko/opacity_animations.dart';
import 'package:stackui/widgets/animations/reiko/size_animations.dart';
import 'package:stackui/screens/reiko_animations_screen.dart';

class RenderAnimations extends StatefulWidget {
  const RenderAnimations({
    Key key,
    @required this.duration,

    //Recebe uma lista de animações
    this.alignment,
    this.runAnimation,
    @required this.animationsList,
    @required this.child,
  });

  final Duration duration;
  final Alignment alignment;
  final Function runAnimation;
  final AnimationsList animationsList;

  final Widget child;

  //Listas de animações

  @override
  createState() => _RenderAnimations();
}

class _RenderAnimations extends State<RenderAnimations>
    with SingleTickerProviderStateMixin {
  //TODO: Jogar na classe pai para poder dar acesso ao objeto controller pelo user.
  AnimationController _controller;
  //
  OpacityAnimations opacity;
  SizeAnimations size;
  ColorAnimations color;
  ThreeDAnimations threeD;
  PositionedAnimations rect;
  SlideAnimations slide;
  DecorationAnimations decoration;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 6),
      vsync: this,
    )..addStatusListener((status) => print(status));

    opacity = OpacityAnimations(_controller, widget.animationsList.opacityLs);

    if (widget.animationsList.sizeLs.isNotEmpty)
      size = SizeAnimations(_controller, widget.animationsList.sizeLs);

    //Somente possível dentro de um Stack.
    if (widget.animationsList.rectLs.isNotEmpty)
      rect = PositionedAnimations(_controller, widget.animationsList.rectLs);

    if (widget.animationsList.colorLs.isNotEmpty)
      color = ColorAnimations(_controller, widget.animationsList.colorLs);

    if (widget.animationsList.threeDLs.isNotEmpty)
      threeD = ThreeDAnimations(_controller, widget.animationsList.threeDLs);

    if (widget.animationsList.slideLs.isNotEmpty)
      slide = SlideAnimations(_controller, widget.animationsList.slideLs);

    if (widget.animationsList.decorationLs.isNotEmpty)
      decoration =
          DecorationAnimations(_controller, widget.animationsList.decorationLs);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (_, child) {
        return rect != null
            ? PositionedTransition(
                rect: rect.animation,
                child: Transform(
                  transform: Matrix4.identity()
                    ..rotateX(threeD == null ? 0 : threeD.animation.value.x)
                    ..rotateY(threeD == null ? 0 : threeD.animation.value.y)
                    ..rotateZ(threeD == null ? 0 : threeD.animation.value.z),
                  child: GestureDetector(
                    onTap: widget.runAnimation,
                    child: FadeTransition(
                      opacity: opacity == null ? 1 : opacity.animation,
                      child: Container(
                        alignment: widget.alignment,
                        decoration: decoration.animation.value,
                        child: child,
                      ),
                    ),
                  ),
                ),
              )
            : Transform(
                transform: Matrix4.identity()
                  ..rotateX(threeD == null ? 0 : threeD.animation.value.x)
                  ..rotateY(threeD == null ? 0 : threeD.animation.value.y)
                  ..rotateZ(threeD == null ? 0 : threeD.animation.value.z),
                child: FadeTransition(
                  opacity: opacity.animation,
                  child: Container(
                    alignment: widget.alignment,
                    decoration: decoration.animation.value,
                    child: child,
                  ),
                ),
              );
      },
    );
  }
}
