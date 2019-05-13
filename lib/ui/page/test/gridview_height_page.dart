import 'package:flutter/material.dart';

class GridViewHeightPage extends StatefulWidget {
  GridViewHeightPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GridViewHeightPageState createState() => new _GridViewHeightPageState();
}

class _GridViewHeightPageState extends State<GridViewHeightPage> {
  List<String> widgetList = ['A', 'B', 'C'];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 20) / 2;
    final double itemWidth = size.width / 2;

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Container(
        child: new GridView.count(
          crossAxisCount: 2,
          childAspectRatio: (itemWidth / itemHeight),
          controller: new ScrollController(keepScrollOffset: false),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: widgetList.map((String value) {
            return new Container(
              color: Colors.green,
              margin: new EdgeInsets.all(1.0),
              child: new Center(
                child: new Text(
                  value,
                  style: new TextStyle(
                    fontSize: 50.0,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}