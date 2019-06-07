import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_taobao/common/data/my.dart';
import 'package:flutter_taobao/common/data/shopping_cart.dart';
import 'package:flutter_taobao/common/model/conversation.dart';
import 'package:flutter_taobao/common/model/shopping_cart.dart';
import 'package:flutter_taobao/common/services/search.dart';
import 'package:flutter_taobao/common/style/gzx_style.dart';
import 'package:flutter_taobao/common/utils/common_utils.dart';
import 'package:flutter_taobao/common/utils/navigator_utils.dart';
import 'package:flutter_taobao/common/utils/screen_util.dart';
import 'package:flutter_taobao/ui/widget/UserIconWidget.dart';
import 'package:flutter_taobao/ui/widget/gzx_card.dart';
import 'package:flutter_taobao/ui/widget/gzx_checkbox.dart';
import 'package:flutter_taobao/ui/widget/pull_load/ListState.dart';
import 'package:flutter_taobao/ui/widget/pull_load/PullLoadWidget.dart';
import 'dart:math';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_taobao/ui/widget/shopping_cart_item.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info/package_info.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage>
    with AutomaticKeepAliveClientMixin<MyPage>, ListState<MyPage>, WidgetsBindingObserver {
  static const Color _backgroundColor = Color(0xFFf3f3f3);
  Gradient _mainGradient = const LinearGradient(colors: [_backgroundColor, _backgroundColor]);
  bool _isAllSelected = false;

  GlobalKey _keyFilter = GlobalKey();
  double _firstItemHeight = 0;
  BuildContext _context;

  _afterLayout(_) {
    _getPositions('_keyFilter', _keyFilter);
    _getSizes('_keyFilter', _keyFilter);
  }

  _getPositions(log, GlobalKey globalKey) {
    RenderBox renderBoxRed = globalKey.currentContext.findRenderObject();
    var positionRed = renderBoxRed.localToGlobal(Offset.zero);
    print("POSITION of $log: $positionRed ");
  }

  _getSizes(log, GlobalKey globalKey) {
    RenderBox renderBoxRed = globalKey.currentContext.findRenderObject();
    var sizeRed = renderBoxRed.size;
    print("SIZE of $log: $sizeRed");

    setState(() {
      _firstItemHeight = sizeRed.height;
    });
  }

  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
//      FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    super.build(context); // 如果不加这句，从子页面回来会重新加载didChangeDependencies()方法

    var pullLoadWidget = PullLoadWidget(
      pullLoadWidgetControl,
      (BuildContext context, int index) {
        switch (index) {
          case 0:
            return Container(
              color: _backgroundColor,
              child: TopItem(
                topBarOpacity: _topBarOpacity,
              ),
            );
            break;
          case 1:
            return _buildContent();
//return Container();
            break;
        }
        return Container();
      },
      handleRefresh,
      onLoadMore,
      refreshKey: refreshIndicatorKey,
    );

    // see https://github.com/flutter/flutter/issues/14842
    var body = Container(
      decoration: BoxDecoration(
        gradient: _mainGradient,
      ),
      child: MediaQuery.removePadding(
        removeTop: true,
        child: NotificationListener<ScrollNotification>(
            onNotification: _onScroll,
            child: Scrollbar(
                child: Stack(
              children: <Widget>[
                Container(
                  child: pullLoadWidget,
                ),
                Offstage(
                  offstage: !_isShowFloatingTopBar,
                  child: Container(
                    decoration: BoxDecoration(gradient: GZXColors.primaryGradient),
                    height: 48 + ScreenUtil.statusBarHeight,
                    width: ScreenUtil.screenWidth,
//                margin: EdgeInsets.only(top: ScreenUtil.statusBarHeight),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: ScreenUtil.statusBarHeight,
                        ),
                        Container(
                          height: 48,
                          child: _buildFloatingTopBar(),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ))),
        context: context,
      ),
    );

    return SafeArea(
      child: body,
      top: false,
    );
  }

  Widget _buildContent() {
    return ListView(
      primary: false,
      shrinkWrap: true,
      children: <Widget>[
        GZXCard(
          childAspectRatio: ((ScreenUtil.screenWidth - 24) / 5) / 70,
          color: _backgroundColor,
          leftTopTitle: '我的订单',
          rightTopTitle: '查看全部订单',
          underPicturesOnTextButtonModel: [
            UnderPicturesOnTextButtonModel('待付款', null, 24, 34),
            UnderPicturesOnTextButtonModel('待发货', null, 24, 34),
            UnderPicturesOnTextButtonModel('待收货', null, 24, 34),
            UnderPicturesOnTextButtonModel('评价', null, 24, 34),
            UnderPicturesOnTextButtonModel('退款', '退款/售后', 27, 34),
          ],
          crossAxisCount: 5,
        ),
        GZXCard(
          isShowTitleBar: false,
          color: _backgroundColor,
          buttonTextStyle: TextStyle(color: Colors.red, fontSize: 12),
          underPicturesOnTextButtonModel: [
            UnderPicturesOnTextButtonModel('主会场', null, 34, 34),
            UnderPicturesOnTextButtonModel('我的狂欢', null, 34, 34),
            UnderPicturesOnTextButtonModel('夏装不只5折', null, 34, 34),
            UnderPicturesOnTextButtonModel('买1享10', null, 34, 34),
          ],
          crossAxisCount: 4,
        ),
        GZXCard(
          color: _backgroundColor,
          leftTopTitle: '必备工具',
          rightTopTitle: '查看全部工具',
          underPicturesOnTextButtonModel: [
            UnderPicturesOnTextButtonModel('每日返现', null, 30, 30),
            UnderPicturesOnTextButtonModel('领券中心', null, 30, 30),
            UnderPicturesOnTextButtonModel('3亿红包', null, 30, 30),
            UnderPicturesOnTextButtonModel('客服小蜜', null, 30, 30),
            UnderPicturesOnTextButtonModel('花呗', null, 30, 30),
            UnderPicturesOnTextButtonModel('阿里宝卡', null, 30, 30),
            UnderPicturesOnTextButtonModel('我的评价', null, 30, 30),
            UnderPicturesOnTextButtonModel('主题换肤', null, 30, 30),
          ],
          crossAxisCount: 4,
        ),
        GZXCard(
          color: _backgroundColor,
          leftTopTitle: '淘宝游乐园',
          isShowRightTopWidget: false,
          contentPaddingTop: 0,
          contentPaddingBottom: 0,
          crossAxisCount: 2,
          childAspectRatio: (ScreenUtil.screenWidth / 2 - 24) / 60,
          customChildren: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 12, right: 12),
              decoration: BoxDecoration(border: Border(right: BorderSide(color: Color(0xFFeeede6), width: 1))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '天天红包赛',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        '全新上线梯度赛',
                        style: TextStyle(fontSize: 12, color: Color(0xFF5b5b5b)),
                      ),
                    ],
                  ),
                  Image.asset(
                    'static/images/天天红包赛.png',
                    width: 50,
                    height: 50,
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '野生小伙伴',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        '守护濒危动物',
                        style: TextStyle(fontSize: 12, color: Color(0xFF5b5b5b)),
                      ),
                    ],
                  ),
                  Image.asset(
                    'static/images/野生小伙伴.png',
                    width: 50,
                    height: 50,
                  )
                ],
              ),
            ),
          ],
        ),
        Container(
          color: _backgroundColor,
          padding: EdgeInsets.only(left: 12, top: 20, right: 12, bottom: 6),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  '我的卡片(4)',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: <Widget>[
                  Text(
                    '管理',
                    style: TextStyle(fontSize: 13, color: Color(0xFF999999)),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: 15,
                    color: Color(0xFF999999),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              )
            ],
          ),
        ),
        GZXCard(
            color: _backgroundColor,
            leftTopTitle: '我的亲情账号',
            leftTopTitleLeftImageName: '我的亲情账号',
            rightTopTitle: '管理亲情账号',
            contentPaddingTop: 0,
            contentPaddingBottom: 0,
            crossAxisCount: 2,
            childAspectRatio: (ScreenUtil.screenWidth / 2 - 24) / 100,
            customChildren: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        image: DecorationImage(
                            image: Image.network(
                                    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1559132082385&di=7bf7eff408959a3f6a9da47c1db8c2ee&imgtype=0&src=http%3A%2F%2Fimg1.2345.com%2Fduoteimg%2FqqTxImg%2F11%2F20126617171111586736.jpg')
                                .image)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '已绑定 ',
                        style: TextStyle(fontSize: 13, color: Color(0xFF5b5b5b)),
                      ),
                      Text(
                        '1',
                        style: TextStyle(fontSize: 13, color: Color(0xFFfb4f00)),
                      ),
                      Text(
                        ' 位家人',
                        style: TextStyle(fontSize: 13, color: Color(0xFF5b5b5b)),
                      ),
                    ],
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Color(0xFFfef2e5),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Color(0xFFfb4f00),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '添加其他家人',
                    style: TextStyle(fontSize: 13, color: Color(0xFFfb4f00)),
                  ),
                ],
              )
            ]),
        GZXCard(
          color: _backgroundColor,
          leftTopTitle: '我的支付宝',
          leftTopTitleLeftImageName: '我的支付宝',
          rightTopTitle: '更多服务',
          contentPaddingTop: 0,
          contentPaddingBottom: 0,
          crossAxisCount: 2,
          childAspectRatio: (ScreenUtil.screenWidth / 2 - 24) / 100,
          customChildren: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.center,
//                decoration: BoxDecoration(border: Border(right: BorderSide(color: Color(0xFFeeede6), width: 1))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '567.10',
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 28, color: Color(0xFF118ee9)),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Container(
//                              color: Colors.red,
                        child: Text(
                          '元',
                          style: TextStyle(color: Color(0xFF118ee9)),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    '4月份账单出炉啦',
                    style: TextStyle(fontSize: 13, color: Color(0xFF5b5b5b)),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    '看看钱都花哪去了',
                    style: TextStyle(fontSize: 11, color: Color(0xFF5b5b5b)),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.center,
//                decoration: BoxDecoration(border: Border(right: BorderSide(color: Color(0xFFeeede6), width: 1))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '1.75',
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 28, color: Color(0xFF118ee9)),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Container(
//                              color: Colors.red,
                        child: Text(
                          '万元',
                          style: TextStyle(color: Color(0xFF118ee9)),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    '用花呗 笔笔挖宝',
                    style: TextStyle(fontSize: 13, color: Color(0xFF5b5b5b)),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    '去看看',
                    style: TextStyle(fontSize: 11, color: Color(0xFF5b5b5b)),
                  ),
                ],
              ),
            ),
          ],
        ),
        GZXCard(
          color: _backgroundColor,
          leftTopTitle: '我的淘气值',
          leftTopTitleLeftImageName: '我的淘气值',
          rightTopTitle: '领取会员权益',
          contentPaddingTop: 0,
          contentPaddingBottom: 0,
          crossAxisCount: 2,
          childAspectRatio: (ScreenUtil.screenWidth / 2 - 24) / 100,
          customChildren: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.center,
//                decoration: BoxDecoration(border: Border(right: BorderSide(color: Color(0xFFeeede6), width: 1))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '967',
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 28, color: Color(0xFFfe4f02)),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Container(
//                              color: Colors.red,
                        child: Icon(
                          Icons.arrow_upward,
                          color: Color(0xFFfe4f02),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    '差33分成为超级会员',
                    style: TextStyle(fontSize: 14, color: Color(0xFFfb4f00)),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    '本期淘气值+3',
                    style: TextStyle(fontSize: 11, color: Color(0xFF5b5b5b)),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.center,
//                decoration: BoxDecoration(border: Border(right: BorderSide(color: Color(0xFFeeede6), width: 1))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'static/images/权益.png',
                    height: 30,
                    width: 30,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    '超值权益火爆申领',
                    style: TextStyle(fontSize: 13, color: Color(0xFFfb4f00)),
                  ),
                ],
              ),
            ),
          ],
        ),
        GZXCard(
          color: _backgroundColor,
          leftTopTitle: '我的健康',
          leftTopTitleLeftImageName: '我的健康',
          rightTopTitle: '管理我的健康',
          contentPaddingTop: 0,
          contentPaddingBottom: 0,
          crossAxisCount: 2,
          childAspectRatio: (ScreenUtil.screenWidth / 2 - 24) / 100,
          customChildren: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.center,
//                decoration: BoxDecoration(border: Border(right: BorderSide(color: Color(0xFFeeede6), width: 1))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'static/images/刷脸健康.png',
                    height: 60,
                    width: 60,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    '刷脸测睡眠',
                    style: TextStyle(fontSize: 13, color: Color(0xFF5b5b5b)),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    '看看我的黑眼圈程度',
                    style: TextStyle(fontSize: 11, color: Color(0xFF5b5b5b)),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.center,
//                decoration: BoxDecoration(border: Border(right: BorderSide(color: Color(0xFFeeede6), width: 1))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '减肥健身管理',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18, color: Color(0xFF00c8aa)),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    '立即开启',
                    style: TextStyle(fontSize: 13, color: Color(0xFF5b5b5b)),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    '月减5斤你也可以',
                    style: TextStyle(fontSize: 11, color: Color(0xFF5b5b5b)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFloatingTopBar({int productNum = 0}) {
    return Stack(
      children: <Widget>[
        Container(
//          color: Colors.blue,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              GestureDetector(
                  child: Text(
                '设置',
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
              SizedBox(
                width: 8,
              ),
            ],
          ),
        ),
        Center(
          child: Text(
            '追忆失去的心',
            textAlign: TextAlign.center,
            style: GZXConstant.appBarTitleWhiteTextStyle,
          ),
        ),
      ],
    );
  }

  double _lastScrollPixels = 0;
  bool _isShowFloatingTopBar = false;
  double _topBarOpacity = 1;

  bool _onScroll(ScrollNotification scroll) {
//    if (notification is! ScrollNotification) {
//      // 如果不是滚动事件，直接返回
//      return false;
//    }

//    ScrollNotification scroll = notification as ScrollNotification;
    if (scroll.metrics.axisDirection == AxisDirection.down) {
//      print('down');
    } else if (scroll.metrics.axisDirection == AxisDirection.up) {
//      print('up');
    }
    // 当前滑动距离
    double currentExtent = scroll.metrics.pixels;
    double maxExtent = scroll.metrics.maxScrollExtent;

    print('当前滑动距离 ${currentExtent} ${currentExtent - _lastScrollPixels}');

    //向下滚动
    if (currentExtent - _lastScrollPixels > 0) {
      if (currentExtent >= 0 && _mainGradient == GZXColors.primaryGradient) {
        setState(() {
          _mainGradient = const LinearGradient(colors: [Colors.white, Colors.white]);
        });
      }
      if (currentExtent <= 20) {
        setState(() {
          double opacity = 1 - currentExtent / 20;
          _topBarOpacity = opacity > 1 ? 1 : opacity;
//          if(_topBarOpacity<0.1){
//          }
        });

        print('向下滚动 $currentExtent=>$_topBarOpacity');
      } else {
        if (!_isShowFloatingTopBar) {
          setState(() {
            _isShowFloatingTopBar = true;
          });
        }
      }
    }

    //往上滚动
    if (currentExtent - _lastScrollPixels < 0) {
      if (currentExtent < 0 && _mainGradient != GZXColors.primaryGradient) {
        setState(() {
          _mainGradient = GZXColors.primaryGradient;
        });
      }
      if (currentExtent <= 20) {
        setState(() {
          double opacity = 1 - currentExtent / 20;
          _topBarOpacity = opacity > 1 ? 1 : opacity;
//          if(_topBarOpacity>0.9){
          _isShowFloatingTopBar = false;
//          }
        });
        print('往上滚动 $currentExtent=>$_topBarOpacity');
      } else {}
    }

    _lastScrollPixels = currentExtent;

//    if (maxExtent - currentExtent > widget.startLoadMoreOffset) {
//      // 开始加载更多
//
//    }

    // 返回false，继续向上传递,返回true则不再向上传递
    return false;
  }

  @override
  bool get isRefreshFirst => false;

  // 只会执行一次initState()
  @override
  bool get wantKeepAlive => true;

  @override
  Future<Null> handleRefresh() async {
//    setState(() {
//      _mainGradient = const LinearGradient(colors: [Colors.white, Colors.white]);
//    });
    if (isLoading) {
      return null;
    }
    isLoading = true;
    page = 1;
////    mockConversation.clear();
//    mockConversation.addAll(preConversation);
////    _conversationControlModel.clear();
    await getIndexListData(page);
    setState(() {
      pullLoadWidgetControl.needLoadMore = false;
    });
    isLoading = false;

    return null;
  }

  // 紧跟在initState之后调用
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Future<Null> onLoadMore() async {
    if (isLoading) {
      return null;
    }
    isLoading = true;
    page++;
    await getIndexListData(page);
    setState(() {
      // 3次加载数据
      pullLoadWidgetControl.needLoadMore = (mockConversation != null && mockConversation.length < 25);
    });
    isLoading = false;
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);

    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);

    WidgetsBinding.instance.addObserver(this);

    pullLoadWidgetControl.dataList = myData;
