import 'package:acrillic/constants/colors.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(fontFamily: "Poppins");

  static final ThemeData darkTheme = ThemeData(
    fontFamily: "Poppins",
    colorScheme: ColorScheme.dark(
      primary: AppColor.primary,
      onPrimary: Colors.white,
      surface: Colors.grey[900]!,
      onSurface: Colors.grey, // Text color on surfaces
    ),
    primaryColor: const Color(0xFF171212),

    scaffoldBackgroundColor: AppColor.primary,
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF171212), // AppBar color
      foregroundColor: Colors.white, // Text color in AppBar
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white70),
      bodyMedium: TextStyle(color: Colors.white60),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF26211C),
      selectedItemColor: Colors.white, // Selected item color
      unselectedItemColor: Color(0xFFBAAD9C), // Unselected item color
    ),
  );
}
