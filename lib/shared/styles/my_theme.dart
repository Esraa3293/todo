import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: lightColor,
      ),
      bodySmall: GoogleFonts.roboto(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Colors.black54,
      ),
    ),
    appBarTheme: AppBarTheme(
        backgroundColor: lightColor,
        iconTheme: IconThemeData(color: lightColor)),
  );
  static ThemeData darkTheme = ThemeData();
}
