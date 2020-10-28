import 'package:flutter/material.dart';

import 'package:stackui/animation_controller_screen.dart';
import 'package:stackui/screens/custom_drawer_3d_screen.dart';
import 'package:stackui/screens/stack_screen.dart';
import 'package:stackui/screens/transform_screen_one.dart';
import 'package:stackui/screens/custom_drawer_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List screens = List<String>();

    screens.add(StackScreen.routeName);
    screens.add(TransformScreenOne.routeName);
    screens.add(AnimationControllerScreen.routeName);
    screens.add(CustomDrawerScreen.routeName);
    screens.add(CustomDrawer3dScreen.routeName);

    return Scaffold(
      appBar: AppBar(
        title: Text('Learning Complex UI'),
      ),
      body: Card(
        child: GridView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: screens.length,
          itemBuilder: (ctx, i) {
            return RaisedButton(
              child: Text((i + 1).toString()),
              onPressed: () => Navigator.pushNamed(context, screens[i]),
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        ),
      ),
    );
  }
}
