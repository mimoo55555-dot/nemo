import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/features/clinical/logic/patient_cubit.dart';
import 'package:nemoventrt/features/clinical/logic/patient_state.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/alerts_dialog_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/admit_patient_bottom_sheet.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/main_shell_app_bar_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/main_shell_body_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/main_shell_navigation_bar_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/more_modules_sheet.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/patient_census_sheet.dart';

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) => BlocBuilder<PatientCubit, PatientState>(
    buildWhen: (previous, current) =>
        previous.status != current.status ||
        previous.patients != current.patients ||
        previous.selectedPatientId != current.selectedPatientId ||
        previous.categoryFilter != current.categoryFilter ||
        previous.errorMessage != current.errorMessage,
    builder: (context, state) => Scaffold(
      appBar: MainShellAppBarWidget(
        patient: state.selectedPatient,
        alertCount: state.totalUnacknowledgedAlerts,
        onOpenCensus: _openPatientCensus,
        onOpenAlerts: () => showDialog<void>(
          context: context,
          builder: (_) => const AlertsDialogWidget(),
        ),
        onOpenMore: () => _openMoreSheet(state.selectedPatient),
      ),
      body: MainShellBodyWidget(
        state: state,
        currentTabIndex: _currentTabIndex,
        onRetry: PatientCubit.get(context).loadPatients,
        onAdmitPatient: _showAdmitPatientSheet,
      ),
      bottomNavigationBar: MainShellNavigationBarWidget(
        currentIndex: _currentTabIndex,
        onSelect: _selectTab,
      ),
    ),
  );

  void _selectTab(int index) {
    if (index == 4) {
      _openMoreSheet(PatientCubit.get(context).state.selectedPatient);
      return;
    }
    setState(() => _currentTabIndex = index);
  }

  void _openPatientCensus() => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: ColorsManager.transparent,
    builder: (_) => const PatientCensusSheet(),
  );

  void _openMoreSheet(Patient? patient) => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: ColorsManager.transparent,
    builder: (_) => MoreModulesSheet(activePatient: patient),
  );

  void _showAdmitPatientSheet() => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: ColorsManager.transparent,
    builder: (_) => const AdmitPatientBottomSheet(),
  );
}
