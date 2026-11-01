import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';

class ActivePatientSummaryWidget extends StatelessWidget {
  final Patient patient;

  const ActivePatientSummaryWidget({super.key, required this.patient});

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: ColorsManager.blueGrey.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: ColorsManager.blueGrey.withValues(alpha: 0.2)),
    ),
    child: Row(
      children: [
        Icon(
          Icons.airline_seat_flat_angled,
          color: ColorsManager.primaryText,
        ),
        horizontalSpace12,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${appTranslation().get('active_case')}: ${patient.bed} · ${patient.fullName}',
                style: TextStylesManager.subtitle,
              ),
              Text(
                '${patient.diagnosis} · ${appTranslation().get('mrn_number')}: ${patient.mrn}',
                style: TextStylesManager.bodySmall,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
