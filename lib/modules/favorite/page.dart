import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:novellino/global_widgets/bottomNavigationBar.dart';
import 'package:novellino/modules/novels/local_widgets/card_novel.dart';
import 'package:novellino/modules/sites/controller.dart';
import '../../data/model/model.dart';
import '../../data/services/favorite/service.dart';

// ignore: must_be_immutable
class FavoritePage extends StatelessWidget {
  FavoritePage({Key? key}) : super(key: key);
  Favorite favorite = Get.find<Favorite>();
  SiteController siteController = Get.find<SiteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: customNavBar(),
        appBar: AppBar(title: const Text("Favorites")),
        body: ValueListenableBuilder(
          valueListenable: favorite.listen(),
          builder: (context, Box items, _) {
            List keys = items.keys.cast().toList();
            return GridView.builder(
                itemCount: keys.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.7),
                itemBuilder: (context, item) {
                  Novel novel = items.get(keys[item]);
                  return CardNovel(
                      title: novel.title,
                      image: novel.image,
                      onTapFunc: () => Get.offNamed("/ChaptersPage",
                              arguments: [
                                novel,
                                siteController.getSiteArg(novel.siteTitle)
                              ]));
                });
          },
        ));
  }
}
