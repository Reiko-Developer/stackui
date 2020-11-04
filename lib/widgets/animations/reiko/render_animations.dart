import 'package:flutter/material.dart';
import 'package:stackui/widgets/animations/reiko/handlers/handle_3dX_animations.dart';
import 'package:stackui/widgets/animations/reiko/handlers/handle_color_animations.dart';
import 'package:stackui/widgets/animations/reiko/handlers/handle_opacity_animations.dart';
import 'package:stackui/widgets/animations/reiko/handlers/handle_size_animations.dart';
import 'package:stackui/widgets/animations/reiko/handlers/handle_translate_animations.dart';

//Recebe o controlador e a lista de animações
class ReikoRenderAnimations extends StatefulWidget {
  ReikoRenderAnimations({
    Key key,
    @required this.child,
    //Recebe uma lista de animações
    @required this.opacity,
    @required this.translate,
    @required this.size,
    @required this.color,
    @required this.threeD,
    this.controller,
  }) : super(key: key);

  final AnimationController controller;
  final HandleOpacityAnimations opacity;
  final HandleTranslateAnimations translate;
  final HandleSizeAnimations size;
  final HandleColorAnimations color;
  final Handle3DXAnimations threeD;
  //Refatorar
  final Widget child;

  @override
  _ReikoRenderAnimationsState createState() => _ReikoRenderAnimationsState();
}

class _ReikoRenderAnimationsState extends State<ReikoRenderAnimations> {
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
    if (widget.controller.isDismissed) {
      widget.controller.forward();
    } else if (widget.controller.isCompleted) widget.controller.reverse();
  }

  Widget widgetsToAnimate(Container child) {
    final value = widget.controller.value;
    Widget temporaryChild = GestureDetector(onTap: runAnimation, child: child);

    //OpacityAnimations
    if (widget.opacity.animations.isNotEmpty)
      temporaryChild = Opacity(
          opacity: widget.opacity.currentAnimationValue(value),
          child: temporaryChild);

    //SizeAnimationValues
    if (widget.size.animations.isNotEmpty)
      temporaryChild = Container(
        width: widget.size.currentAnimationValue(value).width,
        height: widget.size.currentAnimationValue(value).width,
        child: temporaryChild,
      );

    //Color animations
    if (widget.color.animations.isNotEmpty) {
      temporaryChild = Container(
        color: widget.color.currentAnimationValue(value),
        child: temporaryChild,
      );
    }

    if (widget.threeD.animations.isNotEmpty) {
      final currentValue = widget.threeD.currentAnimationValue(value);
      temporaryChild = Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.0011)
          ..rotateX(currentValue)
          ..rotateY(currentValue)
          ..rotateZ(currentValue),
        origin: Offset.zero,
        child: temporaryChild,
      );
    }

    //Positioned widget deve ser adicionado por último
    //TranslateAnimations
    if (widget.translate.animations.isNotEmpty) {
      final pos =
          widget.translate.currentAnimationValue(widget.controller.value);
      temporaryChild = Positioned(
        left: pos.dx,
        top: pos.dy,
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
