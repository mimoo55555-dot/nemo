import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemoventrt/core/utils/cubit/theme/theme_cubit.dart';
import 'package:nemoventrt/core/utils/cubit/theme/theme_state.dart';

class ThemeBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ThemeState state) builder;

  const ThemeBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) => BlocBuilder<ThemeCubit, ThemeState>(
    buildWhen: (previous, current) =>
        current is ThemeChangeThemeState ||
        current is ThemeLanguageUpdatedState,
    builder: builder,
  );
}
