import 'package:flutter/material.dart';
import './loadingBuilder.dart';

class SingleChildScrollViewBuilder extends StatefulWidget {
  SingleChildScrollViewBuilder(
      {Key key,
      @required this.child, //必须有的参数
      this.onScrollEvent, //滚动事件
      this.onToBottomEvent, //触底事件
      this.onToTopEvent,
      this.isLoading = false,
      this.isiOS = false}) //触顶事件
      : super();

  final Widget child;
  final bool isLoading;
  final bool isiOS;
  final onScrollEvent;
  final onToBottomEvent;
  final onToTopEvent;

  SingleChildScrollViewRoute createState() => SingleChildScrollViewRoute();
}

class SingleChildScrollViewRoute extends State<SingleChildScrollViewBuilder> {
  ScrollController controller;
  @override
  void initState() {
    super.initState();
    controller = new ScrollController();
    _scrollEventListener();
  }



  void _scrollEventListener() {
    // 滚动监听函数
    this.controller.addListener(() {
      widget.onScrollEvent(this.controller); //回调函数传值到父组件
//      position 定位
//      pixel 当前滚动位置
//      maxScrollExtent 当前视图最大位置
      if (this.controller.position.pixels ==
          this.controller.position.maxScrollExtent) {
        widget.onToBottomEvent();
      }
    });
  }

  @override
  void dispose() {
    this.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await widget.onToTopEvent();
      },
      child: SingleChildScrollView(
        controller: this.controller,
        child: Center(child:Column(children: <Widget>[
           widget.child,
           widget.isLoading == false?Container():Loading(isiOS: widget.isiOS,height: 28.0,width:28.0 ,)
        ],)),
      ),
    );
  }
}
