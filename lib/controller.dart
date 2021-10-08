import 'package:get/get.dart';
import 'package:poc_feed/model.dart';
import 'package:poc_feed/service.dart';

class ListController extends GetxController with StateMixin<List<FeedModel>> {
  RxList<FeedModel> feeds = RxList([]);

  RxBool isLoadMore = RxBool(false);

  Future<void> getFeeds(int startIndex) async {
    if (!isLoadMore.value) change([], status: RxStatus.loading());
    feeds.addAll(await FeedService().getFeeds(feeds.length));
    isLoadMore.value = false;
    change(feeds, status: RxStatus.success());
  }

  int get feedLength => feeds.length;
}
