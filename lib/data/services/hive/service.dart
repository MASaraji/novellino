import 'dart:io';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import '../../model/model.dart';

class HiveService extends GetxService {
  Future<HiveService> init() async {
    await Hive.initFlutter(await getPath());
    return this;
  }

  Future<String> getPath() async {
    Directory dir = await getApplicationDocumentsDirectory();
    Future<String> getPath() async {
      Directory dir = await getApplicationDocumentsDirectory();
      return "${dir.path}/novellino";
    }

    void registerAdaptors() {
      Hive.registerAdapter(NovelAdapter());
    }

    Future<void> init() async {
      await Hive.initFlutter(await getPath());
    }

    Future<void> openInitBoxes() async {
      await Hive.openBox("favorite");
    }

    return "${dir.path}/novellino";
  }

  void registerAdaptors() {
    Hive.registerAdapter(NovelAdapter());
  }

  Future<void> openInitBoxes() async {
    await Hive.openBox("favorite");
  }
}
