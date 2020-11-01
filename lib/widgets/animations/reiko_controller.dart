import 'package:flutter/material.dart';

import './reiko_opacity_animation.dart';

class ReikoController extends StatefulWidget {
  ReikoController(this.duration, this.widgetToAnimate);
  final Duration duration;
  final Widget widgetToAnimate;

  @override
  _ReikoControllerState createState() => _ReikoControllerState();
}

class _ReikoControllerState extends State<ReikoController>
    with TickerProviderStateMixin {
  AnimationController _controller;
  //Controla o andamento da animação.
  var _isAboveHalfAnimation = false;
  int aux = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: widget.duration, vsync: this)
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reiko Animations!'),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _playAnimation,
        child: Center(
          child: ReikoOpacityAnimation(
            controller: _controller.view,
            child: widget.widgetToAnimate,
          ),
        ),
      ),
    );
  }
}
