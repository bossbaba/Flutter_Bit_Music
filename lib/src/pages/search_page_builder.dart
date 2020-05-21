import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SearchBuilder();
  }
}

class SearchBuilder extends State<Search> {
  String str = '';
  // 输入监听
  void _searchHandler(value) {
    setState(() {
      str = value;
    });
  }

  // 点击右侧搜索图标
  void _onTapEvent(context) {
    FocusScope.of(context).requestFocus(FocusNode());
    this._searchEvent();
    print(str);
  }

  // 点击键盘上的搜索或者确定按钮
  void _serachSubHandler(value) {
    setState(() {
      str = value;
    });
    this._searchEvent();
  }

  void _searchEvent(){

  }

  void initState() {
    super.initState();
  }

  // 渲染限制高度的输入框
  Widget _searchBuilder(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: 50, maxWidth: MediaQuery.of(context).size.width - 100),
      child: new TextField(
        onChanged: _searchHandler,
        style: TextStyle(color: Colors.white),
        onSubmitted: _serachSubHandler,
        textInputAction: TextInputAction.search,
        cursorColor: Colors.white,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
            hintText: '请输入搜索内容',
            hintStyle: TextStyle(color: Colors.white),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1)),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1))),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _searchBuilder(context),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                this._onTapEvent(context);
              })
        ],
      ),
      body: Container(
        child: Center(
          child: Text(''),
        ),
      ),
    );
  }
}
