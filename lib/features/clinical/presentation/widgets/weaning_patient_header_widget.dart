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
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: ColorsManager.amberLight,
            child: Icon(Icons.psychology, color: ColorsManager.amber),
          ),
          horizontalSpace12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${patient.bed} · ${appTranslation().get('weaning_sbt_assessment')}',
                  style: TextStylesManager.subtitle,
                ),
                Text(
                  '${patient.fullName} · ${appTranslation().get('intubation_date')}: ${patient.intubationDate}',
                  style: TextStylesManager.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
