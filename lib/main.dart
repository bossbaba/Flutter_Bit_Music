///////////////////////////////////////////
/// Anthor:YanLiTian                    ///
/// Description:Bit Music Application   ///
/// Time:2020-5-18                      ///
/// Email:449107144@qq.com              ///
///////////////////////////////////////////

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './src/router/router.dart';
import 'src/pages/error_page_builder.dart';

// 程序入口
void main() {
  runApp(MyApp());
}

/// Class MyApp
/// title:BitMusic
class MyApp extends StatelessWidget {
  final SystemUiOverlayStyle _style =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  @override
  Widget build(BuildContext context) {
    ///设置透明状态栏
    SystemChrome.setSystemUIOverlayStyle(_style);
    /// 构建Material风格App
    return MaterialApp(
      // App标题
      title: 'BitMusic',
      // 隐藏debug条幅
      debugShowCheckedModeBanner: false,
      // App主题设置
      theme: ThemeData(
        // 默认主题颜色
        primarySwatch:Colors.blue,
        primaryColor:Color(0xff000000),
        //设置动画平台风格
        platform: TargetPlatform.iOS,
        // 不知道这个是干啥的
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // 默认路由
      initialRoute: '/',
      // 所有路由
      routes: routes,
      // 路由生成器
      onGenerateRoute: (settings) {
        // 返回MaterialPageRoute
        return MaterialPageRoute(builder: (context) {
          // 如果访问的页面不在routes里面定义，返回404页面
          return ErrorPage();
        });
      },
    );
  }
}
