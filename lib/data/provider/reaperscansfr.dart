import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';
import '../model/model.dart';

class ReaperScansFr extends Site {
  String title = "ReaperScansFr";
  String url = "https://new.reaperscans.fr/webnovel/";
  Logo logo = Logo(
      address:
          "https://reaperscans.com/wp-content/uploads/2021/07/logo-reaper-2.png",
      color: Colors.black);

  @override
  Future<List<Novel>> fetchNovels() async {
    List<Novel> novels = [];
    WebScraper site = WebScraper();
    const String addressPattern =
        r"body > div.wrap > div > div > div > div > div > div > div > div > div > div > div > div > div > div > div > div > div > div > a";
    //  const String addressPattern =
    //    r"#loop-content > div> div > div> div > div.item-summary > div.post-title.font-title > h3 > a";
    final String imagePattern = "$addressPattern > img";

    if (await site.loadFullURL(url)) {
      final address = site.getElement(
        addressPattern,
        ["href"],
      );

      final imageAddress = site.getElement(
        imagePattern,
        ["src"],
      );

      for (var i = 0; i < address.length; i++) {
        final novel = address[i];
        String novelTitle = novel["title"];
        String url = novel["attributes"]["href"];
        String image = imageAddress[i]["attributes"]["src"];

        novels.add(
            Novel(title: novelTitle, url: url, image: image, siteTitle: title));
      }
    }
    return novels;
  }

  @override
  Future<Chapter> fetchChapter(Chapter chapter) async {
    WebScraper site = WebScraper();
    const String textPattern =
        r"div > div > div > div > div > div > div > div > div > div > div > div > div > p";

    if (await site.loadFullURL(chapter.url)) {
      chapter.text = site.getElementTitle(textPattern).join("\n\n");
    }
    return chapter;
  }

  @override
  Stream<List<Chapter>> fetchChapters(Novel novel) async* {
    print("hello");
    novel.chapters = [];
    const String addressPattern =
        r"body > div.wrap > div > div > div > div.c-page-content.style-1 > div > div > div > div > div > div.c-page > div > div.page-content-listing.single-page > div > ul > li > div > a";
    const String titlePattern = "$addressPattern > p";
    final WebScraper site = WebScraper();
    if (await site.loadFullURL(novel.url)) {
      List address = site.getElement(addressPattern, ["href"]);
      List titles = site.getElementTitle(titlePattern);

      for (var i = 0; i < address.length; i++) {
        var chapter = address[i]["attributes"];
        String chapterTitle = titles[i];
        String chapterUrl = chapter["href"];

        novel.chapters.add(Chapter(title: chapterTitle, url: chapterUrl));
      }
    }
    yield novel.chapters;
  }
}
