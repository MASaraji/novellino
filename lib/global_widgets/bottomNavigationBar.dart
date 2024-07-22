import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/home/controller.dart';

HomeController controller1 = Get.find<HomeController>();
final List navigationButtons = [
  ["home", Icons.home],
  ["search", Icons.search],
  ["favorite", Icons.favorite],
  ["sites", Icons.map],
  ["settings", Icons.settings]
];

List<BottomNavigationBarItem> items = navigationButtons
    .map((e) => BottomNavigationBarItem(label: e[0], icon: Icon(e[1])))
    .toList();

BottomNavigationBar customNavBar() => BottomNavigationBar(
      items: items,
      onTap: (value) => controller1.changePage(value),
      currentIndex: 0,
    );
