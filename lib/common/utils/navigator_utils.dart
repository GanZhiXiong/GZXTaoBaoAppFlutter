import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_taobao/ui/page/home/search_goods_page.dart';
import 'package:flutter_taobao/ui/page/home/search_goods_result_page.dart';
import 'package:flutter_taobao/ui/page/message/gzx_chat_page.dart';

class NavigatorUtils{

  static gotoSearchGoodsPage(BuildContext context,{String keywords}) {
    NavigatorRouter(context, new SearchGoodsPage(keywords: keywords,));
  }

  static gotoSearchGoodsResultPage(BuildContext context,String keywords) {
    NavigatorRouter(context, new SearchGoodsResultPage(keywords: keywords,));
  }

  static Future  gotoGZXChatPage(BuildContext context,conversation) {
    return NavigatorRouter(context, new GZXChatPage(conversation: conversation,));
  }

  static NavigatorRouter(BuildContext context, Widget widget) {
    return Navigator.push(context, new CupertinoPageRoute(builder: (context) => widget));
  }
}