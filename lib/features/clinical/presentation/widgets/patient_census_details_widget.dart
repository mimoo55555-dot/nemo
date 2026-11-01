import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/primary/conditional_builder.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';

class PatientCensusDetailsWidget extends StatelessWidget {
  final Patient patient;

  const PatientCensusDetailsWidget({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    final settings = patient.ventilatorSettings;
    final alerts = patient.criticalAlerts
        .where((alert) => !alert.acknowledged)
        .length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace4,
        Text(
          '${patient.diagnosis} · ${patient.age} ${appTranslation().get('years_abbreviation')} · ${appTranslation().get(patient.sex.name)}',
          style: TextStylesManager.caption,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        verticalSpace4,
        Wrap(
          spacing: 10,
          runSpacing: 4,
          children: [
            Text(
              '${appTranslation().get('peep')} ${settings.peep.toInt()}',
              style: TextStylesManager.caption,
            ),
            Text(
              '${appTranslation().get('fio2')}: ${settings.fio2.toInt()}%',
              style: TextStylesManager.caption,
            ),
            Text(
              '${appTranslation().get('tidal_volume')}: ${settings.tidalVolume.toInt()} mL',
              style: TextStylesManager.caption,
            ),
            ConditionalBuilder(
              loadingState: false,
              emptyState: alerts == 0,
              emptyBuilder: (_) => const SizedBox.shrink(),
              successBuilder: (_) => Container(
                padding: const EdgeInsetsDirectional.fromSTEB(8, 2, 8, 2),
                decoration: BoxDecoration(
                  color: ColorsManager.redLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$alerts ${appTranslation().get('alarm')}',
                  style: TextStylesManager.caption.copyWith(
                    color: ColorsManager.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        verticalSpace4,
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 14,
              color: ColorsManager.grey,
            ),
            horizontalSpace4,
            Text(patient.unit, style: TextStylesManager.caption),
          ],
        ),
      ],
    );
  }
}
