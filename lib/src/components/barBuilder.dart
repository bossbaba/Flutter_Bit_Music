import 'package:flutter/material.dart';

class Bar extends StatefulWidget {
  Bar({Key key,this.height,this.width,this.color}) : super(key: key);
  final double height;
  final double width;
  final Color color;

  @override
  State<StatefulWidget> createState() {
    return BarBuilder();
  }
}

class BarBuilder extends State<Bar> {
  // 渲染bar组件
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: this.widget.height!=null?this.widget.height:10.0,
      width: this.widget.width != null?this.widget.width:screenWidth,
      color: this.widget.color!=null?this.widget.color:Colors.black12,
    );
  }
}
