import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:novellino/global_widgets/bottomNavigationBar.dart';
import 'package:novellino/modules/novels/local_widgets/card_novel.dart';
import 'package:novellino/modules/sites/controller.dart';
import '../../global_widgets/waiting.dart';
import '../../data/model/model.dart';

// ignore: must_be_immutable
class NovelsPage extends StatelessWidget {
  SiteController siteController = Get.find<SiteController>();
  late final Site site = siteController.getSite();
  //siteController.site(Get.arguments) ?? siteController.site;

  NovelsPage({Key? key}) : super(key: key);

  void goToChaptersPage(Novel novel) {
    Get.offNamed("/chaptersPage", arguments: [novel]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: customNavBar(),
        appBar: AppBar(
          title: const Text("Novels"),
        ),
        body: FutureBuilder<List<Novel>>(
            future: site.fetchNovels(),
            builder: (context, novels) {
              if (novels.hasData) {
                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 0.7),
                    itemCount: novels.data?.length,
                    itemBuilder: (context, index) {
                      Novel novel = novels.data![index];
                      return CardNovel(
                          title: novel.title,
                          image: novel.image,
                          onTapFunc: () => goToChaptersPage(novel));
                    });
              } else {
                return waiting();
              }
            }));
  }
}
