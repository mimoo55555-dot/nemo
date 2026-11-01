import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nemoventrt/core/models/translations.dart';
import 'package:nemoventrt/features/clinical/presentation/logic/auth_cubit.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/more_modules_sheet.dart';
import 'package:nemoventrt/core/utils/cubit/theme/theme_cubit.dart';

void main() {
  testWidgets('MoreModulesSheet renders clinician card and modules', (
    tester,
  ) async {
    final translations = await rootBundle.loadString(
      'assets/translations/en.json',
    );
    ThemeCubit.currentTranslation = TranslationModel.fromJson(
      jsonDecode(translations),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthCubit>(
          create: (_) => AuthCubit()..init(),
          child: const Scaffold(
            body: MoreModulesSheet(),
          ),
        ),
      ),
    );

    expect(find.text('Clinical Suite & Tools'), findsOneWidget);
    expect(find.text('Marcus Vance'), findsOneWidget);
    expect(find.text('ADVANCED MODULES'), findsOneWidget);
  });
}
