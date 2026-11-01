import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemoventrt/core/models/translations.dart';
import 'package:nemoventrt/core/network/local/cache_helper.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/utils/cubit/theme/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitialState());

  static ThemeCubit get(BuildContext context) => BlocProvider.of(context);

  bool _isDarkMode = false;
  static bool currentIsDarkMode = false;
  static TranslationModel? currentTranslation;
  bool _isArabicLang = false;
  TranslationModel? _translationModel;

  bool get isDarkMode => _isDarkMode;
  bool get isArabicLang => _isArabicLang;

  Future<void> init({
    required bool isDark,
    required bool isArabic,
    required String translations,
  }) async {
    changeTheme(fromShared: isDark);
    await changeLanguage(isArabic: isArabic, translations: translations);
  }

  void changeTheme({bool? fromShared}) {
    _isDarkMode = fromShared ?? !_isDarkMode;
    currentIsDarkMode = _isDarkMode;
    ColorsManager.setDarkMode(_isDarkMode);
    unawaited(CacheHelper.saveData(key: 'isDark', value: _isDarkMode));
    emit(ThemeChangeThemeState());
  }

  Future<void> changeLanguage({
    required bool isArabic,
    required String translations,
  }) async {
    try {
      if (_isArabicLang == isArabic && _translationModel != null) {
        currentTranslation = _translationModel;
        emit(ThemeLanguageUpdatedState());
        return;
      }
      emit(ThemeLanguageLoadingState());
      _translationModel = TranslationModel.fromJson(jsonDecode(translations));
      currentTranslation = _translationModel;
      _isArabicLang = isArabic;
      emit(ThemeLanguageUpdatedState());
    } catch (_) {
      emit(ThemeLanguageErrorState('error_unknown'));
    }
  }

  Future<void> toggleLanguage() async {
    try {
      emit(ThemeLanguageLoadingState());
      final nextLanguage = !_isArabicLang;
      final source = await rootBundle.loadString(
        'assets/translations/${nextLanguage ? 'ar' : 'en'}.json',
      );
      await changeLanguage(
        isArabic: nextLanguage,
        translations: source,
      );
      await CacheHelper.saveData(key: 'isArabicLang', value: nextLanguage);
    } catch (_) {
      emit(ThemeLanguageErrorState('error_unknown'));
    }
  }
}
