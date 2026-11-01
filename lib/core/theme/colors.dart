import 'package:flutter/material.dart';

abstract final class ColorsManager {
  static bool _isDarkMode = false;

  static bool get isDarkMode => _isDarkMode;

  static void setDarkMode(bool value) => _isDarkMode = value;

  static const primary = Color(0xFF0F766E);
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const red = Color(0xFFDC2626);
  static const orange = Color(0xFFEA580C);
  static const amber = Color(0xFFB45309);
  static const blue = Color(0xFF2563EB);
  static const green = Color(0xFF16A34A);
  static const purple = Color(0xFF9333EA);
  static const indigo = Color(0xFF4F46E5);
  static const transparent = Color(0x00000000);

  static const lightBackground = Color(0xFFF3F6FA);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightTextPrimary = Color(0xFF17212F);
  static const lightTextSecondary = Color(0xFF64748B);
  static const lightBorder = Color(0xFFE2E8F0);
  static const lightSubtleSurface = Color(0xFFF1F5F9);

  static const darkBackground = Color(0xFF0B1220);
  static const darkSurface = Color(0xFF151F30);
  static const darkElevatedSurface = Color(0xFF1D2A3D);
  static const darkTextPrimary = Color(0xFFE8EEF7);
  static const darkTextSecondary = Color(0xFFA6B4C7);
  static const darkBorder = Color(0xFF2B3A50);

  static Color get background => _isDarkMode ? darkBackground : lightBackground;
  static Color get surface => _isDarkMode ? darkSurface : lightSurface;
  static Color get elevatedSurface =>
      _isDarkMode ? darkElevatedSurface : lightSubtleSurface;
  static Color get textPrimary =>
      _isDarkMode ? darkTextPrimary : lightTextPrimary;
  static Color get textOnDark => darkTextPrimary;
  static Color get textSecondary =>
      _isDarkMode ? darkTextSecondary : lightTextSecondary;
  static Color get border => _isDarkMode ? darkBorder : lightBorder;
  static Color get grey => _isDarkMode ? darkTextSecondary : lightTextSecondary;
  static Color get lightGrey =>
      _isDarkMode ? darkElevatedSurface : lightSubtleSurface;
  static Color get blueGrey =>
      _isDarkMode ? const Color(0xFF8FA3BA) : const Color(0xFF607D8B);

  static Color get primaryLight =>
      _isDarkMode ? const Color(0xFF173A38) : const Color(0xFFE1F5F2);
  static Color get purpleLight =>
      _isDarkMode ? const Color(0xFF30223D) : const Color(0xFFFAF5FF);
  static Color get redLight =>
      _isDarkMode ? const Color(0xFF3C242B) : const Color(0xFFFEE2E2);
  static Color get amberLight =>
      _isDarkMode ? const Color(0xFF3D321F) : const Color(0xFFFFF7DB);
}
