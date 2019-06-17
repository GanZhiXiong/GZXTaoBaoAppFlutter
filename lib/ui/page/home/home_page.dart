import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_taobao/common/dao/app_dao.dart';
import 'package:flutter_taobao/common/data/home.dart';
import 'package:flutter_taobao/common/model/kingkong.dart';
import 'package:flutter_taobao/common/model/product.dart';
import 'package:flutter_taobao/common/model/tab.dart';
import 'package:flutter_taobao/common/services/search.dart';
import 'package:flutter_taobao/common/style/gzx_style.dart';
import 'package:flutter_taobao/common/utils/log_util.dart';
import 'package:flutter_taobao/common/utils/navigator_utils.dart';
import 'package:flutter_taobao/common/utils/screen_util.dart';
import 'package:flutter_taobao/ui/page/home/searchlist_page.dart';
import 'package:flutter_taobao/ui/tools/arc_clipper.dart';
import 'package:flutter_taobao/ui/widget/animation_headlines.dart';
import 'package:flutter_taobao/ui/widget/menue.dart';
import 'package:flutter_taobao/ui/widget/recommed.dart';
import 'package:flutter_taobao/ui/widget/gzx_tabbar.dart';
import 'package:flutter_taobao/ui/widget/gzx_topbar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Image.asset(
          'static/images/618.png',
          width: 300.0,
          fit: BoxFit.contain,
        ),
        Image.asset(
          'static/images/card.png',
          width: 300.0,
          fit: BoxFit.contain,
        ),
      ],
    ));
  }
}

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 250.0,
      itemBuilder: (context, index) => Container(
            padding: EdgeInsets.all(10.0),
            child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(5.0),
              color: index % 2 == 0 ? Colors.cyan : Colors.deepOrange,
              child: Center(
                child: Text(index.toString()),
              ),
            ),
          ),
    );
  }
}

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

  Size _sizeRed;

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

  ScrollController _scrollController = ScrollController();
  ScrollController _scrollViewController;
  GlobalKey _keyFilter = GlobalKey();

  void initData() async {
    List querys = await getHotSugs();
    setState(() {
      _hotWords = querys;
    });
  }

  _afterLayout(_) {
    _getPositions('_keyFilter', _keyFilter);
    _getSizes('_keyFilter', _keyFilter);

//    _getPositions('_keyDropDownItem', _keyDropDownItem);
//    _getSizes('_keyDropDownItem', _keyDropDownItem);
  }

  _getPositions(log, GlobalKey globalKey) {
    RenderBox renderBoxRed = globalKey.currentContext.findRenderObject();
    var positionRed = renderBoxRed.localToGlobal(Offset.zero);
    print("POSITION of $log: $positionRed ");
  }

  _getSizes(log, GlobalKey globalKey) {
    RenderBox renderBoxRed = globalKey.currentContext.findRenderObject();
    _sizeRed = renderBoxRed.size;
    setState(() {});
    print("SIZE of $log: $_sizeRed");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);

    AppDao.getNewsVersion(context, false);

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

    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;

    _scrollViewController.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var v = Column(
      children: <Widget>[
        _buildHotSearchWidget(),
        _buildSwiperImageWidget(),
        _buildSwiperButtonWidget(),
        _buildRecommendedCard(),
        _buildAdvertisingWidget(),
      ],
    );

    var body = NestedScrollView(
      controller: _scrollViewController,
      headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            forceElevated: boxIsScrolled,
            backgroundColor: GZXColors.mainBackgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Column(
//                  key: _keyFilter,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[v],
              ),
            ),
            expandedHeight: (_sizeRed == null ? ScreenUtil.screenHeight : _sizeRed.height) + 50.0,
            bottom: PreferredSize(
              preferredSize: Size(double.infinity, 46),
              child: GZXTabBarWidget(
                tabController: _controller,
                tabModels: _tabModels,
                currentIndex: _currentIndex,
              ),
            ),
          )
        ];
      },
      body: _hotWords.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : TabBarView(controller: _controller, children: _searchResultListPages()),
    );
    return Scaffold(
        backgroundColor: GZXColors.mainBackgroundColor,
        appBar: PreferredSize(
            child: AppBar(
              brightness: Brightness.dark,
              elevation: 0,
            ),
            preferredSize: Size.fromHeight(0)),
        body: Column(
          children: <Widget>[
            Offstage(
              offstage: true,
              child: Container(
                child: v,
                key: _keyFilter,
              ),
            ),
            GZXTopBar(
              searchHintTexts: searchHintTexts,
            ),
            Expanded(child: body),
          ],
        ));
  }

  Widget _buildHotSearchWidget() {
    return Container(
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
    );
  }

  Widget _buildSwiperImageWidget() {
    return Container(
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
          return GestureDetector(
            onTap: () {
//              _scrollController.jumpTo(_scrollController.offset +50);
            },
            child: Container(
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
                          fadeOutDuration: const Duration(milliseconds: 300),
                          fadeInDuration: const Duration(milliseconds: 700),
                          fit: BoxFit.fill,
                          imageUrl: banner_images[index],
//                              placeholder: (context, url) => new CircularProgressIndicator(),
                          errorWidget: (context, url, error) => new Icon(Icons.error),
                        ),
                      )
                    ]))),
          );
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
    );
  }

  Widget _buildSwiperButtonWidget() {
    return Container(
//      height: 175,
      height: ScreenUtil().L(80) * 2 + 15,
//      color: Colors.red,
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
    );
  }

  Widget _buildAdvertisingWidget() {
    return Container(
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
          child: Image.asset(
            'static/images/618.png',
            fit: BoxFit.fill,
          ),
        ),
        constraints: new BoxConstraints.expand(),
      ),
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
      var page = SearchResultListPage(
        _hotWords[i],
        onNotification: _onScroll,
        isList: false,
        isRecommended: true,
      );
      pages.add(page);
    }
    return pages;
  }

  double _lastScrollPixels = 0;

  bool _onScroll(ScrollNotification scroll) {
    return false;
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
                Container(width: ScreenUtil.screenWidth, height: 0.7, color: GZXColors.mainBackgroundColor),
                AnimationHeadlinesWidget(),
              ],
            )),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
