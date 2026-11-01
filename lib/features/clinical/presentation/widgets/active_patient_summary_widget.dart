import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';

class ActivePatientSummaryWidget extends StatelessWidget {
  final Patient patient;

  const ActivePatientSummaryWidget({super.key, required this.patient});

  @override
  Widget build(BuildContext context) => Card(
    color: ColorsManager.primaryLight,
    margin: EdgeInsets.zero,
    child: ListTile(
      contentPadding: const EdgeInsetsDirectional.fromSTEB(14, 4, 14, 4),
      leading: CircleAvatar(
        backgroundColor: ColorsManager.surface,
        child: Icon(
          Icons.airline_seat_flat_angled,
          color: ColorsManager.primaryText,
        ),
      ),
      title: Text(
        '${appTranslation().get('active_case')}: ${translateKnownValue(patient.bed)} · ${translateKnownValue(patient.fullName)}',
        style: TextStylesManager.subtitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        '${translateKnownValue(patient.diagnosis)} · ${appTranslation().get('mrn_number')}: ${patient.mrn}',
        style: TextStylesManager.bodySmall,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );
}
