import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/primary/conditional_builder.dart';
import 'package:nemoventrt/core/utils/constants/primary/primary_icon_button_widget.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/patient_census_details_widget.dart';

class PatientCensusTileWidget extends StatelessWidget {
  final Patient patient;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onDischarge;

  const PatientCensusTileWidget({
    super.key,
    required this.patient,
    required this.isSelected,
    required this.onTap,
    required this.onDischarge,
  });

  @override
  Widget build(BuildContext context) {
    final categoryColor = _categoryColor;
    final alertCount = patient.criticalAlerts
        .where((alert) => !alert.acknowledged)
        .length;
    return Card(
      elevation: isSelected ? 2 : 0,
      color: isSelected ? ColorsManager.primaryLight : ColorsManager.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isSelected ? ColorsManager.primary : ColorsManager.border,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 6),
        leading: CircleAvatar(
          backgroundColor: categoryColor.withValues(alpha: .2),
          child: Icon(_categoryIcon, color: categoryColor, size: 20),
        ),
        title: Row(
          children: [
            Flexible(
              child: Text(patient.bed, style: TextStylesManager.subtitle),
            ),
            horizontalSpace8,
            Expanded(
              child: Text(patient.fullName, style: TextStylesManager.body),
            ),
            horizontalSpace8,
            ConditionalBuilder(
              loadingState: false,
              emptyState: alertCount == 0,
              emptyBuilder: (_) => const SizedBox.shrink(),
              successBuilder: (_) => Chip(
                label: Text(
                  '$alertCount ${appTranslation().get('alarm')}',
                  style: TextStylesManager.caption.copyWith(
                    color: ColorsManager.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: ColorsManager.redLight,
                visualDensity: VisualDensity.compact,
              ),
            ),
          ],
        ),
        subtitle: PatientCensusDetailsWidget(patient: patient),
        trailing: isSelected
            ? const Icon(Icons.check_circle, color: ColorsManager.primary)
            : PrimaryIconButtonWidget(
                semanticLabelKey: 'discharge_patient',
                onPressed: onDischarge,
                icon: const Icon(
                  Icons.delete_outline,
                  color: ColorsManager.red,
                ),
              ),
        onTap: onTap,
      ),
    );
  }

  Color get _categoryColor => switch (patient.category) {
    PatientCategory.adult => ColorsManager.primary,
    PatientCategory.pediatric => ColorsManager.indigo,
    PatientCategory.neonate => ColorsManager.purple,
  };

  IconData get _categoryIcon => switch (patient.category) {
    PatientCategory.adult => Icons.person,
    PatientCategory.pediatric => Icons.child_care,
    PatientCategory.neonate => Icons.baby_changing_station,
  };
}
