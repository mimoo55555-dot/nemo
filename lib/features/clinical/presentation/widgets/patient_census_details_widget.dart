import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';

class PatientCensusDetailsWidget extends StatelessWidget {
  final Patient patient;

  const PatientCensusDetailsWidget({super.key, required this.patient});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      verticalSpace4,
      Text(
        '${patient.diagnosis} · ${patient.age} ${appTranslation().get('years_abbreviation')} · ${appTranslation().get(patient.sex.name)} · ${appTranslation().get('ibw')}: ${patient.actualWeightKg} kg',
        style: TextStylesManager.caption,
      ),
      verticalSpace4,
      Wrap(
        spacing: 8,
        children: [
          Text(
            'PEEP: ${patient.ventilatorSettings.peep.toInt()}',
            style: TextStylesManager.caption,
          ),
          Text(
            'FiO₂: ${patient.ventilatorSettings.fio2.toInt()}%',
            style: TextStylesManager.caption,
          ),
          Text(
            'Vt: ${patient.ventilatorSettings.tidalVolume.toInt()} mL',
            style: TextStylesManager.caption,
          ),
        ],
      ),
    ],
  );
}
