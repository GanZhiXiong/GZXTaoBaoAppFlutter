import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_taobao/common/model/image.dart';
import 'package:flutter_taobao/common/model/post.dart';
import 'package:flutter_taobao/common/model/search.dart';
import 'package:flutter_taobao/common/services/meinv.dart';
import 'package:flutter_taobao/common/services/search.dart';
import 'package:flutter_taobao/common/style/gzx_style.dart';
import 'package:flutter_taobao/common/utils/common_utils.dart';
import 'package:flutter_taobao/common/utils/screen_util.dart';
import 'package:flutter_taobao/ui/page/home/search_suggest_page.dart';
import 'package:flutter_taobao/ui/page/weitao/weitao_list_page.dart';

class WeiTaoPage extends StatefulWidget {
  @override
  _WeiTaoPageState createState() => _WeiTaoPageState();
}

class _WeiTaoPageState extends State<WeiTaoPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<WeiTaoPage> {
  List<PostModel> _postModels = [];

  //column1
  Widget profileColumn(BuildContext context, PostModel post) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(post.logoImage),
          ),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      post.name,
//                  style: Theme.of(context).textTheme.body1.apply(fontWeightDelta: 100),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      post.postTime,
                      style: Theme
                          .of(context)
                          .textTheme
                          .caption
                          .apply(color: Colors.grey),
                    )
                  ],
                ),
              ))
        ],
      );

  //column last
