import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart'; //使用本地缓存策略获取token

class Http {
  Response resp;
  Dio dio = new Dio();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance(); 
  String host = 'http://musicapi.leanapp.cn';
  Future get(String url, {Map<String,dynamic> query}) async {
    final SharedPreferences prefs = await _prefs;
    try {
      resp = await dio.get(host+url,
          /*options: Options(headers: {"token":prefs.getString('token')获取token}),*/ queryParameters: query);
      if (resp.statusCode == 200) {
        var result = resp.data;
        var res = result;
        return res;
      } else {
        print('请求出错');
      }
    } catch (e) {
      return e;
    }
  }

  Future post(String url, {data}) async {
    final SharedPreferences prefs = await _prefs;
    try {
      resp =
          await dio.post(host+url,/*options: Options(headers: {"token":prefs.getString('token')获取token}),*/ data: data);
      if (resp.statusCode == 200) {
        var result = resp.data;
        var res = jsonDecode(result);
        return res;
      } else {
        print('请求出错');
      }
    } catch (e) {
      return e;
    }
  }
}

