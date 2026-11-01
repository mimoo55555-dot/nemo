import 'package:flutter/material.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/primary/conditional_builder.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';
import 'package:nemoventrt/features/clinical/logic/patient_state.dart';
import 'package:nemoventrt/features/clinical/presentation/screen/abg_screen.dart';
import 'package:nemoventrt/features/clinical/presentation/screen/ventilator_screen.dart';
import 'package:nemoventrt/features/clinical/presentation/screen/vitals_screen.dart';
import 'package:nemoventrt/features/clinical/presentation/screen/weaning_screen.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/no_patient_empty_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/patient_error_state_widget.dart';

class MainShellBodyWidget extends StatelessWidget {
  final PatientState state;
  final int currentTabIndex;
  final VoidCallback onRetry;
  final VoidCallback onAdmitPatient;

  const MainShellBodyWidget({
    super.key,
    required this.state,
    required this.currentTabIndex,
    required this.onRetry,
    required this.onAdmitPatient,
  });

  @override
  Widget build(BuildContext context) => ConditionalBuilder(
    loadingState:
        (state.status == PatientStatus.initial ||
            state.status == PatientStatus.loading) &&
        state.selectedPatient == null,
    errorState:
        state.status == PatientStatus.error && state.selectedPatient == null,
    emptyState:
        state.selectedPatient == null && state.status != PatientStatus.error,
    loadingBuilder: (_) => Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          verticalSpace16,
          Text(appTranslation().get('connecting_to_clinical_records')),
        ],
      ),
    ),
    errorBuilder: (_) => PatientErrorStateWidget(
      messageKey: state.errorMessage ?? 'error_unknown',
      onRetry: onRetry,
    ),
    emptyBuilder: (_) => NoPatientEmptyWidget(onAdmitPatient: onAdmitPatient),
    successBuilder: (_) {
      final patient = state.selectedPatient!;
      return switch (currentTabIndex) {
        1 => VitalsScreen(patient: patient),
        2 => WeaningScreen(patient: patient),
        3 => ABGScreen(patient: patient),
        _ => VentilatorScreen(patient: patient),
      };
    },
  );
}
