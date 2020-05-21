import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  Loading({Key key, this.height, this.width, this.isiOS = false}) : super(key: key);

  final double height;
  final double width;
  final bool isiOS;

  @override
  State<StatefulWidget> createState() {
    return LoadingBuilder();
  }
}

class LoadingBuilder extends State<Loading> {
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: widget.height ?? 20,
            width: widget.width ?? 20,
            margin: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
            padding: EdgeInsets.all(2.0),
            child: widget.isiOS == false
                ? CircularProgressIndicator(
                    strokeWidth: 1.6,
                  )
                : CupertinoActivityIndicator(
                    radius: 20,
                  ),
          ),
          Text(
            '加载中',
            style: TextStyle(fontSize: 12.0),
          )
        ],
      ),
    );
  }
}
