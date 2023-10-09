import 'package:flutter/material.dart';
import 'app_colors.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
    primaryColor: lightColor,
    brightness: Brightness.light,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      //type: BottomNavigationBarType.fixed,
      selectedItemColor: lightColor,
      unselectedItemColor: Colors.grey.shade400,
    ),
    scaffoldBackgroundColor: lightGreenColor,
    appBarTheme: AppBarTheme(
        backgroundColor: lightColor,
        iconTheme: IconThemeData(color: Colors.white)),
  );
  static ThemeData darkTheme = ThemeData();
}
