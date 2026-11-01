import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';

abstract final class TextStylesManager {
  static TextStyle get headline => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: ColorsManager.textPrimary,
  );

  static TextStyle get title => TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: ColorsManager.textPrimary,
  );

  static TextStyle get subtitle => TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: ColorsManager.textPrimary,
  );

  static TextStyle get body => TextStyle(
    fontSize: 14,
    height: 1.45,
    color: ColorsManager.textPrimary,
  );

  static TextStyle get bodySmall => TextStyle(
    fontSize: 13,
    height: 1.4,
    color: ColorsManager.textSecondary,
  );

  static TextStyle get caption => TextStyle(
    fontSize: 12,
    height: 1.35,
    color: ColorsManager.textSecondary,
  );

  static TextStyle get sectionTitle => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: ColorsManager.textPrimary,
  );

  static TextStyle get metricValue => TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: ColorsManager.textPrimary,
  );

  static const buttonLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: ColorsManager.white,
  );
}
