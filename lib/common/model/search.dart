class SearchResultItemModal {
  String shopName;
  String wareName;
  String price;
  String coupon;
  String imageUrl;
  String commentcount;
  String good; //好评率
  String shopId;
  String disCount;

  SearchResultItemModal(
      {this.shopId,
      this.shopName,
      this.commentcount,
      this.coupon,
      this.price,
      this.good,
      this.disCount,
      this.imageUrl,
      this.wareName});

  factory SearchResultItemModal.fromJson(dynamic json) {
    String picurl = 'http://img10.360buyimg.com/mobilecms/s270x270_' + json['Content']['imageurl'];
    String coupon;
    if (json['coupon'] != null) {
      if (json['coupon']['m'] != '0') {
        coupon = '满${json['coupon']['m']}减${json['coupon']['j']}';
      }
    }
    String disCount;
    if (json['pfdt'] != null) {
      if (json['pfdt']['m'] != '') {
        disCount = '${json['pfdt']['m']}件${json['pfdt']['j']}折';
      }
    }

    return SearchResultItemModal(
        shopId: json['shop_id'],
        shopName: json['shop_name'],
        imageUrl: picurl,
        good: json['good'],
        commentcount: json['commentcount'],
        price: json['dredisprice'],
        coupon: coupon,
        disCount: disCount,
        wareName: json['Content']['warename']);
  }
}

class SearchResultListModal {
  List<SearchResultItemModal> data;

  SearchResultListModal(this.data);

  factory SearchResultListModal.fromJson(List json) {
    return SearchResultListModal(json.map((i) => SearchResultItemModal.fromJson(i)).toList());
  }
}
