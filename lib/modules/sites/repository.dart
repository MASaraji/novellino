import '../../data/model/model.dart';
import '../../data/provider/eat.dart';
import '../../data/provider/lightnovelpub.dart';
import '../../data/provider/reaperscans.dart';
import '../../data/provider/reaperscansfr.dart';
import '../../data/provider/skydemonorder.dart';

class SiteRepository {
  //final MyApi api;
  late Site _site = getSite("EAT");
  get site => _site;
  set site(value) => _site = sitesTitle[value] ?? EAT();

  SiteRepository(); //this.api);
  Map<String, Site> sitesTitle = {
    "SkyDemonOrder": SkyDemonOrder(),
    "ReaperScans": ReaperScans(),
    "EAT": EAT(),
    "LightNovelPub": Lightnovelpub(),
    "ReaperScansFr": ReaperScansFr(),
  };
  siteIndex(index) {
    site = getSite(getTitle(index));
  }

  List titles() => sitesTitle.keys.toList();
  getSite(String title) => sitesTitle[title] ?? sitesTitle["EAT"];
  getTitle(index) => titles()[index];
}
