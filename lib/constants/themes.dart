import 'package:flutter/material.dart';
import 'package:acrilc/constants/colors.dart';

class AppThemes {
  /// ------------------ LIGHT THEME ------------------
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: "Poppins",
    primaryColor: Colors.deepOrangeAccent,
    cardColor: const Color.fromARGB(255, 235, 235, 235),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black87),
      bodyMedium: TextStyle(color: Colors.black87),
      headlineLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        color: Colors.black54,
      ),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.deepOrangeAccent,
      // unselectedItemColor: Color(0xFFBAAD9C),
    ),

    appBarTheme: const AppBarTheme(
      // backgroundColor: Color(0xFF171212),
      // foregroundColor: Colors.white,
    ),
  );

  /// ------------------ DARK THEME ------------------
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: "Poppins",
    primaryColor: const Color(0xFF171212),
    scaffoldBackgroundColor: const Color(0xFF171212),
    cardColor: const Color(0xFF261F1C),

    colorScheme: ColorScheme.dark(
      primary: AppColor.primary,
      onPrimary: Colors.white,
      surface: Colors.grey.shade900,
      onSurface: Colors.grey,
    ),

    textTheme: const TextTheme(
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
      headlineSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black, // Consider reviewing this if black text on dark bg
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        color: Colors.white70,
      ),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF26211C),
      selectedItemColor: Colors.white,
      unselectedItemColor: Color(0xFFBAAD9C),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF171212),
      foregroundColor: Colors.white,
    ),
  );
}
