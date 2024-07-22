import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../model/model.dart';

class Favorite extends GetxService {
  late Box box = Hive.box("favorite");
  Future<Favorite> init() async {
    return this;
  }

  ValueListenable<Box<dynamic>> listen() => box.listenable();
  bool isFavorite(String title) => box.containsKey(title);
  void delete(String title) => box.delete(title);
  void add(String title, Novel novel) => box.put(title, novel);
}
