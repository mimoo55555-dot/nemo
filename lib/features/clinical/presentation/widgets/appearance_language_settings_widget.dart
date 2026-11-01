import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/primary/conditional_builder.dart';
import 'package:nemoventrt/core/utils/cubit/theme/theme_cubit.dart';
import 'package:nemoventrt/core/utils/cubit/theme/theme_state.dart';

class AppearanceLanguageSettingsWidget extends StatelessWidget {
  const AppearanceLanguageSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<ThemeCubit, ThemeState>(
    buildWhen: (previous, current) =>
        current is ThemeChangeThemeState ||
        current is ThemeLanguageUpdatedState ||
        current is ThemeLanguageLoadingState ||
        current is ThemeLanguageErrorState,
    builder: (context, state) {
      final cubit = ThemeCubit.get(context);
      return Card(
        color: ColorsManager.surface,
        child: Column(
          children: [
            SwitchListTile(
              title: Text(
                appTranslation().get('dark_mode'),
                style: TextStylesManager.body,
              ),
              value: cubit.isDarkMode,
              onChanged: (_) => cubit.changeTheme(),
            ),
            ListTile(
              title: Text(
                appTranslation().get('app_language'),
                style: TextStylesManager.body,
              ),
              subtitle: Text(
                appTranslation().get(
                  cubit.isArabicLang ? 'language_arabic' : 'language_english',
                ),
                style: TextStylesManager.bodySmall,
              ),
              trailing: ConditionalBuilder(
                loadingState: state is ThemeLanguageLoadingState,
                errorState: state is ThemeLanguageErrorState,
                loadingBuilder: (_) => const CircularProgressIndicator(),
                errorBuilder: (_) => const Icon(Icons.error_outline),
                successBuilder: (_) => const Icon(Icons.language),
              ),
              onTap: state is ThemeLanguageLoadingState
                  ? null
                  : cubit.toggleLanguage,
            ),
          ],
        ),
      );
    },
  );
}
