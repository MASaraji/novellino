import 'package:get/get.dart';
import 'package:novellino/modules/chapters/controller.dart';
import 'package:novellino/modules/sites/controller.dart';
import 'package:novellino/modules/sites/repository.dart';

class ChaptersBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChaptersController>(() => ChaptersController());
    Get.lazyPut<ChapterController>(() => ChapterController());
    Get.lazyPut(() => SiteController(SiteRepository()));
  }
}
