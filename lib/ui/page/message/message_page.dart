import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_taobao/common/model/conversation.dart';
import 'package:flutter_taobao/common/services/search.dart';
import 'package:flutter_taobao/common/style/gzx_style.dart';
import 'package:flutter_taobao/common/utils/navigator_utils.dart';
import 'package:flutter_taobao/common/utils/screen_util.dart';
import 'package:flutter_taobao/ui/widget/GZXUserIconWidget.dart';
import 'package:flutter_taobao/ui/widget/pull_load/ListState.dart';
import 'package:flutter_taobao/ui/widget/pull_load/PullLoadWidget.dart';
import 'dart:math';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
    with AutomaticKeepAliveClientMixin<MessagePage>, ListState<MessagePage>, WidgetsBindingObserver {
  ConversationControlModel _conversationControlModel = new ConversationControlModel();
  Manager manager = new Manager();
  Gradient _mainGradient = const LinearGradient(colors: [Colors.white, Colors.white]);

  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
//      FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    print('_MessagePageState.build');
    super.build(context); // 如果不加这句，从子页面回来会重新加载didChangeDependencies()方法
//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
//    final page = ModalRoute.of(context);
//    page.didPush().then((x) {
//      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
//    });

// change the status bar color to material color [green-400]
//    _stat();

    var pullLoadWidget = PullLoadWidget(
      pullLoadWidgetControl,
      (BuildContext context, int index) {
        Conversation conversation = pullLoadWidgetControl.dataList[index];

        if (index == 0) {
//          return Container(color: Colors.red,height: 50,);
          return TopItem(
            topBarOpacity: _topBarOpacity,
          );
        }
        if (conversation.titleColor == 0xff000000 &&
            pullLoadWidgetControl.dataList[index - 1].titleColor != 0xff000000) {
          return Container(
            color: Colors.white,
//            margin: const EdgeInsets.only(top: 16),
            child: Column(
              children: <Widget>[
                Container(
                  color: Color(0xFFf1f2f1),
                  height: 14,
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 12,
                    ),
                    Icon(
                      GZXIcons.time_fill,
                      color: Color(0xFFf4c723),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      '两周前的消息',
                      style: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                _ConversationItem(conversation: pullLoadWidgetControl.dataList[index])
              ],
            ),
          );
        } else {
          return Container(
            color: Colors.white,
            child: _ConversationItem(conversation: pullLoadWidgetControl.dataList[index]),
          );
        }
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

//    return pullLoadWidget;

    return SafeArea(
      child: body,
      top: false,
    );
  }

  Widget _buildFloatingTopBar() {
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
                child: Icon(
                  GZXIcons.search_light,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              GestureDetector(
                child: Icon(
                  GZXIcons.people_list_light,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              GestureDetector(
                child: Icon(GZXIcons.add_light, color: Colors.white),
              ),
              SizedBox(
                width: 8,
              ),
            ],
          ),
        ),
        Center(
          child: Text(
            '消息',
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
      pullLoadWidgetControl.needLoadMore = (mockConversation != null && mockConversation.length == 15);
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
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);

    WidgetsBinding.instance.addObserver(this);

    print('_MessagePageState.didChangeDependencies');
    mockConversation.addAll(preConversation);
    pullLoadWidgetControl.dataList = mockConversation;
    _conversationControlModel.clear();
    getIndexListData(1);
    setState(() => {pullLoadWidgetControl.needLoadMore = true});
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
      var response = await get('https://randomuser.me/api/?results=10');
      List<Conversation> arr = [];
      for (int i = 0; i < response['results'].length; i++) {
        response['results'][i]['unReadMsgCount'] = i == Random().nextInt(10) ? Random().nextInt(20) : 0;
        arr.add(Conversation.fromJson(response['results'][i]));
        await _conversationControlModel.insert(Conversation.fromJson(response['results'][i]));
      }
      manager.setSate(true);
      setState(() {
        if (page == 1) {
          mockConversation.clear();
          mockConversation.addAll(preConversation);
          _conversationControlModel.clear();
        }
        mockConversation.addAll(arr);
      });
    } catch (e) {
      print(e);
    }
  }
}

class TopItem extends StatelessWidget {
  final bool isShowFloatingTopBar;
  final double topBarOpacity;
  double _topBarHeight = 48;

  TopItem({Key key, this.isShowFloatingTopBar = false, this.topBarOpacity = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
//      width: 50,
      color: Colors.white,
      height: ScreenUtil.screenHeight / 4 + 14,
      child: Stack(children: <Widget>[
        AnimatedPositioned(
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 500),
            left: 0,
            top: 0,
            child: Container(
                decoration: new BoxDecoration(
                  gradient: GZXColors.primaryGradient,
                ),
//                color: Theme.of(context).primaryColor,
                width: ScreenUtil.screenWidth,
                height: ScreenUtil.screenHeight / 4)),
        Opacity(
          opacity: topBarOpacity,
          child: Container(
            height: _topBarHeight,
            margin: EdgeInsets.only(top: ScreenUtil.statusBarHeight),
//          color: Colors.red,
            child: _buildTopBar(),
          ),
        ),
        Positioned(
            top: _topBarHeight + ScreenUtil.statusBarHeight,
            child: Opacity(
              opacity: topBarOpacity,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    '32条未读消息',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: Color(0xFFfea54e),
                    child: GestureDetector(
                      child: Icon(
                        GZXIcons.clear,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                ],
              ),
            )),
        Positioned(
//          top: _topBarHeight + ScreenUtil.statusBarHeight + 30,
          bottom: -6,
          width: ScreenUtil.screenWidth,
          height: 105,
          child: Container(
//            color: Colors.red,
              margin: EdgeInsets.all(4),
//              padding: EdgeInsets.only(top: 20,bottom: 20),
              alignment: Alignment.center,
              child: Card(
                elevation: 2,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))), //设置圆角
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _circleButton(Color(0xFF32b3fb), GZXIcons.deliver_fill, '交易物流', 2),
                    _circleButton(Color(0xFFf9cd13), GZXIcons.notification_fill, '通知消息', 18),
                    _circleButton(Color(0xFF7cdd22), GZXIcons.comment_fill_light, '互动消息', 5),
                  ],
                ),
              )),
        ),
      ]),
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
      children: <Widget>[
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            '消息',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
//                              width: 18.0,
          height: 24.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(22 / 2.0), color: Color(0xFFfb8f48)),
          child: Row(
            children: <Widget>[
              Icon(
                GZXIcons.search_light,
                size: 14,
                color: Colors.white,
              ),
              SizedBox(
                width: 2,
              ),
              Text(
                '搜索',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: 16,
        ),
        GestureDetector(
          child: Icon(
            GZXIcons.people_list_light,
            color: Colors.white,
          ),
        ),
        SizedBox(
          width: 16,
        ),
        GestureDetector(
          child: Icon(GZXIcons.add_light, color: Colors.white),
        ),
        SizedBox(
          width: 8,
        ),
      ],
    );
  }
}

