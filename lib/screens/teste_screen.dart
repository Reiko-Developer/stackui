import 'package:flutter/material.dart';

class TesteScreen extends StatefulWidget {
  static final routeName = '/teste';

  @override
  _TesteScreenState createState() => _TesteScreenState();
}

class _TesteScreenState extends State<TesteScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimationTest(
              controller,
              Container(),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimationTest extends StatefulWidget {
  final AnimationController controller;
  final Widget child;

  AnimationTest(this.controller, this.child);

  @override
  _AnimationTestState createState() => _AnimationTestState();
}

class _AnimationTestState extends State<AnimationTest> {
  Animation<double> animation;

  initState() {
    super.initState();

    animation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 100.0)
              .chain(CurveTween(curve: Curves.linear)),
          weight: 30.0,
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(100.0),
          weight: 10.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 100.0, end: 200.0)
              .chain(CurveTween(curve: Curves.linear)),
          weight: 30.0,
        ),
      ],
    ).animate(widget.controller);

    animation.addListener(() => print('animation value: ${animation.value}'));
    widget.controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.dispose();
  }

  //Poderia utilizar um builderAnimation específico para cada ocasião?
  //De forma a diminuir a quantidade de interrupções na construção das animações.
  Widget _buildAnimation(BuildContext context, Widget child) {
    print('building animation...');
    return Container(
      width: animation.value,
      height: animation.value,
      color: Colors.blue,
      child: child,
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
