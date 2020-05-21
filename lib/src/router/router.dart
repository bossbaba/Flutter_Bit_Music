import 'package:flutter/material.dart';

import '../../index.dart';
import '../../src/pages/webview_page_builder.dart';
import '../../src/pages/search_page_builder.dart';


Map<String , WidgetBuilder> routes = {
  '/':(context)=>Index(),
  '/webview':(context)=>WebViewPage(webConfig: ModalRoute.of(context).settings.arguments),
  '/search':(context)=>Search()
};