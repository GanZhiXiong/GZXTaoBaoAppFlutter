import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_taobao/ui/page/home/search_goods_page.dart';
import 'package:flutter_taobao/ui/page/home/search_goods_result_page.dart';
import 'package:flutter_taobao/ui/page/message/gzx_chat_page.dart';

class NavigatorUtils {
  static gotoSearchGoodsPage(BuildContext context, {String keywords}) {
//    NavigatorRouter(
//        context,
//        new SearchGoodsPage(
//          keywords: keywords,
//        ));

    return Navigator.of(context).push(new MyCupertinoPageRoute(SearchGoodsPage(
      keywords: keywords,
    )));
  }

  static gotoSearchGoodsResultPage(BuildContext context, String keywords) {
    NavigatorRouter(
        context,
        new SearchGoodsResultPage(
          keywords: keywords,
        ));
  }

  static Future gotoGZXChatPage(BuildContext context, conversation) {
    return NavigatorRouter(
        context,
        new GZXChatPage(
          conversation: conversation,
        ));
  }

  static NavigatorRouter(BuildContext context, Widget widget) {
    return Navigator.push(context, new CupertinoPageRoute(builder: (context) => widget));
  }

  ///弹出 dialog
  static Future<T> showGSYDialog<T>({
    @required BuildContext context,
    bool barrierDismissible = true,
    WidgetBuilder builder,
  }) {
    return showDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return MediaQuery(
            ///不受系统字体缩放影响
              data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                  .copyWith(textScaleFactor: 1),
              child: new SafeArea(child: builder(context)));
        });
  }
}

class MyCupertinoPageRoute extends CupertinoPageRoute {
  Widget widget;

  MyCupertinoPageRoute(this.widget) : super(builder: (BuildContext context) => widget);

  // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return new FadeTransition(opacity: animation, child: widget);
  }

  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => Duration(seconds: 0);
}
