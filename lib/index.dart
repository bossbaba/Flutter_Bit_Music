import 'dart:ui';

import './src/app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/pages/guide_page_builder.dart';

class Index extends StatefulWidget {
  Index({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return IndexBuilder();
  }
}

class IndexBuilder extends State<Index> {
  Widget _indexPage = Container(
    color: Colors.white,
    width: window.physicalSize.width,
    height: window.physicalSize.height,
    child: Image.asset('lib/assets/splash/splash.png', fit: BoxFit.none),
  );

  Future _indexBuilder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var storageBool = prefs.getBool('flagGuide') ?? false;
    if (storageBool) {
      setState(() {
        _indexPage = App();
      });
    } else {
      setState(() {
        _indexPage = Guide();
      });
    }
  }

  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 2000), () {
      setState(() {
        _indexPage = Container(
          color: Colors.white,
        );
      });
      this._indexBuilder();
    });
  }

  Widget build(BuildContext context) {
    return _indexPage;
  }
}
