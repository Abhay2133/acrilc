import 'package:flutter/material.dart';

class AppColor {
  /// This should be set manually by the app's theme mode change listener
  static late bool isDarkMode;

  /// Helper method to choose color based on dark mode
  static Color _themeColor({required Color dark, required Color light}) {
    return AppColor.isDarkMode ? dark : light;
  }

  // Primary
  static Color get primary =>
      _themeColor(dark: const Color(0xFF171212), light: Color(0xFFFFFFFF));

  // Background
  static Color get background => _themeColor(
    dark: const Color(0xFF171212),
    light: const Color(0xFFFDFDFD),
  );

  // Text
  static Color get primaryText => _themeColor(
    dark: const Color(0xFFDACACA),
    light: const Color(0xFF1A1A1A),
  );

  static Color get secondaryText => _themeColor(
    dark: const Color(0xFF9C8F8F),
    light: const Color(0xFF6D6D6D),
  );

  // Button
  static Color get primaryButton => _themeColor(
    dark: const Color(0xFF834C3D),
    light: const Color(0xFFE95E41),
  );

  // Secondary
  static Color get secondary => _themeColor(
    dark: const Color(0xFF382B29),
    light: const Color(0xFFE8E2E1),
  );

  // Accent / Primary Color
  static Color get primaryColor => _themeColor(
    dark: const Color(0xFFE34A1C),
    light: const Color.fromARGB(255, 255, 101, 59),
  );

  // Neutral background shades from 100 to 900
  static Color get neutral100 => _themeColor(
    dark: const Color(0xFF2A2A2A),
    light: const Color(0xFFF5F5F5),
  );
  static Color get neutral200 => _themeColor(
    dark: const Color(0xFF3A3A3A),
    light: const Color(0xFFE5E5E5),
  );
  static Color get neutral300 => _themeColor(
    dark: const Color(0xFF4A4A4A),
    light: const Color(0xFFD4D4D4),
  );
  static Color get neutral400 => _themeColor(
    dark: const Color(0xFF5A5A5A),
    light: const Color(0xFFA3A3A3),
  );
  static Color get neutral500 => _themeColor(
    dark: const Color(0xFF6B6B6B),
    light: const Color(0xFF737373),
  );
  static Color get neutral600 => _themeColor(
    dark: const Color(0xFF8A8A8A),
    light: const Color(0xFF525252),
  );
  static Color get neutral700 => _themeColor(
    dark: const Color(0xFFA3A3A3),
    light: const Color(0xFF404040),
  );
  static Color get neutral800 => _themeColor(
    dark: const Color(0xFFCCCCCC),
    light: const Color(0xFF262626),
  );
  static Color get neutral900 => _themeColor(
    dark: const Color(0xFFE5E5E5),
    light: const Color(0xFF171717),
  );

  // Border Colors
  static Color get lightBorder => _themeColor(
    dark: const Color(0x33ffffff), // neutral400
    light: const Color(0x00033000), // neutral300
  );

  static Color get primaryBorder => _themeColor(
    dark: const Color(0xFF5A5A5A), // neutral400
    light: const Color(0xFFD4D4D4), // neutral300
  );

  static Color get secondaryBorder => _themeColor(
    dark: const Color(0xFF3A3A3A), // neutral200
    light: const Color(0xFFE8E2E1), // secondary
  );

  static Color get dividerBorder => _themeColor(
    dark: const Color(0xFF2A2A2A), // neutral100
    light: const Color(0xFFE5E5E5), // neutral200
  );

  // chat bubble colors
  static Color get chatBubbleSenderColor => _themeColor(
    dark: const Color(0xFF3C3A36), // neutral100
    light: const Color.fromARGB(255, 113, 113, 113), // neutral200
  );

  static Color get chatBubbleReceiverColor => _themeColor(
    dark: const Color(0xFFFF9F1C), // neutral100
    light: const Color(0xFFFF9F1C), // neutral200
  );

  static Color get colorPrimaryButton => _themeColor(
    dark: const Color(0xFFE34A1C), // neutral100
    light: const Color(0xFFFF9F1C), // neutral200
  );
}