//  Widget actionColumn(Post post) => FittedBox(
//    fit: BoxFit.contain,
//    child: ButtonBar(
//      alignment: MainAxisAlignment.center,
//      children: <Widget>[
//        LabelIcon(
//          label: "${post.likesCount} Likes",
//          icon: FontAwesomeIcons.solidThumbsUp,
//          iconColor: Colors.green,
//        ),
//        LabelIcon(
//          label: "${post.commentsCount} Comments",
//          icon: FontAwesomeIcons.comment,
//          iconColor: Colors.blue,
//        ),
//        Text(
//          post.postTime,
//          style: TextStyle(fontFamily: UIData.ralewayFont),
//        )
//      ],
//    ),
//  );

  Widget actionColumn(PostModel post) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Text(
              '${post.readCout}万阅读',
              style: TextStyle(
                color: Colors.grey,
              ),
            )),
        GestureDetector(
          onTap: () {
            setState(() {
              post.isLike = !post.isLike;
              if (post.isLike) {
                post.likesCount++;
              } else {
                post.likesCount--;
              }
            });
          },
          child: Row(
            children: <Widget>[
              Icon(
                post.isLike ? GZXIcons.appreciate_fill_light : GZXIcons.appreciate_light,
                color: post.isLike ? Colors.red : Colors.black,
              ),
              Text(
                post.likesCount.toString(),
                style: TextStyle(color: post.isLike ? Colors.red : Colors.black),
              )
            ],
          ),
        ),
        SizedBox(
          width: 25,
        ),
        GestureDetector(
          onTap: () {
//            post.isLike=!post.isLike;
//            if(post.isLike){
//              post.likesCount++;
//            }else{
//              post.likesCount--;
//            }
          },
          child: Row(
            children: <Widget>[
              Icon(
                GZXIcons.message,
                color: Colors.black,
              ),
              Text(
                post.commentsCount.toString(),
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildPhotosWidget(PostModel post) {
    return GridView.count(
      padding: const EdgeInsets.all(0),
      primary: false,
//      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      crossAxisSpacing: 6,
      mainAxisSpacing: 6,
      crossAxisCount: 3,
      children: post.photos.map((item) {
//        int index = post.photos.indexOf(item);
//        print(index);
//        return Image.network(item, fit: BoxFit.fill,);
        return CachedNetworkImage(
//          color: Colors.blue,
          imageUrl: item,
//        imageUrl: 'https://res.vmallres.com/pimages//product/6901443293742/group//428_428_1555465554342.png' ,
          fit: BoxFit.fill,
        );
      }).toList(),
    );
  }

  //post cards
  Widget postCard(BuildContext context, PostModel post) {
    return Card(
//      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 0),
            child: profileColumn(context, post),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 0),
            child: Text(
              post.message,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
//          SizedBox(
//            height: 10.0,
//          ),
//          Expanded(child: _buildPhotosWidget(post),),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 0),
            child: Stack(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
//                    color: Colors.red,
                    ),
//            padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
//              color: Colors.red,
//                  child: _buildPhotosWidget(post),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: _buildPhotosWidget(post),
                    )),
//                Positioned(
//                    top: 0,
//                    left: 0,
//                    height: 100,
//                    width: 100,
//                    child: Container(
//                      decoration: BoxDecoration(
//                        borderRadius: BorderRadius.all(Radius.circular(16)),
//                        color: Colors.transparent,
//                      ),
////            padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
////              color: Colors.red,
////                child: _buildPhotosWidget(post),
//                    ))
              ],
            ),
          ),
//        Container(height: 400,width: 400,color: Colors.red, child: _buildPhotosWidget(post),),

//          post.messageImage != null
//              ? Image.network(
//                  post.messageImage,
//                  fit: BoxFit.cover,
//                )
//              : Container(),
//          post.messageImage != null
//              ? Container()
//              : Divider(
//                  color: Colors.grey.shade300,
//                  height: 8.0,
//                ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: actionColumn(post),
          ),
        ],
      ),
    );
  }

  //allposts dropdown
  Widget bottomBar() =>
      PreferredSize(
          preferredSize: Size(double.infinity, 50.0),
          child: Container(
              color: Colors.black,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 50.0,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "All Posts",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                      Icon(Icons.arrow_drop_down)
                    ],
                  ),
                ),
              )));

  Widget appBar() =>
      SliverAppBar(
        backgroundColor: Colors.black,
        elevation: 2.0,
        centerTitle: false,
        title: Text("Feed"),
        forceElevated: true,
        pinned: true,
        floating: true,
//        snap: false,
        bottom: bottomBar(),
      );

  Widget bodyList(List<PostModel> posts) =>
      SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          print('SliverChildBuilderDelegate ${index}');

          if (index + 3 == posts.length) {
            print('_getDynamic');
            _getDynamic();
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: postCard(context, posts[index]),
          );
        }, childCount: posts.length),
      );

  Widget bodySliverList() {
//    PostBloc postBloc = PostBloc();

    return StreamBuilder<List<PostModel>>(
        stream: postItems,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? CustomScrollView(
            slivers: <Widget>[
//              appBar(),
              bodyList(snapshot.data),
            ],
          )
              : Center(child: CircularProgressIndicator());
        });
  }

  final postController = StreamController<List<PostModel>>();

  Stream<List<PostModel>> get postItems => postController.stream;

  List _imageCounts = [3, 6, 9];
  List _tabsTitle = ['关注', '上新', '新势力', '精选', '晒单', '时尚', '美食', '潮sir', '生活', '明星', '品牌'];
  List _topBackgroundImages = [
    '',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1558082136524&di=feacbe2ef8a99d19665e04c4b72d2842&imgtype=0&src=http%3A%2F%2Fi1.17173cdn.com%2F2fhnvk%2FYWxqaGBf%2Foutcms%2FmCkIBAbjpEyscFv.jpg',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1558083021447&di=b4d0e0cf24df095303532b2156f995bf&imgtype=0&src=http%3A%2F%2Fp3.pstatp.com%2Flarge%2F109000019f50509ab65',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1558083021447&di=d7a90850b12b9fe07a4024be742c9dbc&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201603%2F13%2F20160313134239_5WNxA.png',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1558083412736&di=8fcd16ece63f60c53231e34d7d707564&imgtype=0&src=http%3A%2F%2Fs14.sinaimg.cn%2Fmw690%2F002Y7b5tgy6PyTRlDOZbd%26690',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1558083463426&di=7f4563d244f278746a8b52b712af1c19&imgtype=0&src=http%3A%2F%2Fs6.sinaimg.cn%2Fmiddle%2F97478a17hc9637acee3c5%26690',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1558083503297&di=10680297f182bdaa5c5039a0b8693626&imgtype=0&src=http%3A%2F%2Fs1.sinaimg.cn%2Fmw690%2F001LVQHHty6OK05256E70%26690' ,
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1558083515575&di=d0399c0e4cce6b34e87b1ec2afdcf0e8&imgtype=0&src=http%3A%2F%2Fs6.sinaimg.cn%2Fmw690%2F00330iyazy7cdZAuidD85%26690',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1558073507&di=1e791bf6640d622d8dd26a0f2bba9529&src=http://s16.sinaimg.cn/mw690/4a6e5f25tx6C9p5o4i31f&690',
    'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1611177969,3782045888&fm=26&gp=0.jpg',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1558083648898&di=ce8d7033d1b0ea161fe96ce5ff8b0dac&imgtype=0&src=http%3A%2F%2Fs4.sinaimg.cn%2Fmw600%2F002BHBRBzy6QSpE2Oxlab%26690'
  ];

  static double _topBarDefaultTop = ScreenUtil.statusBarHeight;

  double _topBarHeight = 48;
  double _topBarTop = _topBarDefaultTop;
  static double _tabControllerDefaultTop = ScreenUtil.statusBarHeight + 48;
  double _tabControllerTop = _tabControllerDefaultTop;
  double _tabBarHeight = 48;
  double _topBackgroundHeight = ScreenUtil.screenHeight / 4;
  static double _topBackgroundDefaultTop = 0;
  double _topBackgroundTop = _topBackgroundDefaultTop;
  int _selectedTabBarIndex = 0;
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(vsync: this, length: _tabsTitle.length);
    _tabController.addListener(_handleTabSelection);

    _getDynamic();
  }

  void _getDynamic() async {
    List querys = await getHotSugs();
//    setState(() {
//      _hotWords = querys;
//    });
    for (var value in querys) {
      PostModel postModel = PostModel(
          name: value,
//          personName: _postModels.length.toString(),
          logoImage:
          'https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=2094939883,1219286755&fm=179&app=42&f=PNG?w=121&h=140',
          address: '999万粉丝',
//          message:
//              '  华为P30，是华为公司旗下一款手机。手机搭载海思Kirin 980处理器，屏幕为6.1英寸，分辨率2340*1080像素。 摄像头最大30倍数码变焦。\n  2019年3月26日晚21时，华为P30系列在法国巴黎会议中心发布。2019年4月11日，HUAWEI P30系列在上海东方体育中心正式发布。',
          message: '',
          messageImage:
          'https://gss1.bdstatic.com/9vo3dSag_xI4khGkpoWK1HF6hhy/baike/s%3D220/sign=a70945e5c51349547a1eef66664f92dd/fd039245d688d43f7e426c96731ed21b0ff43bef.jpg',
          readCout: _randomCount(),
          isLike: false,
          likesCount: _randomCount(),
          commentsCount: _randomCount(),
//          postTime: '2019-05-15 22:05:04',
//          postTime: CommonUtils.getDateStr(DateTime.parse('2019-05-15 22:05:04')),
          postTime: '${_randomCount()}粉丝',
          photos: []
//          photos: [
//            'https://res.vmallres.com/pimages/detailImg/2019/04/25/201904251619334564748.jpg',
//            'https://res.vmallres.com/pimages/detailImg/2019/04/25/201904251619332724625.jpg',
//            'https://img.alicdn.com/imgextra/i2/2838892713/O1CN01JEnTCE1Vub3R5VKEf_!!2838892713.jpg_430x430q90.jpg',
//            'https://res.vmallres.com/pimages/detailImg/2019/04/25/201904251619275641818.jpg',
//            'https://img.alicdn.com/imgextra/i1/1800399917/O1CN01axz7y82N82JEg8d5s_!!1800399917.jpg_430x430q90.jpg',
//            'https://img.alicdn.com/bao/uploaded/i1/1800399917/O1CN01jVzHTv2N82I1APvGb_!!0-item_pic.jpg_120x120.jpg',
//            'https://img.alicdn.com/bao/uploaded/i1/1800399917/O1CN01Juk4172N82JQvqM2f_!!0-item_pic.jpg_120x120.jpg',
//            'https://img.alicdn.com/bao/uploaded/i4/1800399917/O1CN01rvMy702N82Ira2AUp_!!0-item_pic.jpg_120x120.jpg',
//            'https://img.alicdn.com/bao/uploaded/i2/1800399917/O1CN01ILu0X62N82JOT6WQb_!!0-item_pic.jpg_120x120.jpg'
//          ]
      );
      _postModels.add(postModel);
      print('_postModels.length ' + _postModels.length.toString());

      _getMessage(value.toString()).then((value) {
        print('postModel.message ${value}');

        setState(() {
          postModel.message = value.wareName;
          postModel.logoImage = value.imageUrl;
        });
      });

      _getPhotos(value.toString()).then((value) {
        setState(() {
          postModel.photos = value.map((item) => item.thumb).toList();
        });
      });
      postController.add(_postModels);
    }
  }

  Future<List<ImageModel>> _getPhotos(keyword) async {
    var data = await getGirlList(keyword);
    List images = data.map((i) => ImageModel.fromJSON(i)).toList();
    return images.take(_imageCounts[Random().nextInt(_imageCounts.length)]).toList();
  }

  Future<SearchResultItemModal> _getMessage(String keyword) async {
    var data = await getSearchResult(keyword, 0);
    SearchResultListModal list = SearchResultListModal.fromJson(data);
    return list.data.first;
  }

  int _randomCount() {
    return Random().nextInt(1000);
  }

  void dispose() {
    postController?.close();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          AnimatedPositioned(
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 500),
            left: 0,
            top: _topBackgroundTop,
//            child: Container(
//                decoration: new BoxDecoration(
//                  gradient: const LinearGradient(colors: [Colors.orange, Colors.deepOrange]),
//                ),
////                color: Theme.of(context).primaryColor,
//                width: ScreenUtil.screenWidth,
//                height: ScreenUtil.screenHeight / 4),
            child: _topBackgroundImages[_selectedTabBarIndex]
                .toString()
                .length == 0 ? Container(
                decoration: new BoxDecoration(
                  gradient: const LinearGradient(colors: [Colors.orange, Colors.deepOrange]),
                ),
//                color: Theme.of(context).primaryColor,
                width: ScreenUtil.screenWidth,
                height: ScreenUtil.screenHeight / 4) : CachedNetworkImage(
              imageUrl:
              _topBackgroundImages[_selectedTabBarIndex]
              , width: ScreenUtil.screenWidth,
              height: ScreenUtil.screenHeight / 4, fit: BoxFit.fill,),
          ),
          AnimatedPositioned(
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 500),
            left: 0,
            top: _topBarTop,
            width: ScreenUtil.screenWidth,
            child: Container(
//              color: Colors.red,
              height: _topBarHeight,
              child: _buildTopBar(),
//              height: 48,
            ),
