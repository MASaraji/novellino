import 'package:flutter/material.dart';
import 'package:novellino/data/model/model.dart';
import 'package:web_scraper/web_scraper.dart';

class EAT extends Site {
  final String url = "https://eatapplepies.com/";
  final String title = "EAT";
  final Logo logo = Logo(
      address:
          "https://eatapplepies.com/wp-content/uploads/2020/11/RAON-header.png",
      color: Colors.white);

  @override
  Future<List<Novel>> fetchNovels() async {
    // ignore: non_constant_identifier_names
    Novel TCF = Novel(
        url: "https://eatapplepies.com/mybookmarks/tcf-table-of-contents/",
        title: "Trash of the Count's Family",
        siteTitle: title,
        image:
            "https://cdn.novelupdates.com/images/2022/10/Trash-of-the-Counts-Family.jpg");
    // ignore: non_constant_identifier_names
    Novel TWSB = Novel(
        url: "https://eatapplepies.com/mybookmarks/twsb-table-of-contents/",
        title: "What Happens When the Second Male Lead Powers Up",
        siteTitle: title,
        image:
            "https://cdn.novelupdates.com/images/2021/01/What-Happens-When-the-Second-Male-Lead-Powers-Up.jpg");
    return [TCF, TWSB];
  }

  @override
  Future<Chapter> fetchChapter(Chapter chapter) async {
    WebScraper site = WebScraper();
    const String textPattern = "article > div >p";

    if (await site.loadFullURL(chapter.url)) {
      chapter.text = site.getElementTitle(textPattern).join("\n\n");
    }
    return chapter;
  }

  @override
  Stream<List<Chapter>> fetchChapters(Novel novel) async* {
    WebScraper site = WebScraper();
    const String chapterPattern = " div > details > p > a";

    if (await site.loadFullURL(novel.url)) {
      List address = site.getElement(chapterPattern, ["href"]);

      for (var chapter in address.reversed) {
        String chapterTitle = chapter["title"].substring(2).trim();
        String chapterUrl = chapter["attributes"]["href"];
        novel.chapters.add(Chapter(title: chapterTitle, url: chapterUrl));
      }
    }
    yield novel.chapters;
  }
}
