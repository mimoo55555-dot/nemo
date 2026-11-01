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
      return Column(
        children: [
          SwitchListTile(
            contentPadding: const EdgeInsetsDirectional.fromSTEB(
              16,
              4,
              16,
              4,
            ),
            secondary: Icon(
              Icons.dark_mode_outlined,
              color: ColorsManager.primaryText,
            ),
            title: Text(
              appTranslation().get('dark_mode'),
              style: TextStylesManager.body,
            ),
            value: cubit.isDarkMode,
            onChanged: (_) => cubit.changeTheme(),
          ),
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
            child: Divider(height: 1),
          ),
          ListTile(
            contentPadding: const EdgeInsetsDirectional.fromSTEB(
              16,
              4,
              16,
              4,
            ),
            leading: Icon(
              Icons.translate_rounded,
              color: ColorsManager.primaryText,
            ),
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
              loadingBuilder: (_) => const CircularProgressIndicator(
                strokeWidth: 2,
              ),
              errorBuilder: (_) => Icon(
                Icons.error_outline,
                color: ColorsManager.red,
              ),
              successBuilder: (_) => Icon(
                Icons.arrow_forward_rounded,
                color: ColorsManager.grey,
              ),
            ),
            onTap: state is ThemeLanguageLoadingState
                ? null
                : cubit.toggleLanguage,
          ),
        ],
      );
    },
  );
}
