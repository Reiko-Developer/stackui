import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' show Vector3;
import 'dart:math';

class TesteScreen extends StatelessWidget {
  const TesteScreen();

  static final routeName = '/teste';
  static final appBar = AppBar(title: const Text('Improving performance'));

  @override
  Widget build(BuildContext context) {
    print('TesteScreen');
    return Scaffold(
      appBar: TesteScreen.appBar,
      body: Stack(
        children: [
          Container(
            color: Colors.green,
            width: double.infinity,
            height: double.infinity,
          ),
          const ChangeWidget(
            child: const Tmp('Reiko-Dev'),
          ),
        ],
      ),
    );
  }
}

class Tmp extends StatelessWidget {
  const Tmp(this.txt);

  final String txt;

  @override
  Widget build(BuildContext context) {
    print('Tmp builder');

    return Text(txt);
  }
}

class ChangeWidget extends StatefulWidget {
  const ChangeWidget({
    Key key,
    this.duration = const Duration(seconds: 2),
    this.alignment = Alignment.center,
    @required this.child,
  })  : assert(duration != null),
        super(key: key);

  final Widget child;

  final Duration duration;

  final Alignment alignment;

  @override
  _ChangeWidgetState createState() => _ChangeWidgetState();
}

class _ChangeWidgetState extends State<ChangeWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Vector3> _threeD;
  Animation<Color> color;
  Animation<Decoration> _decoration;
  Animation<RelativeRect> _rect;
  Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _threeD = Tween<Vector3>(
      begin: Vector3(0, 0, 0),
      end: Vector3(0, 0, pi / 4),
    ).animate(_controller);

    color = ColorTween(begin: Colors.transparent, end: Colors.blue)
        .animate(_controller);

    _decoration = DecorationTween(
      begin: BoxDecoration(
        color: Colors.red,
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
        color: Colors.blue,
        border: Border.all(
          style: BorderStyle.none,
        ),
        borderRadius: BorderRadius.zero,
        // No shadow.
      ),
    ).animate(_controller);

    _rect = RelativeRectTween(
            begin: RelativeRect.fromLTRB(10, 10, 250, 350),
            end: RelativeRect.fromLTRB(150, 150, 100, 150))
        .animate(_controller);

    _opacity = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.repeat();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Change Widget build');

    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (ctx, child) {
        return _rect != null
            ? PositionedTransition(
                rect: _rect,
                child: Transform(
                  transform: Matrix4.identity()
                    ..rotateX(_threeD.value.x)
                    ..rotateY(_threeD.value.y)
                    ..rotateZ(_threeD.value.z),
                  child: FadeTransition(
                    opacity: _opacity,
                    child: Container(
                      alignment: widget.alignment,
                      decoration: _decoration.value,
                      child: child,
                    ),
                  ),
                ),
              )
            : Transform(
                transform: Matrix4.identity()
                  ..rotateX(_threeD.value.x)
                  ..rotateY(_threeD.value.y)
                  ..rotateZ(_threeD.value.z),
                child: FadeTransition(
                  opacity: _opacity,
                  child: Container(
                    alignment: widget.alignment,
                    decoration: _decoration.value,
                    child: child,
                  ),
                ),
              );
      },
    );
  }
}
