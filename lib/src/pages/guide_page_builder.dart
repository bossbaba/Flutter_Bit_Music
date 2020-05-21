import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app.dart';

class Guide extends StatefulWidget {
  Guide({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return GuideBuilder();
  }
}

class GuideBuilder extends State<Guide> {
  List _guideImages = [
    'lib/assets/guide/guide_1.png',
    'lib/assets/guide/guide_2.png',
    'lib/assets/guide/guide_3.png'
  ];

  Widget build(BuildContext context) {
    return PageView.builder(
        itemCount: this._guideImages.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == this._guideImages.length - 1) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Image.asset(
                      this._guideImages[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(bottom: 80),
                      child: OutlineButton(
                        hoverColor: Color(0xff808809),
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setBool('flagGuide', true).then((value) {
                            if(value){
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                                return App();
                              }));
                            }
                          });
                        },
                        child: Text('完成引导'),
                      ))
                ],
              ),
            );
          } else {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                this._guideImages[index],
                fit: BoxFit.cover,
              ),
            );
          }
        });
  }
}
