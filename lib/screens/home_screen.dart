import 'package:flutter/material.dart';
import 'package:stackui/screens/animation_controller_screen.dart';
import 'package:stackui/screens/airline_surveys_screen.dart';
import 'package:stackui/screens/custom_drawer_3d_screen.dart';
import 'package:stackui/screens/stack_screen.dart';
import 'package:stackui/screens/reiko_animations_screen.dart';
import 'package:stackui/screens/teste_screen.dart';
import 'package:stackui/screens/transform_screen_one.dart';
import 'package:stackui/screens/custom_drawer_screen.dart';
import 'package:stackui/widgets/animations/flutter_animations/explicit_animations.dart';
import 'package:stackui/widgets/animations/flutter_animations/flutter_dev_animations2.dart';
import 'package:stackui/widgets/animations/flutter_animations/ioio_animation.dart';
import 'package:stackui/widgets/animations/flutter_animations/reusable_animation.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List screens = List<String>();

    screens.add(StackScreen.routeName);
    screens.add(TransformScreenOne.routeName);
    screens.add(AnimationControllerScreen.routeName);
    screens.add(CustomDrawerScreen.routeName);
    screens.add(CustomDrawer3dScreen.routeName);
    screens.add(AirlineSurveysScreen.routeName);
    screens.add(ReikoAnimationsScreen.routeName);
    //flutter animations
    screens.add(FlutterDevAnimations.routeName);
    screens.add(IoioAnimation.routeName);
    screens.add(ReusableAnimation.routeName);
    screens.add(ExplicitAnimations.routeName);
    //Reiko Animations
    screens.add(ReikoAnimationsScreen.routeName);
    screens.add(TesteScreen.routeName);

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
              child: Text(screens[i]),
              onPressed: () => Navigator.pushNamed(context, screens[i]),
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
        ),
      ),
    );
  }
}
