import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_taobao/common/data/shopping_cart.dart';
import 'package:flutter_taobao/common/model/conversation.dart';
import 'package:flutter_taobao/common/model/shopping_cart.dart';
import 'package:flutter_taobao/common/services/search.dart';
import 'package:flutter_taobao/common/style/gzx_style.dart';
import 'package:flutter_taobao/common/utils/common_utils.dart';
import 'package:flutter_taobao/common/utils/navigator_utils.dart';
import 'package:flutter_taobao/common/utils/screen_util.dart';
import 'package:flutter_taobao/ui/widget/UserIconWidget.dart';
import 'package:flutter_taobao/ui/widget/gzx_checkbox.dart';
import 'package:flutter_taobao/ui/widget/pull_load/ListState.dart';
import 'package:flutter_taobao/ui/widget/pull_load/PullLoadWidget.dart';
import 'dart:math';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_taobao/ui/widget/shopping_cart_item.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage>
    with AutomaticKeepAliveClientMixin<ShoppingCartPage>, ListState<ShoppingCartPage>, WidgetsBindingObserver {
  static const Color _backgroundColor = Color(0xFFf3f3f3);
  Gradient _mainGradient = const LinearGradient(colors: [_backgroundColor, _backgroundColor]);
  bool _isAllSelected = false;

  GlobalKey _keyFilter = GlobalKey();
  double _firstItemHeight = 0;

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
    print('_MessagePageState.build');
    super.build(context); // 如果不加这句，从子页面回来会重新加载didChangeDependencies()方法
//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
//    final page = ModalRoute.of(context);
//    page.didPush().then((x) {
//      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
//    });

// change the status bar color to material color [green-400]
//    _stat();

    var firstItemWidget= ShoppingCarItemWidget(
        shoppingCartModels[0],
        color: Colors.transparent,
        addTap: (orderModel) {
          if (orderModel.quantity + 1 > orderModel.amountPurchasing) {
            Fluttertoast.showToast(msg: '该宝贝不能购买更多哦', gravity: ToastGravity.CENTER);
          } else {
            setState(() {
              orderModel.quantity++;
            });
          }
        },
        removeTap: (orderModel) {
          if (orderModel.quantity == 1) {
            Fluttertoast.showToast(msg: '受不了了，宝贝不能再减少了哦', gravity: ToastGravity.CENTER);
          } else {
            setState(() {
              orderModel.quantity--;
            });
          }
        },
        onSelectAllChanged: (value) {
          setState(() {
            shoppingCartModels[0].isSelected = value;
            shoppingCartModels[0].orderModels.forEach((item) {
              item.isSelected = value;
            });
          });
        },
        onSelectChanged: (orderModel, value) {
          setState(() {
            orderModel.isSelected = value;
//                shoppingCartModel.isSelected=value;
          });
        },
    );

    var testWidget=Container(
      color: Colors.red,
      key: _keyFilter,
//      height: _firstItemHeight + 50,
      child:firstItemWidget);

    var pullLoadWidget = PullLoadWidget(
      pullLoadWidgetControl,
      (BuildContext context, int index) {
        ShoppingCartModel shoppingCartModel = pullLoadWidgetControl.dataList[index];
        print('$index');

        if (index == 0) {
//          return Container(color: Colors.red,height: 50,);
//          return Stack(
//            children: <Widget>[
//              TopItem(
//                topBarOpacity: _topBarOpacity,
//              ),
//              Positioned(
//                top: 80,
//                  child: Container(
//                    color: Colors.red,
//                width: double.infinity,
//                height: 500,
//              ))
//            ],
//          );
          return Container(
            color: _backgroundColor,
//          color: Colors.red,
            height: _firstItemHeight + 48 + ScreenUtil.statusBarHeight+20 ,
            child: TopItem(
                topBarOpacity: _topBarOpacity,
                contentWidgetHeight: _firstItemHeight,
//contentWidget: Container(height: 44,color: Colors.white,width: 100,),
                contentWidget: Container(
//              color: _backgroundColor,
//              key: _keyFilter,
//              height: _firstItemHeight + 50,
              child:ShoppingCarItemWidget(
                shoppingCartModels[0],
                color: Colors.transparent,
                addTap: (orderModel) {
                  if (orderModel.quantity + 1 > orderModel.amountPurchasing) {
                    Fluttertoast.showToast(msg: '该宝贝不能购买更多哦', gravity: ToastGravity.CENTER);
                  } else {
                    setState(() {
                      orderModel.quantity++;
                    });
                  }
                },
                removeTap: (orderModel) {
                  if (orderModel.quantity == 1) {
                    Fluttertoast.showToast(msg: '受不了了，宝贝不能再减少了哦', gravity: ToastGravity.CENTER);
                  } else {
                    setState(() {
                      orderModel.quantity--;
                    });
                  }
                },
                onSelectAllChanged: (value) {
                  setState(() {
                    shoppingCartModels[0].isSelected = value;
                    shoppingCartModels[0].orderModels.forEach((item) {
                      item.isSelected = value;
                    });
                  });
                },
                onSelectChanged: (orderModel, value) {
                  setState(() {
                    orderModel.isSelected = value;
//                shoppingCartModel.isSelected=value;
                  });
                },
              )))
          );
        } else {
          return ShoppingCarItemWidget(
            shoppingCartModel,
            addTap: (orderModel) {
              if (orderModel.quantity + 1 > orderModel.amountPurchasing) {
                Fluttertoast.showToast(msg: '该宝贝不能购买更多哦', gravity: ToastGravity.CENTER);
              } else {
                setState(() {
                  orderModel.quantity++;
                });
              }
            },
            removeTap: (orderModel) {
              if (orderModel.quantity == 1) {
                Fluttertoast.showToast(msg: '受不了了，宝贝不能再减少了哦', gravity: ToastGravity.CENTER);
              } else {
                setState(() {
                  orderModel.quantity--;
                });
              }
            },
            onSelectAllChanged: (value) {
              setState(() {
                shoppingCartModel.isSelected = value;
                shoppingCartModel.orderModels.forEach((item) {
                  item.isSelected = value;
                });
              });
            },
            onSelectChanged: (orderModel, value) {
              setState(() {
                orderModel.isSelected = value;
//                shoppingCartModel.isSelected=value;
              });
            },
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

//    var selectedOrderModels =
//        shoppingCartModels.map((item) => item.orderModels.where((i) => i.isSelected).）.toList();
//    var totalAmount = selectedOrderModels.reduce((prev, i) => prev + i);
    double totalAmount = 0;
    int settlementCount = 0;
    for (var value1 in shoppingCartModels) {
      for (var value in value1.orderModels) {
        if (value.isSelected) {
          totalAmount += value.price * value.quantity;
          settlementCount++;
        }
      }
    }

    return SafeArea(
      child: Column(
        children: <Widget>[
          Offstage(
            child: testWidget,
            offstage: true,
          ),
          Expanded(
            child: body,
          ),
          Container(
            height: 44,
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFededed), width: .3)),
            ),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: GZXCheckbox(
                    value: _isAllSelected,
                    onChanged: (value) {
                      setState(() {
                        _isAllSelected = value;
                        shoppingCartModels.forEach((item) {
                          item.isSelected = value;
                          item.orderModels.forEach((i) {
                            i.isSelected = value;
                          });
                        });
                      });
                    },
                    spacing: 6,
                    descriptionWidget: Text(
                      '全选',
                      style: TextStyle(color: Color(0xFF666666), fontSize: 12),
                    ),
                  ),
                ),
                totalAmount == 0
                    ? Container()
                    : Text(
                        '已包邮',
                        style: TextStyle(color: Color(0xFF666666), fontSize: 9),
                      ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  '合计:',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  '￥',
                  style: TextStyle(fontSize: 10, color: Color(0xFFff5410)),
                ),
                Text(
                  '${CommonUtils.removeDecimalZeroFormat(totalAmount)}',
                  style: TextStyle(fontSize: 14, color: Color(0xFFff5410)),
                ),
                SizedBox(
                  width: 8,
                ),
                Container(
                  height: 36,
                  width: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: GZXColors.primaryGradient,
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                  ),
                  child: Text(
                    '结算($settlementCount)',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
              ],
            ),
          )
        ],
      ),
      top: false,
    );
  }

  Widget _buildFloatingTopBar({int productNum = 0}) {
    var list = shoppingCartModels.map((item) => item.orderModels.length).toList();
    var count = list.reduce((value, element) {
      print('reduce $value  $element}');
      return value + element;
    });
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
                '管理',
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
            count == 0 ? '购物车' : '购物车(${count})',
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
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);

    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);

    WidgetsBinding.instance.addObserver(this);

    pullLoadWidgetControl.dataList = shoppingCartModels;
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
        pullLoadWidgetControl.dataList = shoppingCartModels;
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
  final double contentWidgetHeight;
  double _topBarHeight = 48;

  TopItem(
      {Key key,
      this.isShowFloatingTopBar = false,
      this.topBarOpacity = 1,
      this.productNum = 0,
      this.contentWidget,
      this.contentWidgetHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  '共${productNum}件宝贝',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                SizedBox(
                  width: 10,
                ),
//                  CircleAvatar(
//                    radius: 10,
//                    backgroundColor: Color(0xFFfea54e),
//                    child: GestureDetector(
//                      child: Icon(
//                        GZXIcons.clear,
//                        color: Colors.white,
//                        size: 12,
//                      ),
//                    ),
//                  ),
              ],
            ),
          )),

//Container(height: 367,child: contentWidget,)
      Positioned(
          top: _topBarHeight + ScreenUtil.statusBarHeight + 30,
          height: contentWidgetHeight,
          width: ScreenUtil.screenWidth,
          child: contentWidget)
    ]));
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
            '购物车',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        GestureDetector(
            onTap: () {
//            Fluttertoast.showToast(msg: '受不了了，宝贝不能再减少了哦');
            },
            child: Text(
              '管理',
              style: TextStyle(
                color: Colors.white,
              ),
            )),
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
    Widget userImage = new UserIconWidget(
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
