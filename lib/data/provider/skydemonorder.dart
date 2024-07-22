import 'package:flutter/material.dart';
import '../model/model.dart';
import 'package:web_scraper/web_scraper.dart';

class SkyDemonOrder extends Site {
  String title = "SkyDemonOrder";
  String url = "https://skydemonorder.com/";
  Logo logo = Logo(address: "", color: Colors.white);

  @override
  Future<List<Novel>> fetchNovels() async {
    List<Novel> novels = [];
    const String addressPattern =
        r"body > div.min-h-screen.bg-primary-50 > main > div > div > a";
    const String imagePattern =
        "body > div.min-h-screen.bg-primary-50 > main > div > div > a > div.aspect-w-2.aspect-h-3.w-full.overflow-hidden.rounded-xl > img";
    final WebScraper site = WebScraper();

    if (await site.loadFullURL(url)) {
      final address = site.getElement(addressPattern, ["href", "img"]);
      print(address);
      for (var novel in address) {
        String name = novel["attributes"]["href"];
        String baseUrl = url + name;
        String novelTitle = novel["title"];
        String imageAddress =
            "https://skydemonorder.com/_next/image?url=%2F%2Fimages%2F$name-cover.png&w=1920&q=75";

        novels.add(Novel(
            title: novelTitle,
            siteTitle: title,
            url: baseUrl,
            image: imageAddress));
      }
    }
    return novels;
  }

  @override
  Stream<List<Chapter>> fetchChapters(Novel novel) async* {
    novel.chapters = [];
    final novelAddress = WebScraper();
    const String addressPattern = "div>div>h3>a";
    String numberOfPagePattern =
        r"#__next > div > div > main > div.pt-6.pb-8.space-y-2.md\:space-y-5 > nav > span";

    if (await novelAddress.loadFullURL(novel.url)) {
      String numberOFPage =
          novelAddress.getElementTitle(numberOfPagePattern)[0].split(" ")[2];
      int numberOfPage = int.parse(numberOFPage);

      for (var i = 1; i <= numberOfPage; i++) {
        if (await novelAddress.loadFullURL("${novel.url}/page/$i")) {
          final chaptersAddress =
              novelAddress.getElement(addressPattern, ["href"]);

          for (var chapter in chaptersAddress) {
            String baseUrl = url + chapter["attributes"]["href"];
            String chapterTitle = chapter["title"];

            novel.chapters.add(Chapter(url: baseUrl, title: chapterTitle));
          }

          yield novel.chapters;
        }
      }
    }
    //return chapters;
  }

  @override
  Future<Chapter> fetchChapter(Chapter chapter) async {
    final chapterAddress = WebScraper();
    const String textPattern = "p";
    if (await chapterAddress.loadFullURL(chapter.url)) {
      chapter.text = chapterAddress.getElementTitle(textPattern).join("\n\n");
    }
    return chapter;
  }
}
