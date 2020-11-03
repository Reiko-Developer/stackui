import 'package:flutter/material.dart';
import 'package:stackui/widgets/animations/opacity_animations.dart';
import 'package:stackui/widgets/animations/translate_animation.dart';

//Recebe o controlador e a lista de animações
class ReikoRenderAnimations extends StatefulWidget {
  ReikoRenderAnimations(
      {Key key,
      @required this.child,
      //Recebe uma lista de animações
      @required this.opacityAnimations,
      @required this.translateAnimations,
      this.controller})
      : super(key: key);

  final AnimationController controller;
  final List<OpacityAnimation> opacityAnimations;
  final List<TranslateAnimation> translateAnimations;

  final Widget child;

  @override
  _ReikoRenderAnimationsState createState() => _ReikoRenderAnimationsState();
}

class _ReikoRenderAnimationsState extends State<ReikoRenderAnimations> {
  double lastValidOpacityValue = 0;

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

    for (OpacityAnimation i in widget.opacityAnimations) {
      if (tempoAtual >= i.startAnimation && tempoAtual <= i.endAnimation)
        lastValidOpacityValue = i.animation.value;
    }
    return lastValidOpacityValue;
  }

  void runAnimation() {
    if (widget.controller.isDismissed) {
      widget.controller.forward();
    } else if (widget.controller.isCompleted) widget.controller.reverse();
  }

  Widget widgetsToAnimate(child) {
    return widget.opacityAnimations.isNotEmpty
        ? Opacity(
            opacity: _opacity,
            child: child,
          )
        : child;
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    print('building animation...');
    return GestureDetector(
      onTap: runAnimation,
      child: widgetsToAnimate(child),
    );
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