//            child: _buildTopBar(),
          ),
//          Positioned(
//            left: 0,
//            top: ScreenUtil.statusBarHeight + 10+48+12,
//            width: ScreenUtil.screenWidth,
//            height: 48,
//            child: Container(
//              child: _buildTabBar(),
////              height: 48,
//            ),
//          ),
//          Expanded(
//              child: TabBarView(
//                children: <Widget>[
//                  SearchSuggestPage(),
//                  SearchSuggestPage(),
//                  SearchSuggestPage(),
//                ],
//              ))

//          bodySliverList()
          AnimatedPositioned(
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 500),
//            top: (ScreenUtil.screenHeight / 4) / 2,
            top: _tabControllerTop,
            left: 0,
            width: ScreenUtil.screenWidth,
            height: ScreenUtil.screenHeight - (ScreenUtil.screenHeight / 4) / 2,
            child: Container(
//              color: Colors.blue,
//              child: bodySliverList(),
//              child: bodySliverList(),
              child: DefaultTabController(length: _tabsTitle.length, child: _buildContentWidget()),
//              width: ScreenUtil.screenWidth,
//              height: ScreenUtil.screenHeight,
            ),
          )
        ],
      ),
    );
  }

//TabController _tabController=TabController(length: null, vsync: null);

  Widget _buildContentWidget() {
    return Column(
      children: <Widget>[
//        SizedBox(
//          height: 8,
//        ),
        Container(
          height: _tabBarHeight,
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: TabBar(
              controller: _tabController,
//          controller: tabController,
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: true,
//          labelColor: KColorConstant.themeColor,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
//          labelPadding: EdgeInsets.only(left: (ScreenUtil.screenWidth-30*3)/4),
//            labelPadding: EdgeInsets.only(left: 40, right: 40),
              labelStyle: TextStyle(fontSize: 14),
              onTap: (i) {
//            _selectedIndex = i;
//
//            setState(() {});
              },
              tabs: _tabsTitle
                  .map((i) =>
                  Text(
                    i,
                  ))
                  .toList()),
        ),
//        SizedBox(
//          height: 8,
//        ),
        Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _tabsTitle.map((value) {
                return WeiTaoListPage(
                  onNotification: _onScroll,
                );
              }).toList(),
            ))
      ],
    );
  }

  _handleTabSelection() {
//    if (!_controller.indexIsChanging) {
//      return;
//    }
    print('_handleTabSelection:${_tabController.index}');
    if (_selectedTabBarIndex == _tabController.index) {
      return;
    }
//return;
    setState(() {
      _selectedTabBarIndex = _tabController.index;
    });
  }

