import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nemoventrt/core/bloc/app_bloc_observer.dart';
import 'package:nemoventrt/core/di/injections.dart';
import 'package:nemoventrt/core/network/clinical_network_service.dart';
import 'package:nemoventrt/core/theme/theme.dart';
import 'package:nemoventrt/core/utils/constants/primary/theme_builder.dart';
import 'package:nemoventrt/core/utils/cubit/theme/theme_cubit.dart';
import 'package:nemoventrt/features/clinical/logic/patient_cubit.dart';
import 'package:nemoventrt/features/clinical/presentation/logic/auth_cubit.dart';
import 'package:nemoventrt/features/clinical/presentation/screen/main_shell_screen.dart';
import 'package:nemoventrt/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Bloc Observer for monitoring state transitions and events
  Bloc.observer = AppBlocObserver();

  // Initialize Firebase (Firestore & Authentication)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initInjections();
  final preferences = sl<SharedPreferences>();
  final isDark = preferences.getBool('isDark') ?? false;
  final isArabic =
      preferences.getBool('isArabicLang') ??
      WidgetsBinding.instance.platformDispatcher.locale.languageCode == 'ar';
  final translations = await rootBundle.loadString(
    'assets/translations/${isArabic ? 'ar' : 'en'}.json',
  );

  runApp(
    NemoVentApp(
      isDark: isDark,
      isArabic: isArabic,
      translations: translations,
    ),
  );
}

class NemoVentApp extends StatelessWidget {
  final bool isDark;
  final bool isArabic;
  final String translations;

  const NemoVentApp({
    super.key,
    required this.isDark,
    required this.isArabic,
    required this.translations,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (_) => sl<ThemeCubit>()
            ..init(
              isDark: isDark,
              isArabic: isArabic,
              translations: translations,
            ),
        ),
        BlocProvider<PatientCubit>(
          create: (_) => sl<PatientCubit>()..init(sl<ClinicalNetworkService>()),
        ),
        BlocProvider<AuthCubit>(
          create: (_) => sl<AuthCubit>()..init(),
        ),
      ],
      child: ThemeBuilder(
        builder: (context, state) => MaterialApp(
          title: ThemeCubit.currentTranslation?.get('app_title') ?? '',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeCubit.get(context).isDarkMode
              ? ThemeMode.dark
              : ThemeMode.light,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          home: const MainShellScreen(),
          builder: (context, child) => Directionality(
            textDirection: ThemeCubit.get(context).isArabicLang
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: child!,
          ),
        ),
      ),
    );
  }
}
