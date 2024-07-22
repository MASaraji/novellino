import "package:animated_floating_buttons/animated_floating_buttons.dart";
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novellino/core/theme/config.dart';
import 'package:novellino/modules/read/controller.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../data/model/model.dart';

class FloatingButtonReading extends StatelessWidget {
  final ReadChapterController controller;
  final Chapter chapter;
  const FloatingButtonReading(
      {Key? key, required this.controller, required this.chapter})
      : super(key: key);

//------------------------------------------------------------------------------
  Widget increaseButton() {
    return FloatingActionButton(
      onPressed: controller.incrementFont,
      heroTag: "btn1",
      tooltip: "Increae Font Size",
      child: const Icon(Icons.add),
    );
  }

  Widget showUrl() {
    return FloatingActionButton(
        onPressed: () async {
          if (await launchUrlString(chapter.url)) {}
        },
        heroTag: "btn4",
        tooltip: "view website",
        child: const Icon(Icons.web));
  }

  Widget decreaseButton() {
    return FloatingActionButton(
        onPressed: controller.decrementFont,
        heroTag: "btn2",
        tooltip: "Decrease Font Size",
        child: const Icon(Icons.remove));
  }

  Widget changeMode() {
    return FloatingActionButton(
      onPressed: controller.changeTheme,
      heroTag: "btn3",
      tooltip: "night mode",
      child: GetBuilder<ReadChapterController>(builder: (_) {
        if (Get.isDarkMode) {
          return const Icon(Icons.light_mode);
        } else {
          return const Icon(Icons.mode_night);
        }
      }),
    );
  }
//------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return AnimatedFloatingActionButton(
      fabButtons: [showUrl(), increaseButton(), decreaseButton(), changeMode()],
      colorStartAnimation: ConfigController.fbrccolorStartAnimation,
      animatedIconData: AnimatedIcons.menu_close,
      colorEndAnimation: ConfigController.fbrccolorEndAnimation,
    );
  }
}
