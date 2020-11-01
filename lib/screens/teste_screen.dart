import 'package:flutter/material.dart';
import 'package:stackui/widgets/animations/multiple_animation_controller.dart';

class TesteScreen extends StatelessWidget {
  const TesteScreen({Key key}) : super(key: key);
  static final routeName = '/teste';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultipleAnimationController(Duration(seconds: 2)),
    );
  }
}
