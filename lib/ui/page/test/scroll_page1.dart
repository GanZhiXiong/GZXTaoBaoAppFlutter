import 'package:flutter/material.dart';

class ScrollPage1 extends StatefulWidget {
  @override
  _ScrollPage1State createState() => _ScrollPage1State();
}
class _ScrollPage1State extends State<ScrollPage1> {
  List<int> gridData = List<int>();

  _setGridData() {
    for (int i = 0; i < 15; i++) {
      gridData.add(i);
    }
  }

  @override
  void initState() {
    _setGridData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('方案二')), body: _bodyWid2());
  }

  Widget _typeGridWid2() {
    return GridView.count(
        primary: false,
        shrinkWrap: true,
        crossAxisCount: 4,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 4.0,
        padding: EdgeInsets.all(10.0),
        children: gridData.map((int index) {
          return Container(
              height: 64.0,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(3.0)),
              child: Center(
                  child: Text('分类 ${(index + 1)}',
                      style: TextStyle(
                          color: Color(0xFF333333), fontSize: 14.0))));
        }).toList());
  }

  Widget _typeListWid2() {
    return ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemCount: gridData.length,
        separatorBuilder: (BuildContext context, int index) => new Divider(),
        itemBuilder: (context, item) {
          return Padding(
              padding: EdgeInsets.all(12.0),
              child: Text('推荐精彩内容 ${(item + 1)}',
                  style: TextStyle(color: Color(0xFF333333), fontSize: 15.0)));
        });
  }

  Widget _bodyWid2() {
    return ListView(
        primary: false,
        shrinkWrap: true,
        children: <Widget>[
//      _typeTitleWid('热门分类'),
      _typeGridWid2(),
//      _typeTitleWid('智能推荐'),
      Container(height: MediaQuery.of(context).size.height-44-20,child: _typeListWid2(),)
    ]);
  }
}

