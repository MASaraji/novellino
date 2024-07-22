import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part "model.g.dart";

abstract class Site {
  //String url;
  //String title;
  //Logo logo;
  Future<List<Novel>> fetchNovels() {
    throw UnimplementedError();
  }

  //Future<List<Chapter>>
  Stream<List<Chapter>> fetchChapters(Novel novel) {
    throw UnimplementedError();
  }

  Future<Chapter> fetchChapter(Chapter chapter) {
    throw UnimplementedError();
  }

  /*Map<String, dynamic> toJson() {
    return {
      title: {
        "title": title,
        "url": url,
      },
    };
  }*/
}

@HiveType(typeId: 1)
class Novel {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String url;

  @HiveField(2)
  final String image;

  @HiveField(3)
  final String siteTitle;

  List<Chapter> chapters = [];

  Novel(
      {required this.url,
      required this.title,
      required this.siteTitle,
      this.image = ''});

  Map<String, dynamic> toJson() {
    return {
      title: {
        "title": title,
        "url": url,
        "image": image,
      },
    };
  }
}

class Logo {
  final String address;
  final Color color;
  final Color colorText;
  Logo(
      {required this.address,
      required this.color,
      this.colorText = Colors.black});
}

class Chapter {
  final String title;
  late String text;
  final String url;
  Chapter({required this.title, required this.url});
}
