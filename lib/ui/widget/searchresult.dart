import 'package:flutter/material.dart';
import 'package:flutter_taobao/common/model/search.dart';
import 'package:flutter_taobao/common/style/color.dart';
import 'package:flutter_taobao/common/style/gzx_style.dart';
import 'package:flutter_taobao/common/utils/common_utils.dart';
import 'package:flutter_taobao/common/utils/screen_util.dart';

class SearchResultListWidget extends StatelessWidget {
  final SearchResultListModal list;
  final ValueChanged<String> onItemTap;
  final VoidCallback getNextPage;

  SearchResultListWidget(this.list, {this.onItemTap, this.getNextPage});

  @override
  Widget build(BuildContext context) {
    return list.data.length == 0
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10),
            itemCount: list.data.length,
            itemExtent: ScreenUtil().L(127),
            itemBuilder: (BuildContext context, int i) {
              SearchResultItemModal item = list.data[i];
              if ((i + 3) == list.data.length) {
                getNextPage();
              }
              return Container(
                color: KColorConstant.searchAppBarBgColor,
                padding: EdgeInsets.only(top: ScreenUtil().L(5), right: ScreenUtil().L(10)),
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: Image.network(
                          item.imageUrl,
                          width: ScreenUtil().L(120),
                          height: ScreenUtil().L(120),
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1, color: KColorConstant.divideLineColor))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            item.wareName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: <Widget>[
//                              SizedBox(
//                                width: 5,
//                              ),
                              item.coupon == null
                                  ? SizedBox()
                                  : Container(
                                      margin: const EdgeInsets.only(left: 8, top: 0, right: 0, bottom: 0),
                                      child: Text(
//                              item.coupon,
//                        '满88减5',
                                        item.coupon,
                                        style: TextStyle(color: Color(0xFFff692d), fontSize: 10),
                                      ),
//                            padding: EdgeInsets.symmetric(horizontal: 3),
//                            margin: EdgeInsets.only(left: 4),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(3)),
                                          border: Border.all(width: 1, color: Color(0xFFff692d))),
                                    ),
                              Container(
                                margin: const EdgeInsets.only(left: 8, top: 0, right: 0, bottom: 0),
                                child: Text(
                                  '包邮',
                                  style: TextStyle(color: Color(0xFFfebe35), fontSize: 10),
                                ),
//                            padding: EdgeInsets.symmetric(horizontal: 3),
//                            margin: EdgeInsets.only(left: 4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(3)),
                                    border: Border.all(width: 1, color: Color(0xFFffd589))),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '￥',
                                style: TextStyle(fontSize: 10, color: Color(0xFFff5410)),
                              ),
                              Text(
                                '${CommonUtils.removeDecimalZeroFormat(double.parse(item.price))}',
//                          '27.5',
                                style: TextStyle(fontSize: 16, color: Color(0xFFff5410)),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  '${item.commentcount}人评价',
//                            '23234人评价',
//                          product
                                  style: TextStyle(fontSize: 10, color: Color(0xFF979896)),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: Row(
//                            crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
//                              Expanded(child:,),
                                  Flexible(
                                    child: Text(
                                      '${item.shopName}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GZXConstant.searchResultItemCommentCountStyle,
                                    ),
//                                flex: 2,
                                  ),
//                          Text(
//                          '${item.shopName}',
//                            maxLines: 1,
//                            overflow: TextOverflow.ellipsis,
//                            style: GZXConstant.searchResultItemCommentCountStyle,
//                          ),
                                  SizedBox(
                                    width: 8,
                                  ),
//                            Expanded(child: Text('进店',style: TextStyle(fontSize: 12),),),
                                  Text('进店', style: TextStyle(fontSize: 12)),
//                          Icon(Icons.chevron_right,size: 18,color: Colors.grey,) ,
//                              Expanded(
//                                child:
                                  Container(
                                    alignment: Alignment.centerLeft,
//                                  color: Colors.red,
                                    child: Icon(
                                      Icons.chevron_right,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
//                              ),
                                ],
//                           ),
                              )),
                              Container(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.more_horiz,
                                  size: 15,
                                  color: Color(0xFF979896),
                                ),
                              ),
//                            Icon(
//                              Icons.more_horiz,
//                              size: 15,
//                              color: Color(0xFF979896),
//                            ),
                            ],
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              );
            },
          );
  }
}
