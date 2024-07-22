import 'package:auto_size_text/auto_size_text.dart';
import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:novellino/data/model/model.dart';
import 'package:novellino/data/services/favorite/service.dart';
import 'package:novellino/global_widgets/bottomNavigationBar.dart';
import 'package:novellino/modules/sites/controller.dart';

import 'controller.dart';

// ignore: must_be_immutable
class ChaptersPage extends GetView<ChaptersController> {
  final Novel novel = Get.arguments[0];
  SiteController siteController = Get.find<SiteController>();

  ChapterController chapterController = Get.find<ChapterController>();
  late final Site site =
      Get.arguments.length == 1 ? siteController.getSite() : Get.arguments[1];

  ChaptersPage({Key? key}) : super(key: key) {
    controller.setNovel(novel);
  }
  Favorite favorite = Get.find<Favorite>();
//------------------------------------------------------------------------------
  IconButton favoriteButton() => IconButton(
        icon: Icon(
          Icons.favorite,
          size: 30,
          color: favorite.isFavorite(novel.title) ? Colors.red : Colors.grey,
        ),
        onPressed: controller.saveDelete,
      );

  SizedBox novelTitle() => SizedBox(
      width: 200,
      child: AutoSizeText(novel.title,
          style: const TextStyle(
              color: Colors.black, fontSize: 19, fontWeight: FontWeight.w500)));

  IconButton backButton() => IconButton(
        onPressed: Get.back,
        icon: const Icon(Icons.arrow_back),
        iconSize: 30,
      );

  Container backgroundShadow() {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white38, Colors.white])));
  }

  SliverList waiting() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, int index) {
      return const SpinKitRing(color: Colors.black);
    }, childCount: 1));
  }

  ListTile chapterTile(Chapter chapter, int index) {
    return ListTile(
      leading: Container(
        width: 300,
        child: Text(chapter.title),
      ),
      onTap: () {
        controller.setNovel(novel);
        chapterController.setChapter(index);
        Get.toNamed("/readChapterPage");
      },
    );
  }

  late final Image novelImage = Image.network(novel.image, fit: BoxFit.fill);

//------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    controller.setNovel((novel));
    return Scaffold(
        bottomNavigationBar: customNavBar(),
        body: CustomScrollView(slivers: [
          SliverAppBar(
              automaticallyImplyLeading: false,
              centerTitle: false,
              title: backButton(),
              pinned: true,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(children: [
                  Positioned.fill(child: novelImage),
                  Positioned.fill(child: backgroundShadow()),
                  Positioned(
                      top: 80.0,
                      left: 10,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 200, child: novelImage),
                            const SizedBox(width: 30),
                            novelTitle(),
                          ])),
                  Positioned(
                      right: 30,
                      bottom: 10,
                      child: GetBuilder<ChaptersController>(
                          builder: (_) => favoriteButton())),
                ]),
              )),
          StreamBuilder(
              stream: site.fetchChapters(novel),
              builder: (context, AsyncSnapshot<List<Chapter>> chapters) {
                if (chapters.hasData) {
                  return SliverList(
                      delegate:
                          SliverChildBuilderDelegate((context, int index) {
                    return chapterTile(chapters.data![index], index);
                  }, childCount: chapters.data!.length));
                } else {
                  return waiting();
                }
              }),
        ]));
  }
}
