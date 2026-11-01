import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';

class WeaningPatientHeaderWidget extends StatelessWidget {
  final Patient patient;

  const WeaningPatientHeaderWidget({super.key, required this.patient});

  @override
  Widget build(BuildContext context) => Card(
    color: ColorsManager.surface,
    child: Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: ColorsManager.primaryLight,
                child: Icon(
                  Icons.airline_seat_flat_angled_rounded,
                  color: ColorsManager.primaryText,
                ),
              ),
              horizontalSpace12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      translateKnownValue(patient.fullName),
                      style: TextStylesManager.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    verticalSpace4,
                    Text(
                      '${translateKnownValue(patient.bed)} · ${translateKnownValue(patient.diagnosis)}',
                      style: TextStylesManager.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          verticalSpace12,
          Divider(height: 1, color: ColorsManager.border),
          verticalSpace8,
          Row(
            children: [
              Icon(
                Icons.event_note_outlined,
                size: 16,
                color: ColorsManager.textSecondary,
              ),
              horizontalSpace4,
              Expanded(
                child: Text(
                  '${appTranslation().get('intubation_date')}: ${patient.intubationDate}',
                  style: TextStylesManager.caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              horizontalSpace8,
              Container(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
                decoration: BoxDecoration(
                  color: ColorsManager.primaryLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  appTranslation().get('weaning_sbt_assessment'),
                  style: TextStylesManager.caption.copyWith(
                    color: ColorsManager.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
