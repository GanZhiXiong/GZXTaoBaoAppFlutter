import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_taobao/common/data/home.dart';
import 'package:flutter_taobao/common/style/gzx_style.dart';

class GZXSearchCardWidget extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final VoidCallback onTap;
  final bool isShowLeading;
  final ValueChanged<String> onSubmitted;

  const GZXSearchCardWidget({Key key, this.focusNode, this.textEditingController, this.onTap, this.isShowLeading=true, this.onSubmitted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return searchCard();
  }

  Widget searchCard() => Padding(
//    padding: const EdgeInsets.only(top: 8,bottom: 8),
        padding: const EdgeInsets.only(top: 0, right: 0),
        child: Card(
          elevation: 2.0,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))), //设置圆角
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                isShowLeading? Padding(
                  padding: EdgeInsets.only(right: 5, top: 0, left: 5),
                  child: Icon(
                    GZXIcons.search_light,
                    color: Colors.grey,
                    size: 20,
                  ),
                ):SizedBox(width: 10,),
//               Container(
//                 color: Colors.red,
//                 child:
                Expanded(
                  child: Container(
//                     color: Colors.red,
                      height: 30,
                      child: TextField(
                        onTap: onTap,
                        focusNode: focusNode,
                        style: TextStyle(fontSize: 13),
                        controller: textEditingController,
//                        autofocus: true,
//                    focusNode: _focusNode,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(top: 6),
                          border: InputBorder.none,
                          hintText: searchHintTexts[Random().nextInt(searchHintTexts.length)],
                        ),
                        onSubmitted: onSubmitted,
//                     ),
                      )),
                ),

                Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Icon(
                    GZXIcons.camera,
                    color: Colors.grey,
                    size: 20,
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
