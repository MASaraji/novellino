import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novellino/data/services/hive/service.dart';
import 'package:novellino/routes/pages.dart';
import 'package:novellino/core/theme/themes.dart';
import 'modules/splash/page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HiveService service = HiveService();
  await Get.putAsync(() => HiveService().init());
  service = Get.find<HiveService>();
  service.registerAdaptors();
  await service.openInitBoxes();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.SPLASH,
    theme: appThemeData,
    defaultTransition: Transition.fade,
    //initialBinding: SplashBinding(),
    getPages: AppPages.pages,
    home: const SplashPage(),
  ));
}
