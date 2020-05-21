import 'package:flutter/material.dart';

class CirclePerson extends StatefulWidget {
  CirclePerson({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CirclePersonBuilder();
  }
}

class CirclePersonBuilder extends State<CirclePerson> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('圈子'), centerTitle: true),
      body: Container(
        child: Center(
          child: Text(''),
        ),
      ),
    );
  }
}
