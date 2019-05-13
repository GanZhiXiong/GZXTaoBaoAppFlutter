import 'package:flutter/material.dart';
import 'package:flutter_taobao/common/model/search.dart';
import 'package:flutter_taobao/common/utils/common_utils.dart';

class SearchResultGridViewWidget extends StatelessWidget {
  final SearchResultListModal list;
  final ValueChanged<String> onItemTap;
  final VoidCallback getNextPage;
  BuildContext _context;

  SearchResultGridViewWidget(this.list, {Key key, this.onItemTap, this.getNextPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _context = context;
    return list.data.length == 0
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: productGrid(list.data),
          );
  }

  Widget imageStack(String img) => Image.network(
        img,
//        height: 100,
        fit: BoxFit.cover,
      );

  Widget productGrid(List<SearchResultItemModal> data) => GridView.count(
//    primary: false,
//    shrinkWrap: true,
        crossAxisCount: MediaQuery.of(_context).orientation == Orientation.portrait ? 2 : 3,
        // 左右间隔
        crossAxisSpacing: 8,
        // 上下间隔
        mainAxisSpacing: 8,
        //宽高比 默认1
        childAspectRatio: 3 / 4,
//        shrinkWrap: true,
        children: data.map((product) {
          if ((data.indexOf(product) + 4) >= list.data.length) {
            getNextPage();
          }
          return Container(
//            color: Colors.blue ,
              child: Padding(
//                  padding: const EdgeInsets.only(left: 4,right: 4,top: 4,bottom: 4),
            padding: const EdgeInsets.all(0),
//            child: InkWell(
//              splashColor: Colors.yellow,
//        onDoubleTap: () => showSnackBar(),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              clipBehavior: Clip.antiAlias,
//                      elevation: 2.0,
              child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
//                        fit: StackFit.expand,
                children: <Widget>[
                  Expanded(
                    child: ConstrainedBox(
                      child: Image.network(
                        product.imageUrl,
//        height: 100,
                        fit: BoxFit.fill,
                      ),
                      constraints: new BoxConstraints.expand(),
                    ),
                  ),

//                          SizedBox(
//                            height: 10,
//                          ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 0, right: 8, bottom: 0),
//                      child: Text('AOC 23423234234 27英寸'),
                    child: Text(
                      product.wareName,
                      maxLines: 2,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(children: <Widget>[
                    product.coupon == null
                        ? SizedBox()
                        : Container(
                      margin: const EdgeInsets.only(left: 8, top: 0, right: 0, bottom: 0),
                      child: Text(
//                              item.coupon,
//                        '满88减5',
                        product.coupon,
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
                  ],),
                  SizedBox(
                    height: 18,
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
                        '${CommonUtils.removeDecimalZeroFormat(double.parse(product.price))}',
//                          '27.5',
                        style: TextStyle(fontSize: 16, color: Color(0xFFff5410)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          '${product.commentcount}人评价',
//                            '23234人评价',
//                          product
                          style: TextStyle(fontSize: 10, color: Color(0xFF979896)),
                        ),
                      ),
                      Icon(
                        Icons.more_horiz,
                        size: 15,
                        color: Color(0xFF979896),
                      ),
                      SizedBox(
                        width: 8,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  )
//                          descStack(product),
//                          ratingStack(product.rating),
//                          Container( child: imageStack(product.image),),
                ],
              ),
//              ),
            ),
          ));
        }).toList(),
      );
}
