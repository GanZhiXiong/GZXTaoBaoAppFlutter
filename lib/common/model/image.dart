class ImageModel {
  int width;
  int height;
  String thumb;

  ImageModel({this.height, this.width, this.thumb});

  ImageModel.fromJSON(dynamic json)
      : width = int.parse(json['width']),
        height = int.parse(json['height']),
        thumb = json['thumb'];
}
