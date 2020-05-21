import 'package:flutter/material.dart';

class MyItemGridView extends StatefulWidget {
  MyItemGridView({Key key, this.itemList, this.rowcount, this.onTap,this.onLongTap,this.addHeight})
      : super(key: key);

  final List itemList;
  final int rowcount;
  final onTap;
  final onLongTap;
  final double addHeight;

  @override
  State<StatefulWidget> createState() {
    return ItemGridViewBuilder();
  }
}

class ItemGridViewBuilder extends State<MyItemGridView> {
  Widget _gridViewBuilder(BuildContext context, {int rowcount}) {
    var width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      padding: EdgeInsets.all(8.0),
      child: Wrap(
        runSpacing: 8.0,
        spacing: 8.0,
        children: widget.itemList.asMap().keys.map((index) {
          return SizedBox(
              // height:
              //     (width - 20 - (rowcount != null ? (rowcount - 1) : 4) * 8) /
              //         (rowcount != null ? rowcount : 5)+(widget.addHeight??0),
              width:
                  (width - 20 - (rowcount != null ? (rowcount - 1) : 4) * 8) /
                      (rowcount != null ? rowcount : 5),
              child: InkWell(
                onTap: (){
                  widget.onTap(index);
                },
                onLongPress: (){
                  widget.onLongTap(index);
                },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:<Widget>[
                      widget.itemList[index]['icon']??Container(),
                      widget.itemList[index]['title']??Container()
                    ]
                ),
              ));
        }).toList(),
      ),
    );
  }

  Widget build(BuildContext context) {
    return _gridViewBuilder(context, rowcount: widget.rowcount);
  }
}
