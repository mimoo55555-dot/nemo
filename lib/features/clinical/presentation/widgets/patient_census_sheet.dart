import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/utils/extensions/context_extension.dart';
import 'package:nemoventrt/features/clinical/logic/patient_cubit.dart';
import 'package:nemoventrt/features/clinical/logic/patient_state.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/admit_patient_bottom_sheet.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/patient_census_content_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/patient_discharge_dialog_widget.dart';

class PatientCensusSheet extends StatefulWidget {
  const PatientCensusSheet({super.key});

  @override
  State<PatientCensusSheet> createState() => _PatientCensusSheetState();
}

class _PatientCensusSheetState extends State<PatientCensusSheet> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) => BlocBuilder<PatientCubit, PatientState>(
    buildWhen: (previous, current) =>
        previous.status != current.status ||
        previous.patients != current.patients ||
        previous.selectedPatientId != current.selectedPatientId ||
        previous.categoryFilter != current.categoryFilter ||
        previous.errorMessage != current.errorMessage,
    builder: (context, state) => PatientCensusContentWidget(
      state: state,
      searchQuery: _searchQuery,
      onSearchChanged: (value) => setState(() => _searchQuery = value),
      onFilterChanged: PatientCubit.get(context).filterPatientsByCategory,
      onSelectPatient: (patient) {
        PatientCubit.get(context).selectPatient(patient.id);
        context.pop;
      },
      onDischargePatient: (patient) => _confirmDischarge(context, patient),
      onAdmitPatient: () => _showAdmitPatientSheet(context),
      onClose: () => context.pop,
    ),
  );

  void _confirmDischarge(BuildContext context, Patient patient) {
    showDialog<void>(
      context: context,
      builder: (_) => PatientDischargeDialogWidget(
        patient: patient,
        onConfirm: () => PatientCubit.get(context).dischargePatient(patient.id),
      ),
    );
  }

  void _showAdmitPatientSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: ColorsManager.transparent,
      builder: (_) => const AdmitPatientBottomSheet(),
    );
  }
}
