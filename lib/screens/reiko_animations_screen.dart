import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stackui/widgets/animations/reiko/animations_list.dart';
import 'package:stackui/widgets/animations/reiko/render_animations.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class ReikoAnimationsScreen extends StatelessWidget {
  const ReikoAnimationsScreen();
  static final routeName = '/reiko-animations-screen';

  @override
  Widget build(BuildContext context) {
    print('ReikoAnimationsScreen');
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
  final ra = RenderAnimations(
    duration: const Duration(seconds: 3),
    transformAlignment: Alignment.topLeft,
    alignment: Alignment.topLeft,
    runAnimation: () {},
    child: Container(
      height: 50,
      width: 50,
      child: const Text('Reiko-Dev'),
    ),
    animationsList: AnimationsList(depthPerspective: 0.001)
      ..addOpacityAnimations(
        [const OpacityAnimation(weight: 1, value: 0, endValue: 1)],
      )
      // ..addPositionAnimations(
      //   [
      //     const RelativeRectAnimation(
      //       weight: 1,
      //       value: const RelativeRect.fromLTRB(0, 0, 250, 350),
      //       endValue: const RelativeRect.fromLTRB(200, 200, 0, 0),
      //     )
      //   ],
      // )
      ..addScaleAnimations(
        [
          const ScaleAnimation(
              weight: 1, value: Offset(1, 1), endValue: Offset(2, 2.5)),
        ],
      )
      ..addSlideAnimations(
        [
          const SlideAnimation(
              weight: 1, value: Offset.zero, endValue: Offset(5, 5)),
          const SlideAnimation(
              weight: 1, value: Offset(5, 5), endValue: Offset(5, 10)),
          const SlideAnimation(
              weight: 1, value: Offset(5, 10), endValue: Offset(0, 10)),
        ],
      )
      ..addDecorationAnimations(
        [
          DecorationAnimation(
            weight: 1,
            value: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(60.0),
              shape: BoxShape.rectangle,
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: const Color(0x66666666),
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
        ],
      ),
  );

  @override
  Widget build(BuildContext context) {
    print('MyWidget');
    return ra;
  }
}

class RContainer extends StatelessWidget {
  const RContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Background builder');
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.green,
    );
  }
}
