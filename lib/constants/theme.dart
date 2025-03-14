import 'package:flutter/material.dart';

class AppTheme {
  final Theme theme;
  AppTheme(this.theme);

  static Theme getTheme(String theme) {
    bool isDark = theme == "dark";
    if (theme == "system") {
      isDark =
          WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
    }
    return isDark ? DarkTheme() : LightTheme();
  }

  factory AppTheme.fromString(String theme) {
    return AppTheme(AppTheme.getTheme(theme));
  }

  ThemeData get themeData => ThemeData(
    colorScheme: ColorScheme.dark(
      primary: Colors.red,
      secondary: Colors.orange,
      onPrimary: Colors.white,
    ),
    // brightness: theme.brightness,
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF171212), // AppBar color
      foregroundColor: Colors.white, // Text color in AppBar
    ),
    primaryColor: theme.primaryColor,
    scaffoldBackgroundColor: theme.backgroundColor,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: theme.textColor),
      bodyMedium: TextStyle(color: theme.textColor),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(
        0xFF26211C,
      ),
      selectedItemColor: Colors.white, // Selected item color
      unselectedItemColor: Color(0xFFBAAD9C), // Unselected item color
    ),
  );
}

// Abstract Parent Class
abstract class Theme {
  final Color primaryColor;
  final Color backgroundColor;
  final Color textColor;
  final Brightness brightness;

  const Theme({
    required this.brightness,
    required this.primaryColor,
    required this.backgroundColor,
    required this.textColor,
  });
}

// Dark Theme
class DarkTheme extends Theme {
  const DarkTheme()
    : super(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF171212),
        backgroundColor: const Color.fromARGB(177, 23, 18, 18),
        textColor: const Color(0xFFCCCCCC),
      );
}

// Light Theme
class LightTheme extends DarkTheme {
  const LightTheme() : super();
  //   brightness: Brightness.light,
  //   primaryColor: const Color(0xFFFFFFFF),
  //   backgroundColor: const Color(0xFFF0F0F0),
  //   textColor: const Color(0xFF000000),
  // );
}
