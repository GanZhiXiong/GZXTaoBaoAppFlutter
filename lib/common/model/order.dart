class OrderModel {
  String productImageUrl;
  String title;
  String configuration;
  int amountPurchasing;
  double price;
  int quantity;
  bool isSelected;

  OrderModel(this.productImageUrl, this.title, this.configuration, this.amountPurchasing, this.price, this.quantity,
      {this.isSelected = false});
}
