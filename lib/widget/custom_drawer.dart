import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  static final routeName = '/custom-drawer';

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  AnimationController _animController;
  final double _maxSlide = 200;

  @override
  initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
  }

  void toggle() {
    _animController.isDismissed
        ? _animController.forward()
        : _animController.reverse();
  }

  // void _onDragStart(DragStartDetails details) {
  //   bool isDragOpenFromLeft =
  //       _animController.isDismissed && details.globalPosition.dx;
  // }

  // void _onDragUpdate() {}
  // void _onDragEnd() {}

  @override
  Widget build(BuildContext context) {
    var myDrawer = Container(color: Colors.blue);
    var myChild = Container(color: Colors.yellow);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        shadowColor: Colors.black,
        leading: FlatButton(
          color: Colors.blue,
          onPressed: () {
            //ativar animação
            toggle();
          },
          child: Icon(Icons.menu),
        ),
      ),
      body: Container(
        width: 400,
        child: GestureDetector(
          onTap: toggle,
          // onHorizontalDragStart: _onDragStart,
          // onHorizontalDragUpdate: _onDragUpdate,
          // onHorizontalDragEnd: _onDragEnd,
          child: AnimatedBuilder(
            animation: _animController,
            builder: (context, _) {
              double slide = _maxSlide * _animController.value;
              double scale = 1 - (_animController.value * 0.3);
              return Stack(
                children: <Widget>[
                  myDrawer,
                  Transform(
                    transform: Matrix4.identity()
                      ..translate(slide)
                      ..scale(scale),
                    alignment: Alignment.centerLeft,
                    child: myChild,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
