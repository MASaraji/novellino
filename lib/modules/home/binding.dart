import 'package:get/get.dart';
import 'package:novellino/data/services/favorite/service.dart';
import 'package:novellino/modules/home/controller.dart';
import 'package:novellino/modules/home/repository.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    //Get.lazyPut<MyPageController>(() => MyPageController(

    //   MyPageRepository(MyApi())));
    Get.lazyPut<Favorite>(() => Favorite());
    Get.lazyPut<HomeController>(() => HomeController(HomeRepository()));
  }
}
