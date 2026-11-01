import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';

class VitalsHistoryItemWidget extends StatelessWidget {
  final VitalObservation observation;

  const VitalsHistoryItemWidget({super.key, required this.observation});

  @override
  Widget build(BuildContext context) => Card(
    color: ColorsManager.surface,
    child: Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(14, 14, 14, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ColorsManager.primaryLight,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.monitor_heart_outlined,
              color: ColorsManager.primaryText,
            ),
          ),
          horizontalSpace12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(observation.timestamp, style: TextStylesManager.subtitle),
                verticalSpace8,
                Wrap(
                  spacing: 12,
                  runSpacing: 6,
                  children: [
                    Text(
                      '${appTranslation().get('heart_rate')}: ${observation.heartRate} ${appTranslation().get('unit_bpm')}',
                      style: TextStylesManager.caption,
                    ),
                    Text(
                      '${appTranslation().get('spo2_pulse_ox')}: ${observation.spo2}${appTranslation().get('unit_percent')}',
                      style: TextStylesManager.caption,
                    ),
                    Text(
                      '${appTranslation().get('blood_pressure')}: ${observation.systolicBp}/${observation.diastolicBp} ${appTranslation().get('unit_mmhg')}',
                      style: TextStylesManager.caption,
                    ),
                    Text(
                      '${appTranslation().get('respiratory_rate')}: ${observation.respiratoryRate} ${appTranslation().get('unit_per_minute')}',
                      style: TextStylesManager.caption,
                    ),
                    Text(
                      '${appTranslation().get('end_tidal_co2')}: ${observation.etCo2 ?? '—'} ${appTranslation().get('unit_mmhg')}',
                      style: TextStylesManager.caption,
                    ),
                    Text(
                      '${appTranslation().get('body_temperature')}: ${observation.temperatureC.toStringAsFixed(1)} ${appTranslation().get('unit_celsius')}',
                      style: TextStylesManager.caption,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
