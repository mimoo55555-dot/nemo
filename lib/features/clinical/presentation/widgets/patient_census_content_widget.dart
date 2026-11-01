import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';
import 'package:nemoventrt/features/clinical/logic/patient_state.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/patient_census_footer_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/patient_census_header_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/patient_census_search_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/patient_census_state_body_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/patient_category_filter_widget.dart';

class PatientCensusContentWidget extends StatelessWidget {
  final PatientState state;
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String> onFilterChanged;
  final ValueChanged<Patient> onSelectPatient;
  final ValueChanged<Patient> onDischargePatient;
  final VoidCallback onAdmitPatient;
  final VoidCallback onClose;

  const PatientCensusContentWidget({
    super.key,
    required this.state,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.onFilterChanged,
    required this.onSelectPatient,
    required this.onDischargePatient,
    required this.onAdmitPatient,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: ColorsManager.background,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
    ),
    constraints: BoxConstraints(
      maxHeight: MediaQuery.sizeOf(context).height * .85,
    ),
    child: SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 8),
            width: 44,
            height: 5,
            decoration: BoxDecoration(
              color: ColorsManager.lightGrey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          PatientCensusHeaderWidget(state: state, onClose: onClose),
          PatientCensusSearchWidget(onChanged: onSearchChanged),
          PatientCategoryFilterWidget(
            selectedValue: state.categoryFilter,
            onChanged: onFilterChanged,
          ),
          const Divider(height: 1),
          Expanded(
            child: PatientCensusStateBodyWidget(
              state: state,
              searchQuery: searchQuery,
              onSelectPatient: onSelectPatient,
              onDischargePatient: onDischargePatient,
            ),
          ),
          verticalSpace4,
          PatientCensusFooterWidget(onPressed: onAdmitPatient),
        ],
      ),
    ),
  );
}
