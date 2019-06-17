import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_taobao/common/utils/screen_util.dart';
class RectSwiperPaginationBuilder extends SwiperPlugin {
  ///color when current index,if set null , will be Theme.of(context).primaryColor
  final Color activeColor;

  ///,if set null , will be Theme.of(context).scaffoldBackgroundColor
  final Color color;

  ///Size of the rect when activate
  final Size activeSize;

  ///Size of the rect
  final Size size;

  /// Space between rects
  final double space;

  final Key key;

  const RectSwiperPaginationBuilder(
      {this.activeColor,
      this.color,
      this.key,
      this.size: const Size(10.0, 2.0),
      this.activeSize: const Size(10.0, 2.0),
      this.space: 3.0});

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    List<Widget> list = [];

    int itemCount = config.itemCount;
    int activeIndex = config.activeIndex;

    for (int i = 0; i < itemCount; ++i) {
      bool active = i == activeIndex;
      Size size = active ? this.activeSize : this.size;
      list.add(Container(
        width: size.width,
        height: size.height,
        color: active ? activeColor : color,
        key: Key("pagination_$i"),
        margin: EdgeInsets.all(space),
      ));
    }

    return new Container(child: Row(
      key: key,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: list,
    ),color: Colors.red,);
  }
}

class GZXSwipperBanner extends StatelessWidget {
  final List<String> banners;
  GZXSwipperBanner({this.banners});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = ScreenUtil().L(115);
    return Container(
      width: width,
      height: height,
      child: Swiper(
        itemBuilder: (BuildContext context, index) {
          return Image.network(
            banners[index],
            width: width,
            height: height,
          );
        },
        itemCount: banners.length,
        //viewportFraction: 0.9,
        pagination: new SwiperPagination(
            alignment: Alignment.bottomCenter,
            builder: RectSwiperPaginationBuilder(
                color: Color(0xFF999999),
                activeColor: Theme.of(context).primaryColor,
                size: Size(10, 3),
                activeSize: Size(10, 3),space: 0)),
        scrollDirection: Axis.horizontal,
        autoplay: true,
        onTap: (index) => print('点击了第$index个'),
      ),
    );
  }
}
