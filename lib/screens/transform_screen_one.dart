import 'package:flutter/material.dart';
import 'dart:math';

class TransformScreenOne extends StatefulWidget {
  static final routeName = '/transform-1';

  @override
  _TransformScreenOneState createState() => _TransformScreenOneState();
}

class _TransformScreenOneState extends State<TransformScreenOne> {
  double sliderVal = 0;

  Container rotate() {
    return Container(
      child: Transform.rotate(
        angle: sliderVal,
        child: container(Colors.red),
      ),
    );
  }

  Container scale() {
    return Container(
      child: Transform.scale(
        scale: sliderVal / 50,
        child: container(Colors.blue),
      ),
    );
  }

  Container translate() {
    return Container(
      child: Transform.translate(
        offset: Offset((sliderVal * 2.6) - 130, (sliderVal * 3) - 150),
        child: container(Colors.green),
      ),
    );
  }

  Container skewX() {
    return Container(
      child: Transform(
        transform: Matrix4.skewX(sliderVal / 100),
        child: container(Colors.yellow),
      ),
    );
  }

  Container skewY() {
    return Container(
      child: Transform(
        transform: Matrix4.skewY(sliderVal / 100),
        child: container(Colors.grey),
      ),
    );
  }

  Container threeDX() {
    return Container(
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, sliderVal / 500)
          ..rotateX(pi / 20),
        alignment: FractionalOffset.center,
        child: container(Colors.pink),
      ),
    );
  }

  Container threeDY() {
    return Container(
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, sliderVal / 500)
          ..rotateY(pi / 20),
        alignment: FractionalOffset.center,
        child: container(Colors.orange),
      ),
    );
  }

  Container threeDZ() {
    return Container(
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, sliderVal / 1000)
          ..rotateZ(pi / (sliderVal == 0 ? 0.00001 : (sliderVal / 20))),
        child: container(Colors.purple),
      ),
    );
  }

  Container container(MaterialColor color) {
    return Container(
      height: 50,
      width: 50,
      color: color,
      child: Icon(Icons.android_sharp),
    );
  }

  Slider slider() {
    return Slider(
      value: sliderVal,
      min: 0,
      max: 100,
      onChanged: (val) {
        setState(() => sliderVal = val);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    sliderVal = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(sliderVal.toStringAsFixed(1)),
          slider(),
          rotate(),
          scale(),
          translate(),
          skewX(),
          skewY(),
          threeDX(),
          threeDY(),
          threeDZ(),
        ],
      ),
    );
  }
}
