import 'package:flutter/material.dart';
import 'package:stackui/animation_controller_screen.dart';
import 'package:stackui/screens/custom_drawer_3d_screen.dart';
import 'package:stackui/screens/home_screen.dart';
import 'package:stackui/screens/stack_screen.dart';
import 'package:stackui/screens/transform_screen_one.dart';
import 'package:stackui/screens/custom_drawer_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Complex UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,
        accentColor: Colors.black54,
      ),
      home: HomeScreen(),
      routes: {
        StackScreen.routeName: (ctx) => StackScreen(),
        TransformScreenOne.routeName: (ctx) => TransformScreenOne(),
        AnimationControllerScreen.routeName: (ctx) =>
            AnimationControllerScreen(),
        CustomDrawerScreen.routeName: (ctx) => CustomDrawerScreen(),
        CustomDrawer3dScreen.routeName: (ctx) => CustomDrawer3dScreen(),
      },
    );
  }
}
