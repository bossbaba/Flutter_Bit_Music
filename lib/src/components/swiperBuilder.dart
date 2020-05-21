import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class YSwiper extends StatefulWidget {
  YSwiper({Key key, @required this.listItem, this.onTap, this.height})
      : super(key: key);

  final List listItem;
  final onTap;
  final double height;
  @override
  State<StatefulWidget> createState() {
    return YSwiperBuilder();
  }
}

class YSwiperBuilder extends State<YSwiper> {
  // 渲染swiper项
  Widget _builderItem(context, index) {
    return YSwiperItem.builder(context, index, this.widget.listItem);
  }

  // 回调事件
  void _onTapHandler(index) {
    this.widget.onTap(index);
  }

  // 渲染轮播图
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(2.0, 3.0),
                  blurRadius: 6.0 /*,spreadRadius:2.0*/)
            ],
          ),
          child: Swiper(
            itemBuilder: _builderItem,
            itemCount: this.widget.listItem.length,
            autoplay: true,
            pagination: SwiperPagination(
                builder: FractionPaginationBuilder(
                    activeColor: Color(0xffffffff)),
                alignment: Alignment.bottomRight),
            control: null,
            onTap: this._onTapHandler,
          )),
    );
  }
}

// 轮播图单项
class YSwiperItem {
  static builder(BuildContext context, int index, List listItem) {
    return  Image.network(
          listItem[index]['imgurl'],
          fit: BoxFit.cover,
        );
  }
}
