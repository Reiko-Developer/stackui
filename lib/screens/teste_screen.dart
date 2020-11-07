import 'package:flutter/material.dart';

class TesteScreen extends StatefulWidget {
  static final routeName = '/teste';

  @override
  _TesteScreenState createState() => _TesteScreenState();
}

class _TesteScreenState extends State<TesteScreen>
    with SingleTickerProviderStateMixin {
  RelativeRectTween relativeRectTween = RelativeRectTween(
    begin: RelativeRect.fromLTRB(30, 380, 200, 30),
    end: RelativeRect.fromLTRB(200, 10, 0, 350),
  );

  AnimationController _controller;

  int state = 0;

  initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.yellow,
        child: Stack(
          children: <Widget>[
            //Modifica o tamanho e o lugar ancorado.
            PositionedTransition(
              rect: relativeRectTween.animate(_controller),
              child: Container(
                color: Colors.red,
              ),
            ),

            Container(
              child: RaisedButton(
                onPressed: () {
                  print('status: ${_controller.status}');
                  if (_controller.value == 0.5)
                    _controller.forward();
                  else if (_controller.status == AnimationStatus.completed ||
                      _controller.status == AnimationStatus.dismissed) {
                    _controller.reset();
                    _controller.animateTo(1 / 2);
                  }
                },
                child: Text(
                  "CLICK ME!",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
