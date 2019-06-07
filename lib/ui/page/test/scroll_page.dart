import 'package:flutter/material.dart';
import 'package:flutter_taobao/ui/page/home/searchlist_page.dart';

class ScrollPage extends StatefulWidget {
  @override
  _ScrollPageState createState() => _ScrollPageState();
}

class _ScrollPageState extends State<ScrollPage> {
  List<int> gridData = List<int>();

  _setGridData() {
    for (int i = 0; i < 50; i++) {
      gridData.add(i);
    }
  }

  @override
  void initState() {
    _setGridData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('方案一'),actions: <Widget>[
      IconButton(icon: Icon(Icons.arrow_upward), onPressed: (){
        setState(() {
          
        });
      })
    ],), body: _bodyWid());
  }

  Widget _bodyWid() {
    return CustomScrollView(slivers: <Widget>[
      SliverList(
          delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return _typeTitleWid('热门分类');
      }, childCount: 1)),
      SliverPadding(padding: const EdgeInsets.all(8.0), sliver: _typeGridWid()),
      SliverList(
          delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return _typeTitleWid('智能推荐');
      }, childCount: 1)),
      _typeListWid()
    ]);
  }

  Widget _typeTitleWid(var titleStr) {
    return Container(
        color: Colors.white,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(titleStr, style: TextStyle(color: Color(0xFF808080), fontSize: 14.0))),
              Divider(color: Color(0xFF808080), height: 0.5)
            ]));
  }

  Widget _typeGridWid() {
    return SliverGrid(
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, mainAxisSpacing: 8.0, crossAxisSpacing: 8.0, childAspectRatio: 4.0),
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          if (index + 8 == gridData.length) {
            for (int i = 0; i < 50; i++) {
              gridData.add(i);
            }
            try {
              setState(() {});
            } catch (e) {

            }
          }
          return Container(
//              height: 64.0,
              decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(3.0)),
              child:
                  Center(child: Text('分类 ${(index + 1)}', style: TextStyle(color: Color(0xFF333333), fontSize: 14.0))));
        }, childCount: gridData.length));
  }

  Widget _typeListWid() {
    return SliverFixedExtentList(
        itemExtent: 350.0,
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
//return          SearchResultListPage('iphone');

//          return Container(
//              child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  mainAxisSize: MainAxisSize.max,
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                Padding(
//                    padding: EdgeInsets.all(10.0),
//                    child: Text('推荐精彩内容 ${(index + 1)}',
//                        textAlign: TextAlign.left, style: TextStyle(color: Color(0xFF333333), fontSize: 15.0))),
//                Padding(padding: EdgeInsets.only(top: 4.0), child: Divider(color: Color(0xFF808080), height: 0.5))
//              ]));
        }, childCount: 1));
  }
}
