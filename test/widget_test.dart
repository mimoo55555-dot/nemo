import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nemoventrt/features/clinical/presentation/bloc/auth_cubit.dart';
import 'package:nemoventrt/features/clinical/presentation/screens/more_sheet.dart';

void main() {
  testWidgets('MoreModulesSheet renders clinician card and modules', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(),
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
