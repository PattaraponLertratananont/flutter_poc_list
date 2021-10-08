class FeedModel {
  late final String img;
  late final String title;
  late final String desc;

  FeedModel({
    required this.img,
    required this.title,
    required this.desc,
  });

  FeedModel.fromJson(Map<String, dynamic> json) {
    img = json["img"];
    title = json["title"];
    desc = json["desc"];
  }
}