//  double offset=0;
  double _lastScrollPixels = 0;

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

//    print('当前滑动距离 ${currentExtent} ${currentExtent - _lastScrollPixels}');

    //向下滚动
    if (currentExtent - _lastScrollPixels > 0 && _topBarTop > 0 && currentExtent > 0) {
      print('hide');
      setState(() {
        _topBarTop = -_topBarHeight;
        _tabControllerTop = _topBarDefaultTop;
        _topBackgroundTop = -(_topBackgroundHeight - _tabBarHeight - _tabControllerTop);
      });
    }

    //向上滚动
    if (currentExtent - _lastScrollPixels < 0 && _topBarTop < 0 && currentExtent.toInt() <= 0) {
      print('show');
      setState(() {
        _topBackgroundTop = 0;
        _topBarTop = _topBarDefaultTop;
        _tabControllerTop = _tabControllerDefaultTop;
      });
    }

    _lastScrollPixels = currentExtent;

//    if (maxExtent - currentExtent > widget.startLoadMoreOffset) {
//      // 开始加载更多
//
//    }

    // 返回false，继续向上传递,返回true则不再向上传递
    return false;
  }

  Widget _buildTabBar() {
    return TabBar(
//          controller: widget.tabController,
        indicatorColor: Color(0xFFfe5100),
        indicatorSize: TabBarIndicatorSize.label,
        isScrollable: true,
//          labelColor: KColorConstant.themeColor,
        labelColor: Color(0xFFfe5100),
        unselectedLabelColor: Colors.black,
//          labelPadding: EdgeInsets.only(left: (ScreenUtil.screenWidth-30*3)/4),
        labelPadding: EdgeInsets.only(left: 40, right: 40),
        labelStyle: TextStyle(fontSize: 12),
        onTap: (i) {
          print('tabBar onTap ${i}');
//            _selectedIndex = i;
//
//            setState(() {});
        },
//                  tabs: _tabsTitle
//                      .map((i) => Container(
//                          color: Colors.red,
//                          alignment: Alignment.center,
////width: 30,
////                      padding: EdgeInsets.symmetric(vertical: 10),
////                  padding: EdgeInsets.only(left: (ScreenUtil.screenWidth-30*3)/4),
//                          margin: EdgeInsets.only(left: (ScreenUtil.screenWidth - 30 * 3) / 4),
//                          child: new Text(
//                            i,
//                            style: TextStyle(fontSize: 12),
////                        style: GSYConstant.smallTextWhite,
//                            maxLines: 1,
//                          )))
//                      .toList()
        tabs: _tabsTitle
            .map((i) =>
            Text(
              i,
            ))
            .toList());
  }

  Widget _buildTopBar() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            '微淘',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
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
          child: Icon(GZXIcons.people_list_light, color: Colors.white),
        ),
        SizedBox(
          width: 8,
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
