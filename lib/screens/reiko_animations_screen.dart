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
      appBar: AppBar(
        title: Text('ReikoAnimationsScreen'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            const RContainer(
              color: Colors.white,
              width: double.infinity,
              height: double.infinity,
            ),
            const MyWidget(),
          ],
        ),
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
  AnimationController _controller;
  int tmp = 0;

  void configAnimationController(AnimationController controller) {
    _controller = controller;
    _controller.repeat();

    _controller.addStatusListener(
      (status) => print(status),
    );
  }

  void runAnimation() {
    print(_controller.value);
  }

  final animationsList = AnimationsList(
    matrix4DepthPerspective: 0.001,

    // slideList: const [
    //   SlideAnimation(weight: 1, value: Offset.zero, endValue: Offset(250, 550)),
    // ],
    //
    opacityList: const [
      OpacityAnimation(weight: 1, value: 1, endValue: 0),
      OpacityAnimation(weight: 1, value: 0, endValue: 1),
    ],
    //
    decorationList: const [
      DecorationAnimation(
        weight: 1,
        value: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        endValue:
            BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.zero),
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
    relativeRectList: const [
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
    ],
  );

  @override
  Widget build(BuildContext context) {
    print('MyWidget');
    return RenderAnimations(
      duration: const Duration(seconds: 3),
      transformAlignment: Alignment.center,
      configAnimation: configAnimationController,
      child: GestureDetector(
        onTap: runAnimation,
        child: const RContainer(
          width: 50,
          height: 50,
          child: const Text('Reiko-Dev'),
        ),
      ),
      animationsList: animationsList,
    );
  }
}

class RContainer extends StatelessWidget {
  const RContainer({
    Key key,
    this.width,
    this.height,
    this.color,
    this.child,
  }) : super(key: key);

  final double width, height;
  final Widget child;
  final Color color;
  @override
  Widget build(BuildContext context) {
    print('Background builder');
    return Container(
      width: width,
      height: height,
      color: color,
      child: child,
    );
  }
}
