import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novellino/global_widgets/waiting.dart';
import 'package:novellino/data/provider/lightnovelpub.dart';

import '../../data/model/model.dart';

class LightNovelPubPage extends StatelessWidget {
  const LightNovelPubPage({Key? key}) : super(key: key);

//------------------------------------------------------------------------------

  GestureDetector cardNovel(Novel novel) {
    return GestureDetector(
        onTap: () => Get.toNamed("/ChaptersPage", arguments: [novel]),
        child: Image.network(novel.image, fit: BoxFit.fill));
  }

  FutureBuilder ongoingSliderMenu() {
    return FutureBuilder<List<Novel>>(
        future: Lightnovelpub().fetchOngoingRelease(),
        builder: (context, novels) {
          if (novels.hasData) {
            return PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: novels.data?.length,
                itemBuilder: (context, index) {
                  Novel novel = novels.data![index];
                  return Container(
                      margin: const EdgeInsets.all(1), child: cardNovel(novel));
                });
          } else {
            return waiting();
          }
        });
  }

  FutureBuilder weeklyMostActiveMenu() {
    return FutureBuilder<List<Novel>>(
        future: Lightnovelpub().fetchWeeklyMostActive(),
        builder: (context, novels) {
          if (novels.hasData) {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, childAspectRatio: 0.7),
                itemCount: novels.data?.length,
                itemBuilder: (context, index) {
                  Novel novel = novels.data![index];
                  return Container(
                      width: 300,
                      margin: const EdgeInsets.all(3),
                      child: cardNovel(novel));
                });
          } else {
            return waiting();
          }
        });
  }
//------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("  Ongoing Release",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Divider(thickness: 2),
                SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: ongoingSliderMenu()),
                const SizedBox(width: double.infinity, height: 30),
                const Text("  Weekly Most Active",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                const Divider(thickness: 2),
                SizedBox(
                    width: double.infinity,
                    height: 450,
                    child: weeklyMostActiveMenu()),
              ],
            )));
  }
}
