import 'package:flutter/material.dart';

class Share extends StatefulWidget {
  Share({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ShareBuilder();
  }
}

class ShareBuilder extends State<Share> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(''), centerTitle: true),
      body: Container(
        child: Center(
          child: Text(''),
        ),
      ),
    );
  }
}
