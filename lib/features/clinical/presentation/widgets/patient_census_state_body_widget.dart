import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/primary/conditional_builder.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';
import 'package:nemoventrt/features/clinical/logic/patient_state.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/patient_census_no_results_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/patient_census_tile_widget.dart';

class PatientCensusStateBodyWidget extends StatelessWidget {
  final PatientState state;
  final String searchQuery;
  final ValueChanged<Patient> onSelectPatient;
  final ValueChanged<Patient> onDischargePatient;

  const PatientCensusStateBodyWidget({
    super.key,
    required this.state,
    required this.searchQuery,
    required this.onSelectPatient,
    required this.onDischargePatient,
  });

  @override
  Widget build(BuildContext context) {
    final patients = state.patients
        .where((patient) {
          final categoryMatches =
              state.categoryFilter == 'all' ||
              patient.category.name == state.categoryFilter;
          final query = searchQuery.trim().toLowerCase();
          final searchMatches =
              query.isEmpty ||
              translateKnownValue(patient.bed).toLowerCase().contains(query) ||
              patient.bed.toLowerCase().contains(query) ||
              translateKnownValue(patient.fullName)
                  .toLowerCase()
                  .contains(query) ||
              patient.fullName.toLowerCase().contains(query) ||
              patient.mrn.toLowerCase().contains(query) ||
              translateKnownValue(patient.diagnosis)
                  .toLowerCase()
                  .contains(query) ||
              patient.diagnosis.toLowerCase().contains(query);
          return categoryMatches && searchMatches;
        })
        .toList(growable: false);
    return ConditionalBuilder(
      loadingState:
          state.status == PatientStatus.loading && state.patients.isEmpty,
      errorState: state.status == PatientStatus.error && state.patients.isEmpty,
      emptyState: patients.isEmpty,
      loadingBuilder: (_) => const Center(child: CircularProgressIndicator()),
      errorBuilder: (_) => Center(
        child: Text(
          appTranslation().get(state.errorMessage ?? 'error_unknown'),
        ),
      ),
      emptyBuilder: (_) => const PatientCensusNoResultsWidget(),
      successBuilder: (_) => ListView.separated(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
        itemCount: patients.length,
        separatorBuilder: (_, _) => verticalSpace8,
        itemBuilder: (_, index) {
          final patient = patients[index];
          final selected = state.selectedPatientId == null
              ? index == 0
              : state.selectedPatientId == patient.id;
          return PatientCensusTileWidget(
            patient: patient,
            isSelected: selected,
            onTap: () => onSelectPatient(patient),
            onDischarge: () => onDischargePatient(patient),
          );
        },
      ),
    );
  }
}
