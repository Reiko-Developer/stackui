import 'package:stackui/widgets/animations/reiko/animations/foo_animation.dart';
import 'package:stackui/widgets/animations/reiko/handlers/handle_foo_animations.dart';
import 'package:stackui/widgets/animations/reiko/animations/opacity_animation.dart';

//Classe que gerencia animações de opacidade.
class HandleOpacityAnimations extends HandleFooAnimations {
  @override
  List<FooAnimation> animations = List<OpacityAnimation>();

  @override
  add({
    beginValue,
    finalValue,
    startAnimation,
    endAnimation,
    curve,
  }) {
    //
    var newAnimation = OpacityAnimation(
      beginValue: beginValue,
      finalValue: finalValue,
      startAnimation: startAnimation,
      endAnimation: endAnimation,
      curve: curve,
    );
    newAnimation.validateValues();
    animations.add(newAnimation);
    validateIntervalBetweenAnimations();
  }

  //Retorna o valor da animação em execução do momento.
  //O valor inicial é o da primeira animação, embora nenhuma animação esteja em execução.
  //O valor dado no intervalo entre animações é o da seguinte animação a ser executada.
  @override
  double currentAnimationValue(double controllerValue) {
    for (var a in animations) {
      if (controllerValue <= a.endAnimation) return a.animation.value;
    }
    return animations[animations.length - 1].animation.value;
  }
}
