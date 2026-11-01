import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
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
    return Card(
      color: isSelected ? ColorsManager.primaryLight : ColorsManager.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? ColorsManager.primaryText : ColorsManager.border,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: ListTile(
        isThreeLine: true,
        minVerticalPadding: 12,
        contentPadding: const EdgeInsetsDirectional.fromSTEB(14, 4, 8, 4),
        leading: CircleAvatar(
          backgroundColor: categoryColor.withValues(alpha: 0.12),
          child: Icon(_categoryIcon, color: categoryColor, size: 20),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
              decoration: BoxDecoration(
                color: categoryColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                patient.bed,
                style: TextStylesManager.caption.copyWith(
                  color: categoryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            horizontalSpace8,
            Expanded(
              child: Text(
                patient.fullName,
                style: TextStylesManager.subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        subtitle: PatientCensusDetailsWidget(patient: patient),
        trailing: isSelected
            ? Icon(
                Icons.check_circle,
                color: ColorsManager.primaryText,
                size: 26,
              )
            : PrimaryIconButtonWidget(
                semanticLabelKey: 'discharge_patient',
                onPressed: onDischarge,
                icon: Icon(Icons.delete_outline, color: ColorsManager.red),
              ),
        onTap: onTap,
      ),
    );
  }

  Color get _categoryColor => switch (patient.category) {
    PatientCategory.adult => ColorsManager.primaryText,
    PatientCategory.pediatric => ColorsManager.indigo,
    PatientCategory.neonate => ColorsManager.purple,
  };

  IconData get _categoryIcon => switch (patient.category) {
    PatientCategory.adult => Icons.person,
    PatientCategory.pediatric => Icons.child_care,
    PatientCategory.neonate => Icons.baby_changing_station,
  };
}