//    getIndexListData(1);
    setState(() => {pullLoadWidgetControl.needLoadMore = false});
    // getIndexListData(1);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  getIndexListData(page) async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      setState(() {
        pullLoadWidgetControl.dataList = myData;
      });
    } catch (e) {
      print(e);
    }
  }
}

//class _DeviceInfoItem extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
//      decoration: BoxDecoration(
//          border: Border(
//              top: BorderSide(color: Color(0xffd9d9d9), width: .4),
//              bottom: BorderSide(color: Color(0xffd9d9d9), width: .5)),
//          color: Color(0xffEDEDED)),
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.start,
//        crossAxisAlignment: CrossAxisAlignment.center,
//        children: <Widget>[
//          Padding(
//            padding: EdgeInsets.only(left: 22.0, right: 25.0),
//            child: Icon(Icons.access_time),
//          ),
//          Text(
//            'Windows 微信已登录，手机通知已关闭',
//            style: TextStyle(fontSize: 13.5, color: Colors.black54, fontWeight: FontWeight.w500),
//          )
//        ],
//      ),
//    );
//  }
//}
class TopItem extends StatelessWidget {
  final bool isShowFloatingTopBar;
  final double topBarOpacity;
  final int productNum;
  final Widget contentWidget;
  double _topBarHeight = 48;
  BuildContext _context;

