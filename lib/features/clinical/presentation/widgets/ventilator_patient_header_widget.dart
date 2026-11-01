import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';

class VentilatorPatientHeaderWidget extends StatelessWidget {
  final Patient patient;
  final String mode;
  final double ibw;
  final int targetVolume;

  const VentilatorPatientHeaderWidget({
    super.key,
    required this.patient,
    required this.mode,
    required this.ibw,
    required this.targetVolume,
  });

  @override
  Widget build(BuildContext context) => Card(
    color: ColorsManager.surface,
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: ColorsManager.primaryLight,
            child: const Icon(Icons.air, color: ColorsManager.primary),
          ),
          horizontalSpace12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${patient.bed} · ${patient.fullName}',
                  style: TextStylesManager.subtitle,
                ),
                Text(
                  '${appTranslation().get('ideal_body_weight')}: ${ibw.toStringAsFixed(1)} kg · ${appTranslation().get('target_6ml_kg')}: $targetVolume mL',
                  style: TextStylesManager.bodySmall,
                ),
              ],
            ),
          ),
          Chip(
            label: Text(
              mode,
              style: TextStylesManager.caption.copyWith(
                color: ColorsManager.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: ColorsManager.primaryLight,
          ),
        ],
      ),
    ),
  );
}
