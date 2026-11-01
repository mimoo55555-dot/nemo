import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/models/staff_user.dart';
import 'package:nemoventrt/core/utils/constants/primary/conditional_builder.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/active_patient_summary_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/advanced_modules_section_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/appearance_language_settings_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/more_modules_section_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/security_modules_section_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/staff_profile_card_widget.dart';

class MoreModulesListWidget extends StatelessWidget {
  final Patient? activePatient;
  final StaffUser? user;

  const MoreModulesListWidget({
    super.key,
    required this.activePatient,
    required this.user,
  });

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 20),
    children: [
      StaffProfileCardWidget(user: user),
      verticalSpace12,
      ConditionalBuilder(
        loadingState: false,
        emptyState: activePatient == null,
        emptyBuilder: (_) => const SizedBox.shrink(),
        successBuilder: (_) => ActivePatientSummaryWidget(
          patient: activePatient!,
        ),
      ),
      verticalSpace16,
      AdvancedModulesSectionWidget(activePatient: activePatient),
      verticalSpace12,
      const MoreModulesSectionWidget(
        titleKey: 'preferences',
        tiles: [AppearanceLanguageSettingsWidget()],
      ),
      verticalSpace12,
      const SecurityModulesSectionWidget(),
    ],
  );
}
