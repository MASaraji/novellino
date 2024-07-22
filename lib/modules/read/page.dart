import 'package:get/get.dart';
import 'package:novellino/modules/read/controller.dart';
import 'package:novellino/modules/read/local_widgets/floating_button_reading_chapter.dart';
import "package:flutter/material.dart";
import 'package:novellino/modules/sites/controller.dart';

import '../../global_widgets/waiting.dart';
import '../../data/model/model.dart';
import '../chapters/controller.dart';

// ignore: must_be_immutable
class ReadChapterPage extends GetView<ReadChapterController> {
  SiteController siteController = Get.find<SiteController>();
  late final Site site = siteController.getSite();
  ReadChapterPage({
    Key? key,
  }) : super(key: key);

  final chapterController = Get.find<ChapterController>();

//------------------------------------------------------------------------------
  Widget mainText(String? text) =>
      Text(text ?? "", style: TextStyle(fontSize: controller.fontSize.value));

  Widget floatingButton() => controller.barExist.value
      ? FloatingButtonReading(
          controller: controller,
          chapter: chapterController.chapter,
        )
      : Container();

  Widget appBar() => controller.barExist.value
      ? AppBar(title: Text(chapterController.chapter.title))
      : Container();

//------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    Get.put(ReadChapterController());
    return GestureDetector(
        onHorizontalDragEnd: (detail) {
          if (detail.primaryVelocity! > 0.5) {
            chapterController.nextChapter();
          } else if (detail.primaryVelocity! < -.5) {
            chapterController.previousChapter();
          }
        },
        onLongPress: controller.changeBarState,
        child: Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: Obx(appBar)),
            floatingActionButton: Obx(floatingButton),
            body: GetBuilder<ChapterController>(
                init: chapterController,
                builder: (_) => FutureBuilder<Chapter>(
                    future: site.fetchChapter(chapterController.chapter),
                    builder: (context, chapt) {
                      if (chapt.hasData) {
                        return SingleChildScrollView(
                          padding: const EdgeInsets.all(20),
                          child: Obx(() => mainText(chapt.data?.text)),
                        );
                      } else {
                        return waiting();
                      }
                    }))));
  }
}
