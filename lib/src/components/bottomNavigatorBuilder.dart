import 'package:flutter/material.dart';

/*
 * 说明 组件
 * @类名 BottomTabBar
 * @参数 {Key key,this.listItem,this.onTap,this.tabIndex} @required标志必填
 * */ 

class BottomTabBar extends StatefulWidget {
  // 初始化BottomBar类
  BottomTabBar({Key key,
    @required this.listItem, 
    @required this.onTap,
    @required this.tabIndex}
  ):super(key:key);
  final List listItem ; //底部菜单icon和标题数组
  final onTap; //底部菜单点击事件
  final int tabIndex; //激活的底部菜单项
  BottomTabBarBuilder createState() => BottomTabBarBuilder();
}
/*
 * 说明 组件builder类
 * @类名 BottomTabBarBuilder
 * @参数 
 * */ 
class BottomTabBarBuilder extends State<BottomTabBar> {
  void _onTapHandler (value) {
    // 底部菜单点击事件
    this.widget.onTap(value);
  }
  Widget build(BuildContext context) {
    // 底部菜单构造函数
    return  BottomNavigationBar(
        // 激活的菜单项序号 
        currentIndex: this.widget.tabIndex,
        // 如果底部菜单项超过两个，整个菜单的类型就会改变，这里重置类型
        type: BottomNavigationBarType.fixed,
        // 重置激活颜色并获取appbar的颜色作为激活色
        unselectedItemColor: Colors.white70,
        fixedColor: Color(0xffffffff),
        backgroundColor: Color(0xff000000),
        onTap: _onTapHandler,
        items: BottomNavigationBarListBuilder.builder(context, this.widget.listItem),
    );
  }
}
/*
 * 说明 组件builder类
 * @类名 BottomNavigationBarListBuilder
 * @参数 
 * */ 
class BottomNavigationBarListBuilder {
    // 底部菜单项构造函数
  static builder(BuildContext context,List listItem) {
    return List<BottomNavigationBarItem>.from(listItem.asMap().keys.map((item){
      return BottomNavigationBarItem(
        icon: listItem[item]['icon'],
        title: listItem[item]['title'],
      );
    }));
  }
}