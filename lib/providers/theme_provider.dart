import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  late String _savedTheme;

  ThemeMode get themeMode => _themeMode;
  String get savedTheme => _savedTheme;

  ThemeProvider() {
    _loadTheme(); // Load saved theme on startup
  }

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _savedTheme = prefs.getString("theme") ?? "system";

    if (_savedTheme == "light") {
      _themeMode = ThemeMode.light;
    } else if (_savedTheme == "dark") {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.system;
    }

    notifyListeners();
  }

  void setTheme(String theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("theme", theme);
    _savedTheme = theme;

    if (theme == "light") {
      _themeMode = ThemeMode.light;
    } else if (theme == "dark") {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.system;
    }

    notifyListeners(); // Notify the app to rebuild with the new theme
  }
}
