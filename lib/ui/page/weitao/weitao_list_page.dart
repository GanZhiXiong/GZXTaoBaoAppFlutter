import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_taobao/common/model/image.dart';
import 'package:flutter_taobao/common/model/post.dart';
import 'package:flutter_taobao/common/model/search.dart';
import 'package:flutter_taobao/common/services/meinv.dart';
import 'package:flutter_taobao/common/services/search.dart';
import 'package:flutter_taobao/common/style/gzx_style.dart';

class WeiTaoListPage<T extends ScrollNotification> extends StatefulWidget {
  final NotificationListenerCallback<T> onNotification;

  const WeiTaoListPage({Key key, this.onNotification}) : super(key: key);

  @override
  _WeiTaoListPageState createState() => _WeiTaoListPageState();
}

class _WeiTaoListPageState extends State<WeiTaoListPage> with AutomaticKeepAliveClientMixin<WeiTaoListPage> {
  List<PostModel> _postModels = [];

  //column1
  Widget profileColumn(BuildContext context, PostModel post) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          post.logoImage == null||post.toString().length==0 ? Container():CircleAvatar(
//            backgroundImage: NetworkImage(post.logoImage),
            backgroundColor: Colors.white,
            backgroundImage: Image
                .network(
              post.logoImage,
              fit: BoxFit.fill,
            )
                .image,
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
    return GridView.builder(
        padding: const EdgeInsets.all(0),
        primary: false,
//      scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 6,
          mainAxisSpacing: 6,
          crossAxisCount: 3,
        ),
        itemCount: post.photos.length,
//    children: post.photos.map((item) {
        itemBuilder: (BuildContext context, int index) {
          var item = post.photos[index];
//        int index = post.photos.indexOf(item);
//        print(index);
//        return Image.network(item, fit: BoxFit.fill,);
          return CachedNetworkImage(
            fadeInDuration: Duration(milliseconds: 0),
            fadeOutDuration: Duration(milliseconds: 0),
//          color: Colors.blue,
            imageUrl: item,
//        imageUrl: 'https://res.vmallres.com/pimages//product/6901443293742/group//428_428_1555465554342.png' ,
            fit: BoxFit.fill,
          );
        });
//    );
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
//          print('SliverChildBuilderDelegate ${index}');

          if (index + 3 == posts.length) {
            print('weitao,current data count ${posts.length},current index $index');

            _getDynamic();
          }
          return Padding(
            padding: const EdgeInsets.only(left: 6, top: 3, right: 6, bottom: 3),
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
              ? NotificationListener<ScrollNotification>(
            onNotification: widget.onNotification,
            child: CustomScrollView(
              slivers: <Widget>[
//              appBar(),
                bodyList(snapshot.data),
              ],
            ),
          )
              : Center(child: CircularProgressIndicator());
        });
  }

  bool _onScroll(ScrollNotification scroll) {
//    if (notification is! ScrollNotification) {
//      // 如果不是滚动事件，直接返回
//      return false;
//    }

//    ScrollNotification scroll = notification as ScrollNotification;
    if (scroll.metrics.axisDirection == AxisDirection.down) {
      print('donw');
    } else if (scroll.metrics.axisDirection == AxisDirection.up) {
      print('up');
    }
    // 当前滑动距离
    double currentExtent = scroll.metrics.pixels;
    print('当前滑动距离 ${currentExtent}');
//    double maxExtent = scroll.metrics.maxScrollExtent;
//    if (maxExtent - currentExtent > widget.startLoadMoreOffset) {
//      // 开始加载更多
//
//    }

    // 返回false，继续向上传递,返回true则不再向上传递
    return false;
  }

  final postController = StreamController<List<PostModel>>();

  Stream<List<PostModel>> get postItems => postController.stream;

  List _imageCounts = [3, 6, 9];
  List _tabsTitle = ['关注', '上新', '新势力', '精选', '晒单', '时尚', '美食', '潮sir', '生活', '明星', '品牌'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
          logoImage: '',
//          logoImage:
//              'https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=2094939883,1219286755&fm=179&app=42&f=PNG?w=121&h=140',
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
//      print('_postModels.length ' + _postModels.length.toString());

      _getMessage(value.toString()).then((value) {
//        print('postModel.message ${value}');

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
//    print(list.data.first);
    if (list.data == null || list.data.length == 0) {
      return SearchResultItemModal(
        wareName: '华为 P30',
//          imageUrl:
//              'https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=2094939883,1219286755&fm=179&app=42&f=PNG?w=121&h=140'
      );
    } else {
      return list.data.first;
    }
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
    return bodySliverList();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
