import 'order.dart';

class ShoppingCartModel {
  String shopName;
  bool hasCoupons;
  bool hasTmallEasyBuy;
  ShopType shopType;
  List<OrderModel> orderModels;
  String discounts;
  bool isSelected;

  ShoppingCartModel(this.shopName, this.hasCoupons, this.hasTmallEasyBuy, this.shopType, this.orderModels,
      {this.discounts, this.isSelected = false});
}

enum ShopType {
  tianMao,
  taoBao,
}