  TopItem({Key key, this.isShowFloatingTopBar = false, this.topBarOpacity = 1, this.productNum = 0, this.contentWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Container(
//      width: 50,
//        color: ,
//        height: 367 + _topBarHeight + ScreenUtil.statusBarHeight + 30,
//      height: ScreenUtil.screenHeight / 4 + 14,
        child: Stack(children: <Widget>[
//          AnimatedPositioned(
//              curve: Curves.easeInOut,
//              duration: const Duration(milliseconds: 500),
//              left: 0,
//              top: 0,
//              height: ScreenUtil.screenHeight / 4,
//              child: Container(
//                  decoration: new BoxDecoration(
//                    gradient: GZXColors.primaryGradient,
//                  ),
////                color: Theme.of(context).primaryColor,
//                  width: ScreenUtil.screenWidth,
//                  height: ScreenUtil.screenHeight / 4)),
      Container(
        child: Container(
          decoration: new BoxDecoration(
            gradient: GZXColors.primaryGradient,
          ),
//                color: Theme.of(context).primaryColor,
          width: ScreenUtil.screenWidth,
          height: ScreenUtil.screenHeight / 4,
        ),
      ),
      Opacity(
        opacity: 1,
        child: Container(
//              height: _topBarHeight,
          margin: EdgeInsets.only(top: ScreenUtil.statusBarHeight + 10),
//          color: Colors.red,
          child: Column(
            children: <Widget>[
              Opacity(
                opacity: topBarOpacity,
                child: _buildTopBar(),
              ),
              Container(
                decoration: BoxDecoration(gradient: GZXColors.primaryGradient),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
//                    color: Colors.red,
                          child: _underDigitalTextOn(50, '收藏夹'),
                        ),
                        _underDigitalTextOn(45, '关注店铺'),
                        _underDigitalTextOn(149, '足迹'),
                        _underDigitalTextOn(14, '红包卡券'),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
              Stack(
                children: <Widget>[
                  Container(
                    height: 20,
                    decoration: BoxDecoration(gradient: GZXColors.primaryGradient),
                  ),
                  Container(
//                    decoration: BoxDecoration(gradient: GZXColors.primaryGradient),

//            color: Colors.red,
                      padding: EdgeInsets.all(4),
//              padding: EdgeInsets.only(top: 20,bottom: 20),
                      alignment: Alignment.center,
                      child: Card(
                        elevation: 0,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
                        //设置圆角
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Image.asset(
                                'static/images/88vip.png',
                                height: 40,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 14),
                                decoration: BoxDecoration(
                                  border: Border(left: BorderSide(color: Color(0xFFedeeed), width: 1)),
//                              color: Colors.red,
                                ),
                                child: Row(
                                  children: <Widget>[
//                                Container(
//                                  height: 40,
//                                  color: Color(0xFFedeeed),
//                                  width: 1,
//                                  padding: EdgeInsets.all(0),
//                                ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '兑天猫超市5元代金券',
                                          style: TextStyle(color: Color(0xFF666666)),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          '会员专享 每周可兑',
                                          style: TextStyle(color: Color(0xFF666666), fontSize: 12),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Image.asset(
                                'static/images/card.png',
                                height: 44,
                              ),
                            ],
                          ),
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),

//Container(height: 367,child: contentWidget,)
      Positioned(
          top: _topBarHeight + ScreenUtil.statusBarHeight + 30,
          height: 367,
          width: ScreenUtil.screenWidth,
          child: Container())
    ]));
  }

  Widget _underDigitalTextOn(count, text) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
//          color: Colors.blue,
          child: Text(
            '$count',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
//          color: Colors.blue,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
        )
      ],
    );
  }

  Widget _circleButton(Color imageBackgroundColor, IconData iconData, text, int unreadMessages) {
    return Container(
//      color: Colors.red,
      width: 50,
      child: GestureDetector(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
//        mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: imageBackgroundColor,
                  radius: 22,
                  child: Icon(
                    iconData,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF6a6a6a),
                  ),
                )
              ],
            ),
            Positioned(
              top: 10,
              right: 0,
              child: Container(
//                width: 18.0,
//                height: 18.0,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(20 / 2.0),
                    color: Color(0xffff3e3e)),
                child: Text(
                  '${unreadMessages}',
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Color(0xffffffff)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 8,
        ),
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              border: Border.all(color: Colors.white, width: 1),
              image: DecorationImage(
                  image: Image.asset(
                GZXIcons.huangjiaju,
                fit: BoxFit.fill,
              ).image)),
//          child: Image.asset(GZXIcons.huangjiaju, fit: BoxFit.fill,),
        ),
        SizedBox(
          width: 8,
        ),
        Container(
//          color: Colors.blue,
          height: 60,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '追忆失去的心',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Container(
                height: 24,
//                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: Color(0xFFde6700),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 18,
                    ),
                    Text(
                      '我的亲情账号',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Icon(
                GZXIcons.emoji,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.date_range,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () async {
                  PackageInfo packageInfo = await PackageInfo.fromPlatform();
                  var appVersion = packageInfo.version;
                  CommonUtils.showPromptDialog(_context, '', '当前版本V$appVersion');
                },
                child: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
