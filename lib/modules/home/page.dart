import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novellino/modules/novels/page.dart';
import 'controller.dart';

class HomePage extends GetView<HomeController> {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: NovelsPage());
  }
}
