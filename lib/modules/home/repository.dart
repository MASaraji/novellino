import 'package:get/get.dart';

class HomeRepository {
  HomeRepository();

  List pages = [
    "/novelsPage",
    "/splash",
    "/favoritePage",
    "/sitesPage",
    "/splash"
  ];

  void goToPage(index) {
    String temp;
    temp = pages[index];
    Get.offNamed(temp);
  }
}
