import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  ErrorPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ErrorPageBuilder();
  }
}

class ErrorPageBuilder extends State<ErrorPage> {
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
