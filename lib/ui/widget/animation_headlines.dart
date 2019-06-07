import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_taobao/ui/widget/animation/diff_scale_text.dart';
import 'package:flutter_taobao/common/data/home.dart';

class AnimationHeadlinesWidget extends StatefulWidget {
  @override
  _AnimationHeadlinesWidgetState createState() => _AnimationHeadlinesWidgetState();
}

class _AnimationHeadlinesWidgetState extends State<AnimationHeadlinesWidget> {

  int _diffScaleNext = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer _countdownTimer = new Timer.periodic(new Duration(seconds: 3), (timer) {
//      print('countdownTimer.tick');
      if(mounted){
        setState(() {
          _diffScaleNext++;
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {

    return Row(children: <Widget>[
      SizedBox(
        width: 8,
      ),
      Text(
        '淘宝头条',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(
        width: 8,
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: Container(
          color: Color(0xFFfef2f2),
          child: Text(
            '精华',
            style: TextStyle(
              fontSize: 10,
              color: Colors.red[500],
            ),
          ),
        ),
      ),
      SizedBox(
        width: 8,
      ),
      Expanded(
          child: GestureDetector(
              onTap: () {
//    setState(() {
//    _diffScaleNext++;
//    });
              },
              child: Container(
//              color: bgColor,
                child: DiffScaleText(
                  text: headlines[_diffScaleNext % headlines.length],
                  textStyle: TextStyle(fontSize: 12, color: Colors.black),
                ),
                height: 30,
                alignment: Alignment.centerLeft,
              )))
    ]);
  }
}
