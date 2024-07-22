import 'package:flutter/material.dart';

import 'config.dart';

final ThemeData appThemeData = ThemeData(
    primaryColor: Colors.lightGreen,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: ConfigController.mabElevation,
        backgroundColor: ConfigController.mabBackgroundColor,
        titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: ConfigController.mabFontFamily,
            fontWeight: ConfigController.mabFontWeight),
        foregroundColor: ConfigController.mabForegroundColor),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.greenAccent,
      //accentColor: Colors.blue,
      //fontFamily: 'Georgia',
      //textTheme: TextTheme(
      //  headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      //),
    ));
