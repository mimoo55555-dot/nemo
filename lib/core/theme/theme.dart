import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';

abstract final class AppTheme {
  static ThemeData get light => _buildTheme(
    brightness: Brightness.light,
    background: ColorsManager.lightBackground,
    surface: ColorsManager.lightSurface,
    foreground: ColorsManager.lightTextPrimary,
    secondaryText: ColorsManager.lightTextSecondary,
    border: ColorsManager.lightBorder,
    elevatedSurface: ColorsManager.lightSubtleSurface,
  );

  static ThemeData get dark => _buildTheme(
    brightness: Brightness.dark,
    background: ColorsManager.darkBackground,
    surface: ColorsManager.darkSurface,
    foreground: ColorsManager.darkTextPrimary,
    secondaryText: ColorsManager.darkTextSecondary,
    border: ColorsManager.darkBorder,
    elevatedSurface: ColorsManager.darkElevatedSurface,
  );

  static ThemeData _buildTheme({
    required Brightness brightness,
    required Color background,
    required Color surface,
    required Color foreground,
    required Color secondaryText,
    required Color border,
    required Color elevatedSurface,
  }) {
    final darkMode = brightness == Brightness.dark;
    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: ColorsManager.primary,
          brightness: brightness,
        ).copyWith(
          primary: ColorsManager.primary,
          onPrimary: ColorsManager.white,
          secondary: ColorsManager.blue,
          surface: surface,
          onSurface: foreground,
          error: ColorsManager.red,
          onError: ColorsManager.white,
          outline: border,
          surfaceContainerHighest: elevatedSurface,
        );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      canvasColor: background,
      dividerColor: border,
      splashColor: ColorsManager.primary.withValues(alpha: 0.08),
      highlightColor: ColorsManager.primary.withValues(alpha: 0.05),
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        foregroundColor: foreground,
        surfaceTintColor: ColorsManager.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 64,
        titleTextStyle: TextStylesManager.title,
        shape: Border(
          bottom: BorderSide(color: border.withValues(alpha: 0.7)),
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        surfaceTintColor: ColorsManager.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: border),
        ),
      ),
      inputDecorationTheme: InputDecorationThemeData(
        filled: true,
        fillColor: elevatedSurface,
        contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 14, 16, 14),
        hintStyle: TextStylesManager.bodySmall,
        labelStyle: TextStylesManager.bodySmall,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: ColorsManager.primary,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: ColorsManager.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: ColorsManager.red, width: 1.5),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: ColorsManager.primary,
        unselectedItemColor: secondaryText,
        selectedLabelStyle: TextStylesManager.caption.copyWith(
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: TextStylesManager.caption,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surface,
        modalBackgroundColor: surface,
        surfaceTintColor: ColorsManager.transparent,
        showDragHandle: true,
        dragHandleColor: border,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surface,
        surfaceTintColor: ColorsManager.transparent,
        elevation: darkMode ? 12 : 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: border),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: darkMode
            ? ColorsManager.darkElevatedSurface
            : ColorsManager.lightTextPrimary,
        contentTextStyle: TextStylesManager.body.copyWith(
          color: ColorsManager.white,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: ColorsManager.primary,
        inactiveTrackColor: border,
        thumbColor: ColorsManager.primary,
        overlayColor: ColorsManager.primary.withValues(alpha: 0.12),
        trackHeight: 4,
      ),
      listTileTheme: ListTileThemeData(
        iconColor: secondaryText,
        textColor: foreground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
