import 'package:flutter/material.dart';
import 'package:novellino/data/model/model.dart';
import 'package:web_scraper/web_scraper.dart';

class Lightnovelpub extends Site {
  final String url = "https://www.lightnovelpub.com";

  final String title = "LightNovelPub";

  final Logo logo = Logo(
      address:
          "https://static.lightnovelpub.com/content/img/lightnovelpub/logo.png",
      color: Colors.white);

  @override
  Future<List<Novel>> fetchNovels() {
    return fetchOngoingRelease();
  }

  @override
  Stream<List<Chapter>> fetchChapters(Novel novel) async* {
    WebScraper web = WebScraper();
    const String pattern = "#chpagedlist > ul > li > a";

    if (await web.loadFullURL("${novel.url}/chapters")) {
      List chapters = web.getElement(pattern, ["href", "title"]);

      for (var chapter in chapters.reversed) {
        String chapterTitle = chapter["attributes"]["title"];
        String chapterUrl = url + chapter["attributes"]["href"];

        novel.chapters.add(Chapter(title: chapterTitle, url: chapterUrl));
      }
    }
    yield novel.chapters;
  }

  @override
  Future<Chapter> fetchChapter(Chapter chapter) async {
    WebScraper web = WebScraper();
    const String pattern = "#chapter-container > p";

    if (await web.loadFullURL(chapter.url)) {
      chapter.text = web.getElementTitle(pattern).join("\n\n");
    }
    return chapter;
  }

  Future<List<Novel>> fetchOngoingRelease() async {
    WebScraper web = WebScraper();
    List<Novel> novels = [];
    const String pattern = "#new-novel-section > ul > li> a  ";
    const String imagePattern = "$pattern > figure > img";

    if (await web.loadFullURL(url)) {
      var novelsaddress = web.getElement(pattern, ["href", "title"]);
      var novelsimage = web.getElement(imagePattern, ["data-src"]);

      for (var i = 0; i < novelsaddress.length; i++) {
        var novel = novelsaddress[i]["attributes"];
        String image = novelsimage[i]["attributes"]["data-src"];
        String novelTitle = novel["title"].trim();
        String address = url + novel["href"];

        novels.add(Novel(
            url: address, title: novelTitle, siteTitle: title, image: image));
      }
    }
    return novels;
  }

  Future<List<Novel>> fetchWeeklyMostActive() async {
    WebScraper web = WebScraper();
    List<Novel> novels = [];
    const String pattern = "#index > section > div.section-body > ul > li > a";
    const String imagePattern =
        "#index > section > div > ul > li > a > figure > img";

    if (await web.loadFullURL(url)) {
      var novelsaddress = web.getElement(pattern, ["href", "title"]);
      var novelsimage = web.getElement(imagePattern, ["data-src"]);

      for (var i = 0; i < novelsaddress.length; i++) {
        var novel = novelsaddress[i]["attributes"];
        String image = novelsimage[i]["attributes"]["data-src"];
        String novelTitle = novel["title"].trim();
        String address = url + novel["href"];

        novels.add(Novel(
            url: address, title: novelTitle, siteTitle: title, image: image));
      }
    }

    return novels.sublist(12, 24);
  }
}
