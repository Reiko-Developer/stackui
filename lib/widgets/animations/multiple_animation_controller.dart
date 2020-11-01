import 'dart:async';

import 'package:flutter/material.dart';

class MultipleAnimation extends StatelessWidget {
  MultipleAnimation({Key key, @required this.child, this.controller})
      : firstOpacity = Tween<double>(
          begin: 0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.5,
              curve: Curves.linear,
            ),
          ),
        ),
        secondOpacity = Tween<double>(
          begin: 1,
          end: 0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.5,
              1,
              curve: Curves.linear,
            ),
          ),
        ),
        firstMove = Tween<double>(begin: 0, end: 100).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0,
              0.5,
              curve: Curves.linear,
            ),
          ),
        ),
        secondMove = Tween<double>(begin: 0, end: 100).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.5,
              1,
              curve: Curves.linear,
            ),
          ),
        ),
        firstSize = Tween<Size>(begin: Size(0, 0), end: Size(100, 100)).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0,
              0.5,
              curve: Curves.linear,
            ),
          ),
        ),
        secondSize =
            Tween<Size>(begin: Size(0, 0), end: Size(100, 100)).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.5,
              1,
              curve: Curves.linear,
            ),
          ),
        ),
        super(key: key);

  final AnimationController controller;
  final Animation<double> firstOpacity;
  final Animation<double> secondOpacity;
  final Animation<double> firstMove;
  final Animation<double> secondMove;
  final Animation<Size> firstSize;
  final Animation<Size> secondSize;

  final Widget child;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Container(
      child: Opacity(
        // Uses the first value for the first part (half)
        // of the animation.
        opacity:
            firstOpacity.value < 1 ? firstOpacity.value : secondOpacity.value,
        child: Stack(
          children: [
            Positioned(
              bottom: firstMove.value + secondMove.value,
              left: firstMove.value + secondMove.value,
              child: Container(
                width: firstSize.value.width + secondSize.value.width,
                height: firstSize.value.height + secondSize.value.height,
                color: Colors.red,
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
      child: child,
    );
  }
}

class MultipleAnimationController extends StatefulWidget {
  MultipleAnimationController(this.animationDuration);
  final Duration animationDuration;

  @override
  _MultipleAnimationControllerState createState() =>
      _MultipleAnimationControllerState();
}

class _MultipleAnimationControllerState
    extends State<MultipleAnimationController> with TickerProviderStateMixin {
  AnimationController _controller;
  //Controla o andamento da animação.
  var _isAboveHalfAnimation = false;
  int aux = 0;
  Widget container = Container(
    color: Colors.red,
    child: Text('TESTE'),
  );

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: widget.animationDuration, vsync: this)
          ..addListener(() {
            if (_isAboveHalfAnimation) return;
            if (_controller.value >= 0.5) {
              _controller.stop();
              _isAboveHalfAnimation = true;
            }
          })
          ..addStatusListener(
            (status) => print(status),
          );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _playAnimation() async {
    try {
      if (_controller.isCompleted || _controller.isDismissed) {
        _isAboveHalfAnimation = false;
        await _controller.repeat().orCancel;
        return;
      }
      if (_isAboveHalfAnimation) {
        await _controller.forward().orCancel;
        return;
      }
    } on TickerCanceled {}
  }

  void changeContainer() {
    aux++;
    setState(() {
      container = Container(color: Colors.blue, child: Text('$aux'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reiko Animations!'),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _playAnimation,
        onDoubleTap: changeContainer,
        child: Center(
          child: MultipleAnimation(
            controller: _controller.view,
            child: container,
          ),
        ),
      ),
    );
  }
}
