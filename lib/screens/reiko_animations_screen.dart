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
    transformAlignment: Alignment.center,
    alignment: Alignment.topLeft,
    runAnimation: () {},
    child: Container(
      height: 50,
      width: 50,
      child: const Text('Reiko-Dev'),
    ),
    animationsList: AnimationsList(
      depthPerspective: 0.001,
      opacityList: const [
        OpacityAnimation(weight: 1, value: 1, endValue: 0),
        OpacityAnimation(weight: 1, value: 0, endValue: 1),
        OpacityAnimation(weight: 1, value: 1, endValue: 0),
      ],
      //
      decorationList: const [
        DecorationAnimation(
          weight: 1,
          value: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          endValue: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.zero),
        ),
        DecorationAnimation(
          weight: 1,
          value: BoxDecoration(
            color: Colors.blue,
          ),
          endValue: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        )
      ],
      //
      rectList: const [
        RelativeRectAnimation(
          weight: 1,
          value: RelativeRect.fromLTRB(0, 0, 250, 350),
          endValue: RelativeRect.fromLTRB(250, 400, 0, 0),
        ),
      ],
      //
      scaleList: const [
        ScaleAnimation(
          weight: 1,
          value: Offset.zero,
          endValue: Offset(1.5, 2),
        ),
      ],
      //
      threeDList: [
        ThreeDAnimation(
          weight: 1,
          value: math.Vector3(0, 0, 0),
          endValue: math.Vector3(0, 0, 3.14 / 3),
        ),
        ThreeDAnimation(
          weight: 1,
          value: math.Vector3(0, 0, 3.14 / 3),
          endValue: math.Vector3(3.14 / 3, 0, 0),
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
