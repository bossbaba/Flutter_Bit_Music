import 'package:flutter/material.dart';

class MusicLib extends StatefulWidget {
  MusicLib({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MusicLibBuilder();
  }
}

class MusicLibBuilder extends State<MusicLib> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('媒体库'), centerTitle: true),
      body: Container(
        child: Center(
          child: Text(''),
        ),
      ),
    );
  }
}
