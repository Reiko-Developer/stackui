import 'package:flutter/material.dart';
import 'package:stackui/widgets/animations/opacity_animations.dart';
import 'package:stackui/widgets/animations/size_animations.dart';
import 'package:stackui/widgets/animations/translate_animations.dart';

//Recebe o controlador e a lista de animações
class ReikoRenderAnimations extends StatefulWidget {
  ReikoRenderAnimations({
    Key key,
    @required this.child,
    //Recebe uma lista de animações
    @required this.opacityAnimations,
    @required this.translateAnimations,
    @required this.sizeAnimations,
    this.controller,
  }) : super(key: key);

  final AnimationController controller;
  final OpacityAnimations opacityAnimations;
  final TranslateAnimations translateAnimations;
  final SizeAnimations sizeAnimations;

  final Widget child;

  @override
  _ReikoRenderAnimationsState createState() => _ReikoRenderAnimationsState();
}

class _ReikoRenderAnimationsState extends State<ReikoRenderAnimations> {
  double lastValidOpacityValue = 0;
  Offset lastValidTranslateValue;
  Size lastValidSizeValue;

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

  double get _opacity {
    double tempoAtual = widget.controller.value;

    for (var i in widget.opacityAnimations.animations) {
      if (tempoAtual >= i.startAnimation && tempoAtual <= i.endAnimation)
        lastValidOpacityValue = i.animation.value;
    }
    return lastValidOpacityValue;
  }

  Offset get _position {
    double tempoAtual = widget.controller.value;
    for (var i in widget.translateAnimations.animations) {
      if (tempoAtual >= i.startAnimation && tempoAtual <= i.endAnimation)
        lastValidTranslateValue = i.animation.value;
    }
    return lastValidTranslateValue;
  }

  Size get _size {
    double tempoAtual = widget.controller.value;
    for (var i in widget.sizeAnimations.animations) {
      if (tempoAtual >= i.startAnimation && tempoAtual <= i.endAnimation)
        lastValidSizeValue = i.animation.value;
    }
    return lastValidSizeValue;
  }

  //Método específico do controlador
  void runAnimation() {
    if (widget.controller.isDismissed) {
      widget.controller.forward();
    } else if (widget.controller.isCompleted) widget.controller.reverse();
  }

  Widget widgetsToAnimate(Container child) {
    print('chamou widgetsToAnimate');
    Widget temp = GestureDetector(onTap: runAnimation, child: child);

    //OpacityAnimations
    if (widget.opacityAnimations.animations.isNotEmpty)
      temp = Opacity(opacity: _opacity, child: temp);

    //SizeAnimationValues
    if (widget.sizeAnimations.animations.isNotEmpty)
      temp = Container(
        width: _size.width,
        height: _size.height,
        child: temp,
      );

    //TranslateAnimations
    if (widget.translateAnimations.animations.isNotEmpty)
      temp = Positioned(
        left: _position.dx,
        top: _position.dy,
        child: temp,
      );

    return temp;
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