class _ConversationItem extends StatelessWidget {
  const _ConversationItem({Key key, this.conversation})
      : assert(conversation != null),
        super(key: key);
  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    // 头像组件
    Widget userImage = new GZXUserIconWidget(
        padding: const EdgeInsets.only(top: 0.0, right: 8.0, left: 0.0),
        width: 50.0,
        height: 50.0,
        image: conversation.avatar,
        isNetwork: conversation.isNetwork,
        onPressed: () {});

    // 未读消息角标
    Widget unReadMsgCountText;
    if (conversation.unReadMsgCount > 0) {
      unReadMsgCountText = Positioned(
        child: Container(
          width: 18.0,
          height: 18.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20 / 2.0), color: Color(0xffff3e3e)),
          child: Text(
            conversation.unReadMsgCount.toString(),
            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Color(0xffffffff)),
          ),
        ),
        right: 0.0,
        top: -5.0,
      );
    } else if (conversation.displayDot) {
      unReadMsgCountText = Positioned(
        child: Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20 / 2.0), color: Color(0xffff3e3e)),
        ),
        right: 2.0,
        top: -5.0,
      );
    } else {
      unReadMsgCountText = Positioned(
        child: Container(),
        right: 0.0,
        top: -5.0,
      );
    }

    return Container(
      margin: EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xffd9d9d9), width: .3)),
//        color: Colors.red,
      ),
      height: 75,
      child: RawMaterialButton(
        onPressed: () {
          NavigatorUtils.gotoGZXChatPage(context, conversation).whenComplete(() {
            FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: userImage,
//                child: Stack(
//                  overflow: Overflow.visible,
//                  children: <Widget>[
//                    userImage,
////                unReadMsgCountText,
//                  ],
//                )
            ),
//          Expanded(child: Container(color: Colors.red,),),
            Expanded(
                child: Container(
//              decoration: BoxDecoration(
//                border: Border(bottom: BorderSide(color: Color(0xffd9d9d9), width: .5)),
//              ),
              padding: EdgeInsets.only(top: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        conversation.title,
                        style: TextStyle(fontSize: 14.5, color: Color(conversation.titleColor)),
                      ),
                      conversation.type == null
                          ? Container()
                          : Container(
                              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
//                              width: 18.0,
                              height: 18.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20 / 2.0), color: Color(0xFFf1f1f1)),
                              child: Text(
                                conversation.type,
                                style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.bold, color: Color(0xFF9c9c9c)),
                              ),
                            )
                    ],
                  ),
                  Container(
                    height: 2.0,
                  ),
                  Text(
                    conversation.describtion,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey, fontSize: 13.0),
                  )
                ],
              ),
            )),
            Container(
//                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xffd9d9d9), width: .5))),
                padding: EdgeInsets.only(top: 12.0, right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      conversation.createAt,
                      style: TextStyle(color: Color(0xffBEBEBE), fontSize: 13.0),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    conversation.unReadMsgCount <= 0
                        ? Container()
                        : Container(
                            width: 18.0,
                            height: 18.0,
                            alignment: Alignment.center,
                            decoration:
                                BoxDecoration(borderRadius: BorderRadius.circular(20 / 2.0), color: Color(0xffff3e3e)),
                            child: Text(
                              conversation.unReadMsgCount.toString(),
                              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Color(0xffffffff)),
                            ),
                          ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
