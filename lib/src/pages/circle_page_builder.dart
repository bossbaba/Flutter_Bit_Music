import 'package:flutter/material.dart';

class CirclePerson extends StatefulWidget {
  CirclePerson({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CirclePersonBuilder();
  }
}

class CirclePersonBuilder extends State<CirclePerson> {
  final style = TextStyle(
      color: Color(0xffffffff), fontWeight: FontWeight.bold, fontSize: 18.0);
  List<Widget> _getList() {
    List<Widget> list = [
    ];
    for (int i = 1; i < 6; i++) {
      list.add(Positioned(
        left: (i * 75.0 - i * 20),
        child: Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ),
                color: Colors.amber,
                borderRadius: BorderRadius.circular(75.0)),
            child: Center(
              child: Text('$i'),
            )),
      ));
    }

    return list;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('圈子'), centerTitle: true),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Color(0xff202020),
        child: Center(
          child: ListView.builder(
              itemCount: 30,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: this._getList(),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '圈子$index',
                            style: style,
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward_ios),
                            color: Color(0xffffffff),
                            onPressed: () {
                              print('$index');
                            },
                          )
                        ],
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
