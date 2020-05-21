import 'pages/musiclib_page_builder.dart';
import 'package:flutter/material.dart';
import './components/bottomNavigatorBuilder.dart';
import 'pages/home_page_bulider.dart';
import 'pages/circle_page_builder.dart';

// talk is cheap ，show me the bug
/*
 * 说明 组件
 * @类名 App
 * @参数 
 * */
class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AppBuilder();
  }
}

/*
 * 说明 组件builder类
 * @类名 AppBuilder
 * @参数 
 * */
class AppBuilder extends State<App>   {
  // pageview控制器
  PageController _controller = new PageController();
  // 页面队列
  List pageQueue = [Home(), CirclePerson(), MusicLib()];
  // 激活菜单序号，也是当前显示页面序号
  int tabIndex = 0;

  bool hasToken = true;
  // 菜单项列表
  // 注意这里使用自定义图标
  List listItem = [
    {
      "icon": Icon(
        Icons.home,
        size: 28.0,
      ),
      "title": Text('首页')
    },
    {
      "icon": Icon(
        Icons.people_outline,
        size: 28.0,
      ),
      "title": Text('圈子')
    },
    {
      "icon": Icon(
        Icons.music_video,
        size: 28.0,
      ),
      "title": Text('媒体库')
    }
  ];
  // 底部菜单点击事件
  void _onTabHandler(index) {
    setState(() {
      // 设置当前激活页面
      _controller.animateToPage(
        index, duration: Duration(milliseconds: 400), //跳转的间隔时间
        curve: Curves.fastOutSlowIn, //跳转动画
      );
    });
  }

  // 滑动页面事件
  void _onPageChanged(index) {
    setState(() {
      // 设置当前激活菜单项序号
      tabIndex = index;
    });
  }

  void initState() {
    super.initState();
    print('init');
  }

  // pageView构造函数
  // context AppBuilder的context，这个context实际上决定了这个函数构造出来的部件的归属
  // index 序号
  Widget _pageViewBuilder(BuildContext context, int index) {
    return pageQueue[index];
  }

  Widget build(BuildContext context) {
    // 注意这里实际上是一个scaffold，由于这里的appbar为null
    // 所以会被当前的pageview覆盖
    return Scaffold(
      // 页面body
      body: PageView.builder(
          controller: _controller,
          onPageChanged: _onPageChanged,
          itemCount: pageQueue.length,
          itemBuilder: _pageViewBuilder),
      // 页面底部导航
      bottomNavigationBar: BottomTabBar(
        listItem: listItem,
        onTap: _onTabHandler,
        tabIndex: tabIndex,
      ),
    );
  }
}
