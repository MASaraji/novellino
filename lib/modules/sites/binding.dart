import 'package:get/get.dart';
import 'package:novellino/modules/sites/repository.dart';
import 'controller.dart';

class SiteBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SiteController>(() => SiteController(SiteRepository()));
  }
}
