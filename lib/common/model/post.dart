class PostModel {
  String name;
  String logoImage;
  String address;
  String message;
  String messageImage;
  int readCout;
  int likesCount;
  int commentsCount;
  String postTime;
  List<String> photos;
  bool isLike;

  PostModel(
      {this.name,
      this.logoImage,
      this.address,
      this.message,
      this.commentsCount,
      this.likesCount,
      this.messageImage,
      this.postTime,
      this.photos,this.readCout,this.isLike});
}
