import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_taobao/common/data/home.dart';
import 'package:flutter_taobao/common/model/kingkong.dart';
import 'package:flutter_taobao/common/model/product.dart';
import 'package:flutter_taobao/common/model/tab.dart';
import 'package:flutter_taobao/common/services/search.dart';
import 'package:flutter_taobao/common/style/gzx_style.dart';
import 'package:flutter_taobao/common/utils/log_util.dart';
import 'package:flutter_taobao/common/utils/navigator_utils.dart';
import 'package:flutter_taobao/common/utils/screen_util.dart';
import 'package:flutter_taobao/common/utils/common_utils.dart';
import 'package:flutter_taobao/ui/page/home/products_page.dart';
import 'package:flutter_taobao/ui/page/home/searchlist_page.dart';
import 'package:flutter_taobao/ui/tools/arc_clipper.dart';
import 'package:flutter_taobao/ui/widget/animation/diff_scale_text.dart';
import 'package:flutter_taobao/ui/widget/animation_headlines.dart';
import 'package:flutter_taobao/ui/widget/item_tag.dart';
import 'package:flutter_taobao/ui/widget/menue.dart';
import 'package:flutter_taobao/ui/widget/recommed.dart';
import 'package:flutter_taobao/ui/widget/tabbar.dart';
import 'package:flutter_taobao/ui/widget/topbar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<HomePage> {
  List<KingKongItem> kingKongItems;

  int _diffScaleNext = 0;

  List<TabModel> _tabModels = [];

  List _hotWords = [];

  AnimationController _animationController;

  TabController _controller;
  int _currentIndex = 0;

  Timer _countdownTimer;

  String get hoursString {
    Duration duration = _animationController.duration * _animationController.value;
    return '${(duration.inHours)..toString().padLeft(2, '0')}';
  }

  String get minutesString {
    Duration duration = _animationController.duration * _animationController.value;
    return '${(duration.inMinutes % 60).toString().padLeft(2, '0')}';
  }

  String get secondsString {
    Duration duration = _animationController.duration * _animationController.value;
    return '${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void initData() async {
    List querys = await getHotSugs();
    setState(() {
      _hotWords = querys;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    kingKongItems = KingKongList.fromJson(menueDataJson['items']).items;

    _tabModels.add(TabModel(title: '全部', subtitle: '猜你喜欢'));
    _tabModels.add(TabModel(title: '直播', subtitle: '网红推荐'));
    _tabModels.add(TabModel(title: '便宜好货', subtitle: '低价抢购'));
    _tabModels.add(TabModel(title: '买家秀', subtitle: '购后分享'));
    _tabModels.add(TabModel(title: '全球', subtitle: '进口好货'));
    _tabModels.add(TabModel(title: '生活', subtitle: '享受生活'));
    _tabModels.add(TabModel(title: '母婴', subtitle: '母婴大赏'));
    _tabModels.add(TabModel(title: '时尚', subtitle: '时尚好货'));

    //倒计时
    _animationController = AnimationController(vsync: this, duration: Duration(hours: 10, minutes: 30, seconds: 0));
    _animationController.reverse(from: _animationController.value == 0.0 ? 1.0 : _animationController.value);

    initData();

    _controller = TabController(vsync: this, length: 8);
    _controller.addListener(_handleTabSelection);

//    _countdownTimer = new Timer.periodic(new Duration(seconds: 3), (timer) {
////      print('countdownTimer.tick');
//      setState(() {
//        _diffScaleNext++;
//      });
//    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('_HomePageState.build');
    //test
    {
      int i = 21;
      int j = (i / 10).toInt() + (i % 10 > 0 ? 1 : 0);
//    print(j);
      String str = '12.54500';
      double d = double.parse(str);
      print(d);
      print(d.round());
      print(d.truncateToDouble());
      print(CommonUtils.removeDecimalZeroFormat(d));
    }

    return new Scaffold(
      backgroundColor: GZXColors.mainBackgroundColor,
      appBar: PreferredSize(
          child: AppBar(
            brightness: Brightness.dark,
            elevation: 0,
          ),
          preferredSize: Size.fromHeight(0)),
      body: Column(
        children: <Widget>[
          HomeTopBar(
            searchHintTexts: searchHintTexts,
          ),
          Expanded(
            child: _buildBody(),
          ),
        ],
      ),
//    body:   DefaultTabController(
//        length: 8,
//        initialIndex: 0,
//        child: Column(children: <Widget>[
//          KTabBarWidget(
//            tabModels: _tabModels,
//          ),
//          Expanded(child: TabBarView(children: <Widget>[ProductPage()])),
//        ])),
    );
  }

  List<Widget> _builderTag(List<dynamic> tags) {
    List<Widget> widgets = [];

    for (int i = 0; i < tags.length; i++) {
      widgets.add(ItemTag(tag: '' + tags[i].toString()));
    }

    return widgets;
  }

  Widget _buildBody() {
    return NotificationListener<ScrollNotification>(
//      onNotification: _onScroll,
      child: ListView(
//          primary: false,
//          shrinkWrap: true,
          padding: EdgeInsets.all(0),
          children: <Widget>[
//          Wrap(children: _builderTag(_searchHintTexts), spacing: 10.0),
            Container(
              color: Theme.of(context).primaryColor,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '热搜：',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: Row(
                        children: searchHintTexts.map((String item) {
                          return GestureDetector(
                            onTap: () {
                              NavigatorUtils.gotoSearchGoodsResultPage(context, item);
                            },
                            child: Container(
                              margin: EdgeInsets.all(4),
                              height: 20,
                              child: new Material(
                                borderRadius: BorderRadius.circular(10.0),
//              shadowColor: Colo rs.blue.shade200,
//              elevation: 5.0,
                                color: Color(0xFFfe8524),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8, right: 8),
                                  child: Center(
                                    child: Text(
                                      item,
                                      style: TextStyle(color: Colors.white, fontSize: 13),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
//            return Text(item);
//            return _KingKongItemWidget(
//              item: item,
//            );
                        }).toList(),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 150.0,
              child: Swiper(
                /// 初始的时候下标位置
                index: 0,

                /// 无限轮播模式开关
                loop: true,

                ///
                itemBuilder: (context, index) {
//                return Image.network(
//                  _banner_images[index],
//                  fit: BoxFit.fill,
//                );
                  return Container(
                      height: 150,
//        width: 200,
//                    color: Colors.white,
                      child: ClipPath(
                          clipper: new ArcClipper(),
                          child: Stack(children: <Widget>[
                            Container(
                              height: 150,
//                  width: double.infinity,
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl: banner_images[index],
//                              placeholder: (context, url) => new CircularProgressIndicator(),
                                errorWidget: (context, url, error) => new Icon(Icons.error),
                              ),
                            )
                          ])));
                },

                ///
                itemCount: banner_images.length,

                /// 设置 new SwiperPagination() 展示默认分页指示器
                pagination: SwiperPagination(),

                /// 设置 new SwiperControl() 展示默认分页按钮
                // control: SwiperControl(),

                /// 自动播放开关.
                autoplay: true,

                /// 动画时间，单位是毫秒
                duration: 300,

                /// 当用户点击某个轮播的时候调用
                onTap: (index) {
                  LogUtil.v("你点击了第$index个");
                },

                /// 滚动方向，设置为Axis.vertical如果需要垂直滚动
                scrollDirection: Axis.horizontal,
              ),
            ),
//          HomeKingKongWidget(
//            data: KingKongList.fromJson(menueDataJson['items']),
//            fontColor: (menueDataJson['config'] as dynamic)['color'],
//            bgurl: (menueDataJson['config'] as dynamic)['pic_url'],
//          ),
            Container(
              height: 200.0,
              child: Swiper(
                /// 初始的时候下标位置
                index: 0,

                /// 无限轮播模式开关
                loop: true,

                ///
                itemBuilder: (context, index) {
                  List data = [];
                  for (var i = (index * 2) * 5; i < (index * 2) * 5 + 5; ++i) {
                    //0-4,5-9,10-14,15-19
                    if (i >= kingKongItems.length) {
                      break;
                    }
                    data.add(kingKongItems[i]);
                  }
                  List data1 = [];
                  for (var i = (index * 2 + 1) * 5; i < (index * 2 + 1) * 5 + 5; ++i) {
                    //0-4,5-9,10-14,15-19
                    if (i >= kingKongItems.length) {
                      break;
                    }
                    data1.add(kingKongItems[i]);
                  }

                  return Column(
                    children: <Widget>[
                      HomeKingKongWidget(
                        data: data,
                        fontColor: (menueDataJson['config'] as dynamic)['color'],
                        bgurl: (menueDataJson['config'] as dynamic)['pic_url'],
                      ),
                      HomeKingKongWidget(
                        data: data1,
                        fontColor: (menueDataJson['config'] as dynamic)['color'],
                        bgurl: (menueDataJson['config'] as dynamic)['pic_url'],
                      ),
                    ],
                  );
                },

                ///
                itemCount: (kingKongItems.length / 10).toInt() + (kingKongItems.length % 10 > 0 ? 1 : 0),

                /// 设置 new SwiperPagination() 展示默认分页指示器
                pagination: new SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: RectSwiperPaginationBuilder(
                        color: Color(0xFFd3d7de),
                        activeColor: Theme.of(context).primaryColor,
                        size: Size(18, 3),
                        activeSize: Size(18, 3),
                        space: 0)),

                /// 设置 new SwiperControl() 展示默认分页按钮
                // control: SwiperControl(),

                /// 自动播放开关.
                autoplay: false,

                /// 动画时间，单位是毫秒
                duration: 300,

                /// 当用户点击某个轮播的时候调用
                onTap: (index) {
                  LogUtil.v("你点击了第$index个");
                },

                /// 滚动方向，设置为Axis.vertical如果需要垂直滚动
                scrollDirection: Axis.horizontal,
              ),
            ),
            _buildRecommendedCard(),

//            Padding(
//              padding: EdgeInsets.only(left: 8, top: 0, right: 8, bottom: 8),
//              child: ClipRRect(
//                borderRadius: BorderRadius.circular(16),
//                child: CachedNetworkImage(
//                  imageUrl:
//                      'https://img.alicdn.com/imgextra/i4/1637289231/O1CN01emxYFy2I3qba9sBZg_!!1637289231.jpg_1080x1800Q90s50.jpg',
//                  height: 44,
//width: ScreenUtil.screenWidth,
//                ),
//              ),
//            ),
            Container(
              margin: EdgeInsets.only(left: 8, top: 0, right: 8, bottom: 10),
              height: 80,
              child: ConstrainedBox(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
//                    child: CachedNetworkImage(
//                      imageUrl:
//                          'https://m.360buyimg.com/babel/s710x160_jfs/t1/49162/37/1059/38027/5cebd68eEf50ad170/5470b2bde7ae3823.png',
////                  height: 44,
//                      fit: BoxFit.fill,
//                    )
                child: Image.asset('static/images/618.png',fit: BoxFit.fill,),
                ),
                constraints: new BoxConstraints.expand(),
              ),
            ),

//Expanded(child: Container(color: Colors.red,))
//            Flexible(
//              child: DefaultTabController(
//                  length: 8,
//                  initialIndex: 0,
//                  child: Column(children: <Widget>[
//                    KTabBarWidget(
//                      tabController: _controller,
//                      tabModels: _tabModels,
//                      currentIndex: _currentIndex,
//                    ),
//                    Expanded(
////                    child: TabBarView(children: <Widget>[
////                      SearchResultListPage('iphone'),
////                      SearchResultListPage('iphone'),
////                      SearchResultListPage('iphone'),
////                      SearchResultListPage('iphone'),
////                      SearchResultListPage('iphone'),
////                    ])
//                        child: _hotWords.length == 0
//                            ? Center(
//                                child: CircularProgressIndicator(),
//                              )
//                            : TabBarView(controller: _controller, children: _searchResultListPages())),
//                  ])),
//            )
            Container(
//              width: ScreenUtil.screenWidth,
              width: double.infinity,
              height: ScreenUtil.screenHeight - ScreenUtil.statusBarHeight - 38 - 58,
              child: DefaultTabController(
                  length: 8,
                  initialIndex: 0,
                  child: Column(children: <Widget>[
                    KTabBarWidget(
                      tabController: _controller,
                      tabModels: _tabModels,
                      currentIndex: _currentIndex,
                    ),
                    Expanded(
//                    child: TabBarView(children: <Widget>[
//                      SearchResultListPage('iphone'),
//                      SearchResultListPage('iphone'),
//                      SearchResultListPage('iphone'),
//                      SearchResultListPage('iphone'),
//                      SearchResultListPage('iphone'),
//                    ])
                        child: _hotWords.length == 0
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : TabBarView(controller: _controller, children: _searchResultListPages())),
                  ])),
            )
          ]),
    );
  }

  _handleTabSelection() {
//    if (!_controller.indexIsChanging) {
//      return;
//    }
    print('_handleTabSelection:${_controller.index}');
//return;
    setState(() {
      _currentIndex = _controller.index;
    });
  }

  List<Widget> _searchResultListPages() {
    List<Widget> pages = [];
    for (var i = 0; i < 8; ++i) {
      var page = SearchResultListPage(_hotWords[i]);
      pages.add(page);
    }
    return pages;
  }

  Widget _buildRecommendedCard() {
    Positioned unReadMsgCountText = Positioned(
      child: Container(
//        width: 10.0,
//        height: 10.0,
//        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20 / 2.0), color: Color(0xffff3e3e)),
        child: AnimatedBuilder(
            animation: _animationController,
            builder: (_, Widget child) {
              return Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: Container(
                      color: Colors.red,
                      child: Text(
                        hoursString,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: Container(
                      color: Colors.red,
                      child: Text(
                        minutesString,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: Container(
                      color: Colors.red,
                      child: Text(
                        secondsString,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
      left: 55,
      top: 10,
    );

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Card(
//          elevation: 20.0,
        //设置shape，这里设置成了R角
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        //对Widget截取的行为，比如这里 Clip.antiAlias 指抗锯齿
        clipBehavior: Clip.antiAlias,
        child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Column(
              children: <Widget>[
                Stack(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RecommendFloor(ProductListModel.fromJson(recommendJson)),
                    unReadMsgCountText,
                  ],
                ),
//            Expanded(child: ,),
//        Container(
////          width: 20,
//          height: 1,
//          color: Colors.red,
//          constraints: BoxConstraints.expand(),
//        ),
//                Expanded(
//                  child: ConstrainedBox(
//                    child: Container(
//          width: 20,
//                        height: 1,
//                        color: Colors.red),
//                    constraints: new BoxConstraints.expand(),
//                  ),
//                ),
                Container(width: ScreenUtil.screenWidth, height: 0.7, color: GZXColors.mainBackgroundColor),

                AnimationHeadlinesWidget(),
//                      child: DiffScaleText(
//                        text: _headlines[_diffScaleNext % _headlines.length],
//                        textStyle: TextStyle(
//                          fontSize: 12,
////                          color: Colors.blue,
//                            color: Colors.black),
//                      ),
//                    )),
//                  ],
//                )
              ],
            )),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
