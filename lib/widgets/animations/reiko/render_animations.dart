import 'package:flutter/material.dart';
import 'package:stackui/widgets/animations/reiko/box_decoration_animations.dart';
import 'package:stackui/widgets/animations/reiko/color_animations.dart';
import 'package:stackui/widgets/animations/reiko/slide_animations.dart';
import 'package:stackui/widgets/animations/reiko/threed_animations.dart';
import 'package:stackui/widgets/animations/reiko/positioned_animations.dart';
import 'package:stackui/widgets/animations/reiko/opacity_animations.dart';
import 'package:stackui/widgets/animations/reiko/size_animations.dart';

//Recebe o controlador e a lista de animações
class RenderAnimations extends StatefulWidget {
  RenderAnimations({
    Key key,
    @required this.child,
    @required this.controller,

    //Recebe uma lista de animações
    this.opacity,
    this.size,
    this.color,
    this.threeD,
    this.position,
    this.slide,
    this.decoration,
  }) : super(key: key);

  final AnimationController controller;
  final OpacityAnimations opacity;
  final SizeAnimations size;
  final ColorAnimations color;
  final ThreeDAnimations threeD;
  final PositionedAnimations position;
  final SlideAnimations slide;
  final BoxDecorationAnimations decoration;

  //Refatorar
  final Widget child;

  @override
  _RenderAnimationsState createState() => _RenderAnimationsState();
}

class _RenderAnimationsState extends State<RenderAnimations> {
  Widget temporaryChild;

  @override
  void initState() {
    super.initState();
    widget.controller.forward();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  //Dispara quando o widget é clicado.
  //Controla a animação indo para frente quanto não iniciada e indo para trás
  //quando a animação for completada.
  void runAnimation() {
    print('clicked');
    if (widget.controller.isDismissed) {
      widget.controller.forward();
    } else if (widget.controller.isCompleted) widget.controller.reverse();
  }

  ///
  ///TODO: Create an exception for when having Positioned and size/translate animations in the same animation.
  ///
  ///TODO: Think on improvements, try to join all properties, except Positioned, in just one Container.
  ///Search for performance issues
  ///
  Widget widgetsToAnimate(Container child) {
    temporaryChild = GestureDetector(onTap: runAnimation, child: child);
    //Positioned widget deve ser adicionado por último

    if (widget.slide != null && widget.position == null) {
      temporaryChild = SlideTransition(
        position: widget.slide.animation,
        child: temporaryChild,
      );
    }

    if (widget.size != null && widget.position == null)
      temporaryChild = Container(
        width: widget.size.animation.value.width,
        height: widget.size.animation.value.height,
        child: temporaryChild,
      );

    //Color animations
    if (widget.color != null) {
      temporaryChild = Container(
        color: widget.color.animation.value,
        child: temporaryChild,
      );
    }

    if (widget.threeD != null) {
      temporaryChild = Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.0011)
          ..rotateX(widget.threeD.animation.value.x)
          ..rotateY(widget.threeD.animation.value.y)
          ..rotateZ(widget.threeD.animation.value.z),
        origin: Offset.zero,
        child: temporaryChild,
      );
    }

    if (widget.opacity != null) {
      temporaryChild = FadeTransition(
        opacity: widget.opacity.animation,
        child: temporaryChild,
      );
    }

    if (widget.decoration != null) {
      print('decoration');
      temporaryChild = DecoratedBoxTransition(
        decoration: widget.decoration.animation,
        position: DecorationPosition.background,
        child: temporaryChild,
      );
    }

    if (widget.position != null) {
      temporaryChild = PositionedTransition(
        rect: widget.position.animation,
        child: temporaryChild,
      );
    }

    return temporaryChild;
  }

  //Poderia utilizar um builderAnimation específico para cada ocasião?
  //De forma a diminuir a quantidade de interrupções na construção das animações.
  Widget _buildAnimation(BuildContext context, Widget child) {
    print('building animation...');
    return widgetsToAnimate(child);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: widget.controller,
      child: widget.child,
    );
  }
}
