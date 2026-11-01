import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';

class VitalsHistoryItemWidget extends StatelessWidget {
  final VitalObservation observation;

  const VitalsHistoryItemWidget({super.key, required this.observation});

  @override
  Widget build(BuildContext context) => Card(
    color: ColorsManager.surface,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(observation.timestamp, style: TextStylesManager.subtitle),
          Text(
            'HR: ${observation.heartRate} · SpO2: ${observation.spo2}% · BP: ${observation.systolicBp}/${observation.diastolicBp} · RR: ${observation.respiratoryRate}',
            style: TextStylesManager.bodySmall.copyWith(
              color: ColorsManager.grey,
            ),
          ),
        ],
      ),
    ),
  );
}
