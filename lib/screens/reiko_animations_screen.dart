import 'package:flutter/material.dart';
import 'package:stackui/widgets/animations/reiko/box_decoration_animations.dart';
import 'package:stackui/widgets/animations/reiko/slide_animations.dart';
import 'package:stackui/widgets/animations/reiko/threed_animations.dart';
import 'package:vector_math/vector_math.dart' as math;
import 'dart:math';
import 'package:stackui/widgets/animations/reiko/color_animations.dart';

import 'package:stackui/widgets/animations/reiko/positioned_animations.dart';
import 'package:stackui/widgets/animations/reiko/opacity_animations.dart';
import 'package:stackui/widgets/animations/reiko/size_animations.dart';
import 'package:stackui/widgets/animations/reiko/render_animations.dart';

class ReikoAnimationsScreen extends StatefulWidget {
  static final routeName = '/reiko-animations-screen';

  final List<TweenSequenceItem<Size>> sizeSequenceList = [
    TweenSequenceItem<Size>(
      tween: Tween<Size>(
        begin: Size.zero,
        end: Size(100, 100),
      ).chain(
        CurveTween(curve: Curves.linear),
      ),
      weight: 1,
    ),
    TweenSequenceItem<Size>(
      tween: ConstantTween<Size>(
        Size(200, 200),
      ),
      weight: 1,
    ),
  ];

  final List<TweenSequenceItem<Color>> colorSequenceList = [
    TweenSequenceItem<Color>(
      tween: ColorTween(
        begin: Colors.white,
        end: Colors.blue,
      ).chain(CurveTween(curve: Curves.linear)),
      weight: 1,
    ),
    TweenSequenceItem<Color>(
      tween: ConstantTween<Color>(Colors.blue),
      weight: 1,
    ),
    TweenSequenceItem<Color>(
      tween: ColorTween(
        begin: Colors.blue,
        end: Colors.red,
      ).chain(CurveTween(curve: Curves.linear)),
      weight: 2,
    ),
  ];

  final List<TweenSequenceItem<RelativeRect>> relativeRectSequenceList = [
    TweenSequenceItem<RelativeRect>(
      tween: RelativeRectTween(
        begin: RelativeRect.fromLTRB(30, 380, 200, 30),
        end: RelativeRect.fromLTRB(200, 10, 0, 350),
      ),
      weight: 3,
    ),
    TweenSequenceItem<RelativeRect>(
      tween: ConstantTween<RelativeRect>(
        RelativeRect.fromLTRB(200, 10, 0, 350),
      ),
      weight: 1,
    ),
    TweenSequenceItem<RelativeRect>(
      tween: RelativeRectTween(
        begin: RelativeRect.fromLTRB(200, 10, 0, 350),
        end: RelativeRect.fromLTRB(10, 430, 240, 10),
      ),
      weight: 3,
    ),
  ];

  final List<TweenSequenceItem<double>> opacitySequenceList = [
    TweenSequenceItem<double>(
      tween: Tween<double>(begin: 1, end: 0),
      weight: 1,
    ),
    TweenSequenceItem<double>(
      tween: Tween<double>(begin: 0, end: 1),
      weight: 1,
    ),
  ];

  final List<TweenSequenceItem<math.Vector3>> threeDSequenceList = [
    TweenSequenceItem<math.Vector3>(
      tween: Tween<math.Vector3>(
        begin: math.Vector3.zero(),
        end: math.Vector3(pi, 0, 0),
      ).chain(
        CurveTween(curve: Curves.linear),
      ),
      weight: 1,
    )
  ];

  final List<TweenSequenceItem<Offset>> slideSequenceList = [
    TweenSequenceItem<Offset>(
      tween: Tween<Offset>(begin: Offset.zero, end: Offset(2, 3.5)),
      weight: 1,
    ),
  ];

  final List<TweenSequenceItem<Decoration>> boxDecorationSequenceList = [
    TweenSequenceItem<Decoration>(
      weight: 1,
      tween: DecorationTween(
        begin: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          border: Border.all(style: BorderStyle.none),
          borderRadius: BorderRadius.circular(60.0),
          shape: BoxShape.rectangle,
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color(0x66666666),
              blurRadius: 10.0,
              spreadRadius: 3.0,
              offset: Offset(0, 6.0),
            )
          ],
        ),
        end: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          border: Border.all(
            style: BorderStyle.none,
          ),
          borderRadius: BorderRadius.zero,
          // No shadow.
        ),
      ),
    ),
  ];

  @override
  _ReikoAnimationsScreenState createState() => _ReikoAnimationsScreenState();
}

class _ReikoAnimationsScreenState extends State<ReikoAnimationsScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  OpacityAnimations opacityAnimations;
  SizeAnimations sizeAnimations;
  ColorAnimations colorAnimations;
  PositionedAnimations positionedAnimations;
  ThreeDAnimations threeDAnimations;
  SlideAnimations slideAnimations;
  BoxDecorationAnimations boxDecorationAnimations;

  @override
  void initState() {
    super.initState();
    //Creating the controller for the animations.
    _controller = new AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    )..addStatusListener((status) => print(status));

    opacityAnimations =
        OpacityAnimations(_controller, widget.opacitySequenceList);

    sizeAnimations = SizeAnimations(_controller, widget.sizeSequenceList);

    //Somente possível dentro de um Stack.
    positionedAnimations =
        PositionedAnimations(_controller, widget.relativeRectSequenceList);

    colorAnimations = ColorAnimations(_controller, widget.colorSequenceList);

    threeDAnimations = ThreeDAnimations(_controller, widget.threeDSequenceList);

    slideAnimations = SlideAnimations(_controller, widget.slideSequenceList);

    boxDecorationAnimations =
        BoxDecorationAnimations(_controller, widget.boxDecorationSequenceList);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.centerLeft,
        child: Stack(
          children: [
            RenderAnimations(
              controller: _controller.view,
              position: positionedAnimations,
              //size: sizeAnimations,
              //opacity: opacityAnimations,
              //threeD: threeDAnimations,
              // color: colorAnimations,
              //slide: slideAnimations,
              decoration: boxDecorationAnimations,
              child: Container(
                width: 100,
                height: 100,
                child: Icon(Icons.add_moderator),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
