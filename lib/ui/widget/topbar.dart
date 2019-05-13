import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_taobao/common/style/gzx_style.dart';
import 'package:flutter_taobao/common/utils/navigator_utils.dart';
import 'package:flutter_taobao/ui/widget/gzx_search_card.dart';

class HomeTopBar extends StatelessWidget {
  // This ui.widget is the root of your application.
  TextEditingController _keywordTextEditingController = TextEditingController();

  final List<String> searchHintTexts;

  HomeTopBar({Key key, this.searchHintTexts}) : super(key: key);

  FocusNode _focus = new FocusNode();

  BuildContext _context;

  void _onFocusChange() {
//    print('HomeTopBar._onFocusChange${_focus.hasFocus}');
//    if(!_focus.hasFocus){
//      return;
//    }
//    NavigatorUtils.gotoSearchGoodsPage(_context);
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    _focus.addListener(_onFocusChange);

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(top: statusBarHeight, left: 0, right: 0, bottom: 0),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 6.0),
//            color: Colors.red,
            height: 30,
            width: 30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  GZXIcons.scan,
                  color: Colors.white,
                  size: 18,
                ),
                SizedBox(
                  height: 3,
                ),
                Expanded(
                  child: Text(
                    '扫一扫',
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),

          Expanded(
            flex: 1,
            child: GZXSearchCardWidget(
              onTap: (){
                FocusScope.of(context).requestFocus(FocusNode());
                NavigatorUtils.gotoSearchGoodsPage(_context);
              },
              textEditingController: _keywordTextEditingController,
              focusNode: _focus,
            ),
          ),

          Container(
            margin: EdgeInsets.only(left: 6.0),
//            color: Colors.red,
            width: 30,
            height: 30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  GZXIcons.qr_code,
                  color: Colors.white,
                  size: 18,
                ),
                SizedBox(
                  height: 3,
                ),
                Expanded(
                  child: Text(
                    '会员码',
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
//          Container(
//            margin: EdgeInsets.only(left: 6.0),
//            child: Icon(
//              Icons.add_alert,
//              size: 25.0,
//              color: Color.fromRGBO(132, 95, 63, 1.0),
//            ),
//          )
        ],
      ),
    );
  }
}
