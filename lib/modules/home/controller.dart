import 'package:get/get.dart';
import 'package:novellino/modules/home/repository.dart';
import '../sites/controller.dart';

class HomeController extends GetxController {
  final HomeRepository repository;
  HomeController(this.repository);
  SiteController siteController = Get.find<SiteController>();
  void changePage(int index_) => repository.goToPage(index_);
}
