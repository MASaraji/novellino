import 'package:get/get.dart';
import '../../data/model/model.dart';
import '../../data/services/favorite/service.dart';

class ChapterController extends GetxController {
  late Chapter chapter = novel.chapters[index];
  late Novel novel;
  int index = 0;
  void setChapter(int index_) {
    if (index_ <= novel.chapters.length) {
      chapter = novel.chapters[index_];
      index = index_;
    }
  }

  void nextChapter() {
    if (index - 1 >= 0) {
      index--;
      chapter = novel.chapters[index];
      Get.snackbar("Next Chapter", "name:${chapter.title}");
      update();
    } else {
      Get.snackbar("Last Chapter", "");
    }
  }

  void previousChapter() {
    if (index + 1 <= novel.chapters.length) {
      index++;
      chapter = novel.chapters[index];
      Get.snackbar("previous Chapter", "name:${chapter.title}");
      update();
    } else {
      Get.snackbar("First Chapter", "");
    }
  }
}

class ChaptersController extends GetxController {
  late Novel novel;
  Favorite favorite = Get.find<Favorite>();
  ChaptersController();
  setNovel(value) => novel = value;
  void saveDelete() {
    if (favorite.isFavorite(novel.title)) {
      favorite.delete(novel.title);
      update();
    } else {
      favorite.add(novel.title, novel);
      update();
    }
  }
}
