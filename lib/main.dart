import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poc_feed/controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var controller = ListController();
  ScrollController scrollController = ScrollController();
  final double heightOfLoadMore = 40;
  final double marginVerticalOfLoadMore = 16;

  @override
  void initState() {
    controller.getFeeds(1);
    scrollController.addListener(() {
      bool isEdgaBottom = scrollController.position.atEdge &&
          scrollController.position.pixels != 0;

      double pixelAddingLoadmore = scrollController.position.pixels +
          heightOfLoadMore +
          (marginVerticalOfLoadMore * 2);
      if (isEdgaBottom) {
        controller.isLoadMore.value = true;
        scrollController.jumpTo(pixelAddingLoadmore);
        controller.getFeeds(50);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("POC LIST"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            controller: scrollController,
            child: Obx(
              () {
                return Column(
                  children: [
                    controller.obx(
                      (feeds) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.feedLength,
                          itemBuilder: (context, index) {
                            var feed = feeds![index];
                            return Column(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: feed.img,
                                  placeholder: (context, url) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.grey,
                                      ),
                                    );
                                  },
                                  errorWidget: (context, url, error) {
                                    return Container(
                                      color: Colors.red[100],
                                      child: Center(
                                        child: Text("ERROR"),
                                      ),
                                    );
                                  },
                                  height: 300,
                                  width: 400,
                                ),
                                Text(feed.title),
                                Text(feed.desc),
                              ],
                            );
                          },
                        );
                      },
                      onLoading: Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: controller.isLoadMore.value,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          vertical: marginVerticalOfLoadMore,
                        ),
                        height: heightOfLoadMore,
                        child: CircularProgressIndicator(color: Colors.green),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
