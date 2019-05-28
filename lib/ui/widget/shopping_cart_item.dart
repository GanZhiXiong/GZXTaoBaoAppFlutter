import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_taobao/common/model/order.dart';
import 'package:flutter_taobao/common/model/shopping_cart.dart';
import 'package:flutter_taobao/common/style/gzx_style.dart';
import 'package:flutter_taobao/common/utils/common_utils.dart';

import 'gzx_checkbox.dart';
import 'gzx_quantity_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

typedef AddTop<T> = void Function(T value);
typedef RemoveTop<T> = void Function(T value);
typedef OnSelectChanged<T,A> = void Function(T value,A value1);

class ShoppingCarItemWidget extends StatelessWidget {
  final ShoppingCartModel shoppingCartModel;
  final AddTop<OrderModel> addTap;
  final RemoveTop<OrderModel> removeTap;
  final ValueChanged<bool> onSelectAllChanged;
  final OnSelectChanged<OrderModel,bool> onSelectChanged;
final Color color;
  const ShoppingCarItemWidget(
    this.shoppingCartModel, {
    Key key,
    this.addTap,
    this.removeTap,
    this.onSelectAllChanged,
    this.onSelectChanged, this.color=const Color(0xFFf3f3f3),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var body = Container(
      padding: EdgeInsets.symmetric(vertical: 2,horizontal: 4),
      color: color,
//            child: _ConversationItem(conversation: pullLoadWidgetControl.dataList[index]
      child: Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  GZXCheckbox(
                    value: shoppingCartModel.isSelected,
                    onChanged: onSelectAllChanged,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    GZXIcons.tmall,
                    color: Colors.red,
                    size: 10,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Text(
                          shoppingCartModel.shopName,
                          style: TextStyle(fontSize: 12),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: Color(0xFFcbcccb),
                        )
                      ],
                    ),
                  ),
                  !shoppingCartModel.hasCoupons
                      ? Container()
                      : Expanded(
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              '领券',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ))
                ],
              ),
//              Container(
//                width: 300,
//                child:
//              GZXOrderWidget(
//                orderModel: OrderModel(
//                    'https://img.alicdn.com/bao/uploaded/i5/TB1trAMNQPoK1RjSZKb.LB1IXXa_101123.jpg_80x80.jpg',
//                    '【旗舰新品 稀缺货源】Huawei/华为 P30全面屏超感光徕卡三摄变焦',
//                    '4G全网通;天空之境;官方标配;8+64GB',
//                    2,
//                    3988,
//                    1),
//                shoppingCartModel: shoppingCartModel,
//                addTap: addTap,
//                removeTap: removeTap,
//              ),
//              )
              ListView(
                primary: false,
                shrinkWrap: true,
                children: shoppingCartModel.orderModels.map((item) {
                  return GZXOrderWidget(
                    onSelectChanged: onSelectChanged,
                    orderModel: item,
                    shoppingCartModel: shoppingCartModel,
                    addTap: () {
                      addTap(item);
                    },
                    removeTap: () {
                      removeTap(item);
                    },
                  );
                }).toList(),
              ),

              shoppingCartModel.discounts == null
                  ? Container()
                  : Row(
                      children: <Widget>[
                        SizedBox(
                          width: 40,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFfc6d41), width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(4))),
                          child: Text(
                            '本店活动',
                            style: TextStyle(fontSize: 12, color: Color(0xFFfc6d41)),
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          shoppingCartModel.discounts,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );

    return body;
  }
}

class GZXOrderWidget extends StatelessWidget {
  final OrderModel orderModel;
  final ShoppingCartModel shoppingCartModel;
  final GestureTapCallback addTap;
  final GestureTapCallback removeTap;
  final OnSelectChanged<OrderModel,bool> onSelectChanged;

  const GZXOrderWidget({Key key, this.orderModel, this.shoppingCartModel, this.addTap, this.removeTap, this.onSelectChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var row = Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Row(
        children: <Widget>[
          GZXCheckbox(
            value: orderModel.isSelected,
            onChanged: (value){
              onSelectChanged(orderModel,value);
            },
          ),
          SizedBox(
            width: 12,
          ),
          Container(
            width: 80,
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: orderModel.productImageUrl,
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        width: 14,
      ),
      Expanded(
//        child: Container(
//          height: 200,
//          width: 200,
//          color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
//              Expanded(
//                child:
            Text(
              orderModel.title,
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)), color: Color(0xFFf6f5f6)),
              padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      orderModel.configuration,
                      style: TextStyle(fontSize: 12, color: Color(0xFF818282)),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFFcbcaca),
                    size: 18,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 4,
            ),

            shoppingCartModel.hasTmallEasyBuy
                ? SizedBox()
                : Image.asset(
                    GZXIcons.tmall_easy_buy,
                    height: 12,
                    width: 50,
                    fit: BoxFit.fill,
                  ),
            SizedBox(
              height: 4,
            ),

            orderModel.amountPurchasing == 0
                ? SizedBox()
                : Text(
                    '限购${orderModel.amountPurchasing}件',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFFfe4f02),
                    ),
                  ),
            SizedBox(
              height: 4,
            ),

            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Text(
                '￥',
                style: TextStyle(fontSize: 10, color: Color(0xFFff5410)),
              ),
              Text(
                '${CommonUtils.removeDecimalZeroFormat(orderModel.price)}',
//                          '27.5',
                style: TextStyle(fontSize: 14, color: Color(0xFFff5410)),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: GZXQuantityWidget(
                    quantity: orderModel.quantity,
                    addTap: addTap,
                    removeTap: removeTap,
                  ),
                ),
              )
            ]),
//              )
          ],
//          ),
        ),
      )
//      Container(
//        width: 200,
////        padding: EdgeInsets.all(0),
//        child: Column(
//          children: <Widget>[
//            Expanded(
//              child: Text(
//                orderModel.title,
//                style: TextStyle(fontSize: 12),
//              ),
//            )
//          ],
//        ),
//      )
    ]);

    return Container(
      child: row,
      padding: EdgeInsets.symmetric(
        vertical: 20,
      ),
    );
  }
}
