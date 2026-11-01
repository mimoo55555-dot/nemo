import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/primary/primary_icon_button_widget.dart';
import 'package:nemoventrt/features/clinical/logic/patient_state.dart';

class PatientCensusHeaderWidget extends StatelessWidget {
  final PatientState state;
  final VoidCallback onClose;

  const PatientCensusHeaderWidget({
    super.key,
    required this.state,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(20, 8, 20, 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appTranslation().get('icu_patient_census'),
              style: TextStylesManager.title,
            ),
            Text(_subtitle, style: TextStylesManager.bodySmall),
          ],
        ),
        PrimaryIconButtonWidget(
          semanticLabelKey: 'close',
          onPressed: onClose,
          icon: const Icon(Icons.close),
        ),
      ],
    ),
  );

  String get _subtitle {
    return switch (state.status) {
      PatientStatus.initial || PatientStatus.loading => appTranslation().get(
        'connecting_to_clinical_records',
      ),
      PatientStatus.error => appTranslation().get('offline_mode'),
      _ =>
        '${state.patients.length} ${appTranslation().get(state.patients.length == 1 ? 'active_flowsheet' : 'active_flowsheets')}',
    };
  }
}
