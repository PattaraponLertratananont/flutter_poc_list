import 'package:poc_feed/model.dart';

class FeedService {
  Future<List<FeedModel>> getFeeds(int startIndex) async {
    List<FeedModel> feeds = [];
    for (var i = 0; i < 20; i++) {
      feeds.add(
        FeedModel(
          img: "https://picsum.photos/id/${startIndex + i}/400/300",
          title: "Image index ${startIndex + i}",
          desc: "for test img${startIndex + i}",
        ),
      );
    }
    return await Future.delayed(const Duration(milliseconds: 300), () {
      return feeds;
    });
  }
}
