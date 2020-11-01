import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/material.dart';
import 'package:stackui/widgets/animations/flutter_animations/flutter_staggered_animation.dart';

class FlutterStaggerDemo extends StatefulWidget {
  @override
  _FlutterStaggerDemoState createState() => _FlutterStaggerDemoState();
}

class _FlutterStaggerDemoState extends State<FlutterStaggerDemo>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _playAnimation() async {
    try {
      await _controller.forward().orCancel;
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 10.0; // 1.0 is normal animation speed.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staggered Animation'),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _playAnimation();
        },
        child: Center(
          child: Container(
            width: 300.0,
            height: 300.0,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              border: Border.all(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            child: FlutterStaggeredAnimation(controller: _controller.view),
          ),
        ),
      ),
    );
  }
}
