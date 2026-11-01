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
      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: ColorsManager.primaryLight,
                child: Icon(Icons.air, color: ColorsManager.primaryText),
              ),
              horizontalSpace12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${patient.bed} · ${patient.fullName}',
                      style: TextStylesManager.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(patient.mrn, style: TextStylesManager.caption),
                  ],
                ),
              ),
              horizontalSpace8,
              Chip(
                label: Text(
                  mode,
                  style: TextStylesManager.caption.copyWith(
                    color: ColorsManager.primaryText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: ColorsManager.primaryLight,
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          verticalSpace8,
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              Chip(
                avatar: const Icon(Icons.monitor_weight_outlined, size: 16),
                label: Text(
                  '${appTranslation().get('ideal_body_weight')}: ${ibw.toStringAsFixed(1)} kg',
                  style: TextStylesManager.caption,
                ),
                backgroundColor: ColorsManager.elevatedSurface,
                visualDensity: VisualDensity.compact,
              ),
              Chip(
                avatar: const Icon(Icons.straighten_outlined, size: 16),
                label: Text(
                  '${appTranslation().get('target_6ml_kg')}: $targetVolume mL',
                  style: TextStylesManager.caption,
                ),
                backgroundColor: ColorsManager.elevatedSurface,
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
