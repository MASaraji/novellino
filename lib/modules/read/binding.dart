import 'package:get/get.dart';
import 'package:novellino/modules/read/controller.dart';

import '../chapters/controller.dart';

class ReadChapterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadChapterController>(() => ReadChapterController());
    Get.lazyPut<ChapterController>(() => ChapterController());
  }
}
