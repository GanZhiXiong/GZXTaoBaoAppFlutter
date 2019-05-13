class KingKongItem {
  String href;
  String picUrl;
  String title;
  KingKongItem({this.href, this.picUrl,this.title});
  KingKongItem.fromJson(Map<String, dynamic> json)
      : href = json['href'],
        title=json['title'],
        picUrl = json['pic_url'];
}

class KingKongList {
  List<KingKongItem> items;
  KingKongList({this.items});
  factory KingKongList.fromJson( dynamic json) {
    List list = (json as List).map((i) {
      return KingKongItem.fromJson(i);
    }).toList();
    return KingKongList(items: list);
  }
}