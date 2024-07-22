import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:novellino/modules/sites/controller.dart';
import 'package:novellino/modules/sites/local_widgets/card_sites.dart';

class SitesPage extends GetView<SiteController> {
  const SitesPage({Key? key}) : super(key: key);
  void setMainSite(int index) {
    controller.siteIndex(index);
    Get.snackbar("Change site", "Changed to ${controller.site}");
  }

  void goToNovelPage(int index) {
    Get.offNamed("/novelsPage", arguments: controller.siteTitle(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Sites")),
        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: controller.titles().length,
            itemBuilder: (context, index) => CardSite(
                title: controller.siteTitle(index),
                onLongPressFunc: () => setMainSite(index),
                onTapFunc: () => goToNovelPage(index))));
  }
}
