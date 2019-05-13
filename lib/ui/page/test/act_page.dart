import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_taobao/common/data/home.dart';
import 'package:flutter_taobao/common/model/kingkong.dart';
import 'package:flutter_taobao/common/utils/log_util.dart';
import 'package:flutter_taobao/common/utils/screen_util.dart';
import 'package:flutter_taobao/ui/page/home/searchlist_page.dart';
import 'package:flutter_taobao/ui/tools/arc_clipper.dart';
import 'package:flutter_taobao/ui/widget/menue.dart';
import 'package:flutter_taobao/ui/widget/topbar.dart';

class ActPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ActState();
  }
}

class ActState extends State<ActPage> with SingleTickerProviderStateMixin {
  List<Choice> tabs = [];
  TabController mTabController;
  int mCurrentPosition = 0;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 360)..init(context);

    return new Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            new SliverAppBar(
              snap: false,
              floating: false,
              pinned: true,
              expandedHeight: 320.0,
              bottom: PreferredSize(
                  child: new Container(
                    color: Colors.white,
                    child: new TabBar(
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Colors.green,
                      labelColor: Colors.green,
                      unselectedLabelColor: Colors.black45,
                      tabs: tabs.map((Choice choice) {
                        return new Tab(
                          text: choice.title,
                          icon: new Icon(
                            choice.icon,
                          ),
                        );
                      }).toList(),
                      controller: mTabController,
                    ),
                  ),
                  preferredSize: new Size(double.infinity, 18.0)),
              flexibleSpace: new Container(
                child: new Column(
                  children: <Widget>[
                    HomeTopBar(
                      searchHintTexts: searchHintTexts,
                    ),
                    Expanded(
                      child: _buildBody(),
                    ),
//                    new Expanded(
//                      child: new Container(
////                    child: Image.asset(
////                      "images/temp2.jpg",
////                      fit: BoxFit.cover,
////                    ),
//                        child: Image.network(
//                          'https://upload-images.jianshu.io/upload_images/15405197-28e34374b8812965.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp',
//                          fit: BoxFit.cover,
//                        ),
////                        width: double.infinity,
//                      ),
//                    )
                  ],
                ),
              ),
            )
          ];
        },
        body: new TabBarView(
          children: tabs.map((Choice choice) {
            return SearchResultListPage('iphone');
//            return new Padding(
//                padding: const EdgeInsets.all(15.0),
//                child: choice.position == 0
//                    ? new Container(
//                        child: new ListView(
//                        children: <Widget>[
//                          new ListTile(
//                            leading: new Icon(Icons.map),
//                            title: new Text('Map'),
//                          ),
//                          new ListTile(
//                            leading: new Icon(Icons.photo),
//                            title: new Text('Album'),
//                          ),
//                          new ListTile(
//                            leading: new Icon(Icons.phone),
//                            title: new Text('Phone'),
//                          ),
//                          new ListTile(
//                            leading: new Icon(Icons.map),
//                            title: new Text('Map'),
//                          ),
//                          new ListTile(
//                            leading: new Icon(Icons.photo),
//                            title: new Text('Album'),
//                          ),
//                          new ListTile(
//                            leading: new Icon(Icons.phone),
//                            title: new Text('Phone'),
//                          ),
//                        ],
//                      ))
//                    : new Container(
//                        child: new Text("ahhhhhhhhhhhhh"),
//                      ));
          }).toList(),
          controller: mTabController,
        ),
      ),
    );
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
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: Row(
                        children: searchHintTexts.map((String item) {
                          return Container(
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
                                    style: TextStyle(color: Colors.white, fontSize: 10),
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
              height: 180.0,
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
          ]),
    );
  }

  List<KingKongItem> kingKongItems;


  @override
  void initState() {
    super.initState();

    kingKongItems = KingKongList.fromJson(menueDataJson['items']).items;

    tabs.add(Choice(title: '热门', icon: Icons.hot_tub, position: 0));
    tabs.add(Choice(title: '最新', icon: Icons.fiber_new, position: 1));
    mTabController = new TabController(vsync: this, length: tabs.length);
    //判断TabBar是否切换
    mTabController.addListener(() {
      if (mTabController.indexIsChanging) {
        setState(() {
          mCurrentPosition = mTabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    mTabController.dispose();
  }
}

class Choice {
  const Choice({this.title, this.icon, this.position});

  final String title;
  final int position;
  final IconData icon;
}
