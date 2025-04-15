import 'package:acrilc/constants/colors.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: "Poppins",
    cardColor: Color.fromARGB(255, 235, 235, 235),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black87),
      bodyMedium: TextStyle(color: Colors.black87),
      headlineLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      titleMedium: TextStyle(fontSize: 16, color: Colors.black54),
      headlineMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.deepOrangeAccent, // Selected item color
      // unselectedItemColor: Color(0xFFBAAD9C), // Unselected item color
    ),
    appBarTheme: AppBarTheme(
      // backgroundColor: Color(0xFF171212), // AppBar color
      // foregroundColor: Colors.white, // Text color in AppBar
    ),
    primaryColor: Colors.deepOrangeAccent
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: "Poppins",
    colorScheme: ColorScheme.dark(
      primary: AppColor.primary,
      onPrimary: Colors.white,
      surface: Colors.grey[900]!,
      onSurface: Colors.grey, // Text color on surfaces
    ),
    primaryColor: const Color(0xFF171212),
    cardColor: Color(0xFF261F1C),
    scaffoldBackgroundColor: const Color(0xFF171212),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white70),
      bodyMedium: TextStyle(color: Colors.white60),
      headlineLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleMedium: TextStyle(fontSize: 16, color: Colors.white70),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF26211C),
      selectedItemColor: Colors.white, // Selected item color
      unselectedItemColor: Color(0xFFBAAD9C), // Unselected item color
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF171212), // AppBar color
      foregroundColor: Colors.white, // Text color in AppBar
    ),
  );
}
