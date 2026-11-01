import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';

class AbgPatientHeaderWidget extends StatelessWidget {
  final Patient patient;

  const AbgPatientHeaderWidget({super.key, required this.patient});

  @override
  Widget build(BuildContext context) => Card(
    color: ColorsManager.surface,
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: ColorsManager.purpleLight,
            child: Icon(Icons.science, color: ColorsManager.purple),
          ),
          horizontalSpace12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${translateKnownValue(patient.bed)} · ${appTranslation().get('abg_lab')}',
                  style: TextStylesManager.subtitle,
                ),
                Text(
                  '${translateKnownValue(patient.fullName)} (${patient.mrn})',
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
