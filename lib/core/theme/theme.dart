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
          error: darkMode ? ColorsManager.darkRed : ColorsManager.lightRed,
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
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 18),
          backgroundColor: ColorsManager.primary,
          foregroundColor: ColorsManager.white,
          elevation: 0,
          textStyle: TextStylesManager.buttonLabel,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: ColorsManager.primaryText,
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 14),
          textStyle: TextStylesManager.body.copyWith(
            color: ColorsManager.primaryText,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
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
          borderSide: BorderSide(
            color: ColorsManager.primaryText,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: ColorsManager.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: ColorsManager.red, width: 1.5),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 72,
        backgroundColor: surface,
        indicatorColor: ColorsManager.primaryLight,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return TextStylesManager.caption.copyWith(
            color: selected ? ColorsManager.primaryText : secondaryText,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? ColorsManager.primaryText : secondaryText,
          );
        }),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surface,
        modalBackgroundColor: surface,
        surfaceTintColor: ColorsManager.transparent,
        showDragHandle: false,
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
        activeTrackColor: ColorsManager.primaryText,
        inactiveTrackColor: border,
        thumbColor: ColorsManager.primaryText,
        overlayColor: ColorsManager.primaryText.withValues(alpha: 0.12),
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
