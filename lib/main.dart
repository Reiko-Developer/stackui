import 'package:flutter/material.dart';
import 'package:stackui/screens/animation_controller_screen.dart';
import 'package:stackui/screens/airline_surveys_screen.dart';
import 'package:stackui/screens/custom_drawer_3d_screen.dart';
import 'package:stackui/screens/home_screen.dart';
import 'package:stackui/screens/stack_screen.dart';
import 'package:stackui/screens/teste_screen.dart';
import 'package:stackui/screens/transform_screen_one.dart';
import 'package:stackui/screens/custom_drawer_screen.dart';
import 'package:stackui/widgets/animations/flutter_animations/explicit_animations.dart';
import 'package:stackui/widgets/animations/flutter_animations/flutter_dev_animations2.dart';
import 'package:stackui/widgets/animations/flutter_animations/ioio_animation.dart';
import 'package:stackui/widgets/animations/flutter_animations/reusable_animation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final ThemeData _themeData = ThemeData(
    primarySwatch: Colors.indigo,
    primaryColor: Colors.indigo,
    accentColor: Colors.black54,
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Complex UI',
      theme: _themeData,
      home: TesteScreen(),
      routes: {
        StackScreen.routeName: (ctx) => StackScreen(),
        TransformScreenOne.routeName: (ctx) => TransformScreenOne(),
        AnimationControllerScreen.routeName: (ctx) =>
            AnimationControllerScreen(),
        CustomDrawerScreen.routeName: (ctx) => CustomDrawerScreen(),
        CustomDrawer3dScreen.routeName: (ctx) => CustomDrawer3dScreen(),
        AirlineSurveysScreen.routeName: (ctx) => AirlineSurveysScreen(),
        TesteScreen.routeName: (ctx) => TesteScreen(),
        //Flutter animations
        IoioAnimation.routeName: (ctx) => IoioAnimation(),
        FlutterDevAnimations.routeName: (ctx) => FlutterDevAnimations(),
        ReusableAnimation.routeName: (ctx) => ReusableAnimation(),
        ExplicitAnimations.routeName: (ctx) => ExplicitAnimations(),
      },
    );
  }
}
