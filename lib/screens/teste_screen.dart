import 'package:flutter/material.dart';

class TesteScreen extends StatefulWidget {
  static final routeName = '/test';
  TesteScreen({Key key}) : super(key: key);

  @override
  _TesteScreenState createState() => _TesteScreenState();
}

class _TesteScreenState extends State<TesteScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animationController.forward();
  }

  void toggle() => animationController.isDismissed
      ? animationController.forward()
      : animationController.reverse();

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _makeTransition() {
    toggle();
    setState(() {
      isVisible = !isVisible;
      print('clicked');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.grey,
        child: Stack(
          children: [
            Positioned(
              top: 350,
              left: 150,
              child: AnimatedOpacity(
                duration: Duration(seconds: 1),
                opacity: isVisible ? 0 : 1,
                child: AnimatedBuilder(
                  animation: animationController,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.yellow,
                  ),
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(50, animationController.value * -100),
                      child: child,
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: 450,
              width: 90,
              height: 50,
              child: RaisedButton(
                child: Text('Run'),
                onPressed: _makeTransition,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
