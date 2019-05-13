import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_taobao/common/model/product.dart';
import 'package:flutter_taobao/common/utils/common_utils.dart';

class RecommendFloor extends StatelessWidget {
  final ProductListModel data;

  RecommendFloor(this.data);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
//      width: deviceWidth,
//      color: Colors.white,
//    color: Colors.red,
//      padding: EdgeInsets.only(top: 10, bottom: 10, left: 7.5),
      child: _build(deviceWidth),
    );
  }

  Widget _build(double deviceWidth) {
    List<ProductItemModel> items = data.items;

//    double itemWidth = deviceWidth * 168.5 / 360 / 2;
//    double imageWidth = deviceWidth * 110.0 / 360 / 2;
    deviceWidth -= 28;
    double itemWidth = deviceWidth / 4;
    double imageWidth = deviceWidth / 4;
    List<Widget> listWidgets = items.map((i) {
      var bgColor = CommonUtils.string2Color(i.bgColor);
      Color titleColor = CommonUtils.string2Color(i.titleColor);
      Color subtitleColor = CommonUtils.string2Color(i.subtitleColor);
      return Container(
          width: itemWidth,
//          margin: EdgeInsets.only(bottom: 5, left: 2),
          padding: EdgeInsets.only(top: 8, left: 3, bottom: 7, right: 3),
//          color: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
//            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
//              SizedBox(height: 10,),
              Container(
                height: 25,
                child: Text(
                  i.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: titleColor),
                ),
              ),
              new ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  color: bgColor,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        i.subtitle,
                        maxLines: 1,
//                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: subtitleColor, fontWeight: FontWeight.w500, fontSize: 12),
                      ),
                      Container(
                        alignment: Alignment(0, 0),
                        margin: EdgeInsets.only(top: 5),
                        child: CachedNetworkImage(
                          imageUrl: i.picurl,
                          width: imageWidth,
                          height: imageWidth + 20,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ));
    }).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
//        Container(
//          padding: EdgeInsets.only(left: 5, bottom: 10),
//          child: Text(data.title, style: KfontConstant.fLoorTitleStyle),
//        ),
        Wrap(
          spacing: 0,
          children: listWidgets,
        )
      ],
    );
  }
}
