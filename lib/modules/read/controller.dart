import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/config.dart';

class ReadChapterController extends GetxController {
  late var fontSize = ConfigController.readChapterFont.obs;
  var barExist = true.obs;

  void hideBar() => barExist.value = false;

  void changeBarState() => barExist.value = !barExist.value;

  void incrementFont() => fontSize.value++;

  void decrementFont() => fontSize.value--;

  void changeTheme() => Get.isDarkMode
      ? Get.changeTheme(ThemeData.light())
      : Get.changeTheme(ThemeData.dark());
}
