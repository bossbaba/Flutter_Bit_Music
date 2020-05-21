import 'package:bit/src/tools/tools.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import '../../src/components/scrollBuilder.dart';
import '../../src/components/swiperBuilder.dart';
import '../../assets/data/data.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeBuilder();
  }
}

class HomeBuilder extends State<Home>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final List sildeMenu = [
    {"text": "我的消息", "icon": Icons.message, 'id': 0},
    {"text": "退出", "icon": Icons.power_settings_new, 'id': 1}
  ];
  List<Widget> _drawerList = [];

  @override
  bool get wantKeepAlive => true;

  AnimationController controller;
  Animation animation;
  bool _isPlay = false;

  // loading标志
  bool _isLoading = false;
  // list
  List musicList = [];

  // 处理页面上拉加载事件
  void _onToBottomHandler() {
    if (this._isLoading == false) {
      if (mounted) {
        setState(() {
          this._isLoading = true;
        });
      }
      Future.delayed(Duration(seconds: 3), () {
        // this.getImgurl();
        if (mounted) {
          setState(() {
            this._isLoading = false;
          });
        }
      });
    }
  }

  // 处理页面下拉刷新
  void _onToTopHandler() async {
    setState(() {
      this._isLoading = false;
    });
    await Future.delayed(Duration(seconds: 3), () {
      // this.getImgurl();
    });
  }

  void _handlerDrawerEvent(item) {
    switch (item['id']) {
      case 1:
        print(item);
    }
  }

  Widget _buiderAvactor() {
    return UserAccountsDrawerHeader(
      margin: EdgeInsets.zero,
      accountEmail: Text('449107144@qq.com'),
      accountName: Text('MrDotYan'),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(
            'https://c-ssl.duitang.com/uploads/item/201511/21/20151121170646_SxiWE.jpeg'),
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.blue[600].withOpacity(0.1), BlendMode.hardLight),
              image: NetworkImage(
                  'http://image.biaobaiju.com/uploads/20180531/01/1527701693-pXIKFSZdiA.png'))),
    );
  }

  List<Widget> _builderOpreations() {
    return sildeMenu.map((item) {
      return ListTile(
        title: Text(
          '${item['text']}',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.right,
        ),
        trailing: Icon(
          item['icon'],
          color: Colors.white,
        ),
        onTap: () {
          this._handlerDrawerEvent(item);
          Navigator.of(context).pop();
        },
      );
    }).toList();
  }

  // 渲染右侧图标组
  List _actionsBuilder(BuildContext context) {
    List searchIcon = [
      {
        "icon": IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              this._searchHandler(context);
            })
      }
    ];
    return List<Widget>.from(searchIcon.asMap().keys.map((item) {
      return searchIcon[item]['icon'];
    }));
  }

  void _searchHandler(context) {
    Navigator.of(context).pushNamed('/search');
  }

  void _builderDrawer() {
    setState(() {
      _drawerList.add(this._buiderAvactor());
      _drawerList.addAll(this._builderOpreations());
    });
  }

  void _createAnimate() {
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //重置起点
        controller.reset();
        //开启
        controller.forward();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      } else if (status == AnimationStatus.forward) {
      } else if (status == AnimationStatus.reverse) {}
    });
    controller.forward();
  }

  Widget _builderSwiper() {
    return Container(
      width: window.physicalSize.width,
      height: 200,
      padding: EdgeInsets.all(10.0),
      child: YSwiper(
        listItem: swiper,
        height: 180,
      ),
    );
  }

  Widget _builderTitle(title) {
    var style = TextStyle(color: Colors.white);
    var style1 = TextStyle(
        color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.bold);
    return ListTile(
      title: Text(
        '$title',
        style: style1,
      ),
      trailing: InkWell(
          onTap: () {
            print('index');
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(16.0, 1.0, 16.0, 1.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                )),
            child: Text(
              '更多',
              style: style,
            ),
          )),
    );
  }

  Widget _getListVir(list) {
    return Container(
      width: window.physicalSize.width,
      height: 250,
      color: Color(0xff202020),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: 300,
              height: 200,
              color: Color(0xff202020),
              padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: Center(
                  child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Image.network(
                        list[index]['thumb'],
                        fit: BoxFit.cover,
                      ),
                      ListTile(
                        title: Text(
                          list[index]['title'],
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  ListTile(
                    title: Text(
                      "歌曲：${list[index]['title']}",
                      style: TextStyle(color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      "作者：${list[index]['singer']}",
                      style: TextStyle(color: Colors.white30),
                    ),
                  )
                ],
              )),
            );
          }),
    );
  }

  Widget _getListStory() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: List<Widget>.from(this.musicList.asMap().keys.map((index) {
          return InkWell(onTap: (){
            print(musicList[index]);
          },child: Container(
            margin: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 80,
                      height: 80,
                      margin: EdgeInsets.only(right: 8.0),
                      child: Image.network(
                        this.musicList[index]['picUrl'],
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      height: 80,
                      margin: EdgeInsets.only(right: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            musicList[index]['name'],
                            style: TextStyle(color: Color(0xffffffff)),
                          ),
                          Text(
                            musicList[index]['song']['artists'][0]['name'],
                            style: TextStyle(color: Color(0xffffffff)),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
                Icon(
                  Icons.play_arrow,
                  color: Color(0xffffffff),
                ),
              ],
            ),
          )
        );})),
      ),
    );
  }

  void getMusicList() {
    Http().get('/personalized/newsong').then((res) {
      if (res['code'] == 200) {
        setState(() {
          this.musicList = res['result'];
        });
      }
    });
  }

  void initState() {
    super.initState();
    this._builderDrawer();
    this._createAnimate();
    this.getMusicList();
  }

  void dispose() {
    this.controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('BitMusic'),
        centerTitle: true,
        actions: _actionsBuilder(context),
      ),
      drawer: Drawer(
        child: Container(
          color: Color(0xff303030),
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: _drawerList,
          ),
        ),
      ),
      floatingActionButton: _isPlay
          ? FloatingActionButton(
              backgroundColor: Color(0xff000000),
              onPressed: () {},
              child: RotationTransition(
                alignment: Alignment.center,
                turns: animation,
                child: Icon(
                  Icons.music_note,
                  color: Color(0xffffffff),
                ),
              ),
            )
          : null,
      body: SingleChildScrollViewBuilder(
          isLoading: this._isLoading,
          onScrollEvent: (scrollController) {},
          onToBottomEvent: _onToBottomHandler,
          onToTopEvent: _onToTopHandler,
          child: Container(
            color: Color(0xff202020),
            child: Column(
              children: <Widget>[
                this._builderSwiper(),
                this._builderTitle('推荐播放'),
                this._getListVir(music),
                this._builderTitle('新曲上线'),
                this._getListVir(music1),
                this._builderTitle('一歌一人，聆听灵魂'),
                this._getListStory()
              ],
            ),
          )),
    );
  }
}
