import 'package:flutter/material.dart';

class StackScreen extends StatefulWidget {
  static final routeName = '/stack';

  @override
  _StackScreenState createState() => _StackScreenState();
}

class _StackScreenState extends State<StackScreen> {
  List<Widget> containersList = List<Widget>();

  initState() {
    super.initState();
    containersList.add(Container(color: Colors.blue, height: 50, width: 50));
    containersList.add(Container(color: Colors.black, height: 25, width: 25));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stack Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(children: containersList),
            SizedBox(height: 5),
            Stack(
              alignment: Alignment.bottomCenter,
              children: containersList,
            ),
            SizedBox(height: 5),
            SizedBox(height: 5),
            //When inside a Widget that doesn't explicity set their size, then the stack uses only the necessary space.
            Container(
              color: Colors.grey,
              child: Stack(children: containersList),
            ),
            SizedBox(height: 5),
            Container(
              height: 80,
              width: 100,
              color: Colors.grey,
              child: Stack(
                children: containersList,
              ),
            ),
            SizedBox(height: 5),
            Container(
              height: 237,
              width: 400,
              color: Colors.grey,
              child: Stack(
                //Set if the overflow part of a widget will be shown or not.
                overflow: Overflow.visible,
                //Fit doesn't affect Positioned children.
                fit: StackFit.loose,
                children: [
                  Container(color: Colors.blue, height: 150, width: 150),
                  //Set the distance from these positions.
                  //Overrides the dimensions of the child.
                  Positioned(
                      //Can only set two from: top,height and bottom.
                      top: -10,
                      // height: ,
                      // bottom: ,
                      //Can only set two from: left, width and right.
                      //left: 30,
                      // width: ,
                      right: 20,
                      child:
                          Container(color: Colors.pink, height: 50, width: 50)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
