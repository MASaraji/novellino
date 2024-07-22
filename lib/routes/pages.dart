import 'package:get/get.dart';
import 'package:novellino/modules/chapters/binding.dart';
import 'package:novellino/modules/chapters/page.dart';
import 'package:novellino/modules/favorite/page.dart';
import 'package:novellino/modules/home/binding.dart';
import 'package:novellino/modules/home/page.dart';
import 'package:novellino/modules/novels/page.dart';
import 'package:novellino/modules/read/binding.dart';
import 'package:novellino/modules/read/page.dart';
import 'package:novellino/modules/sites/binding.dart';
import 'package:novellino/modules/sites/page.dart';
import 'package:novellino/modules/splash/page.dart';
part 'routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: Routes.SPLASH, page: () => const SplashPage()),
    GetPage(
        name: Routes.HOME,
        page: () => HomePage(),
        bindings: [HomeBinding(), SiteBinding()]),
    GetPage(
        name: Routes.SITES,
        page: () => const SitesPage(),
        binding: SiteBinding()),
    GetPage(name: Routes.NOVELS, page: () => NovelsPage()),
    GetPage(
        name: Routes.CHAPTERS,
        page: () => ChaptersPage(),
        binding: ChaptersBinding()),
    GetPage(
        name: Routes.READCHAPTER,
        page: () => ReadChapterPage(),
        bindings: [ReadChapterBinding(), SiteBinding()]),
    GetPage(name: Routes.FAVORITE, page: () => FavoritePage()),
  ];
}
