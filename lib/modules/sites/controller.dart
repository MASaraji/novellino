import 'package:get/get.dart';
import 'package:novellino/modules/sites/repository.dart';

class SiteController extends GetxController {
  final SiteRepository repository;
  SiteController(this.repository);

  site(title) => repository.site = title;
  siteIndex(index) {
    repository.siteIndex(index);
  }

  getSite() => repository.site;
  siteTitle(int index) => repository.titles()[index];
  List titles() => repository.titles();
  getSiteArg(name) => repository.getSite(name);
}
