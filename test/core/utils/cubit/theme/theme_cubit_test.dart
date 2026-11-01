import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nemoventrt/core/di/injections.dart';
import 'package:nemoventrt/core/utils/cubit/theme/theme_cubit.dart';
import 'package:nemoventrt/core/utils/cubit/theme/theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _SharedPreferencesMock extends Mock implements SharedPreferences {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final serviceLocator = GetIt.instance;

  setUp(() async {
    await serviceLocator.reset();
    final preferences = _SharedPreferencesMock();
    when(() => preferences.setBool(any(), any())).thenAnswer((_) async => true);
    sl.registerSingleton<SharedPreferences>(preferences);
  });

  tearDown(() async {
    ThemeCubit.currentTranslation = null;
    await serviceLocator.reset();
  });

  test('initializes theme and the manually loaded translation map', () async {
    const translations = '{"app_title":"NemoVent"}';
    final cubit = ThemeCubit();

    await cubit.init(
      isDark: true,
      isArabic: false,
      translations: translations,
    );

    expect(cubit.isDarkMode, isTrue);
    expect(cubit.isArabicLang, isFalse);
    expect(ThemeCubit.currentTranslation?.get('app_title'), 'NemoVent');
    expect(cubit.state, isA<ThemeLanguageUpdatedState>());
    await cubit.close();
  });

  test('loads Arabic JSON and persists the selected language', () async {
    final source = await rootBundle.loadString('assets/translations/ar.json');
    final preferences = sl<SharedPreferences>() as _SharedPreferencesMock;
    final cubit = ThemeCubit();
    await cubit.changeLanguage(isArabic: false, translations: source);

    await cubit.toggleLanguage();

    expect(cubit.isArabicLang, isTrue);
    expect(ThemeCubit.currentTranslation?.get('app_title'), isNotEmpty);
    verify(() => preferences.setBool('isArabicLang', true)).called(1);
    await cubit.close();
  });
}
