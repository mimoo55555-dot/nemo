import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/abg_history_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/abg_interpretation_card_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/abg_patient_header_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/abg_save_button_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/abg_sliders_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/abg_value_grid_widget.dart';

class AbgScreenBodyWidget extends StatelessWidget {
  final Patient patient;
  final double ph;
  final double paCo2;
  final double paO2;
  final double hco3;
  final double baseExcess;
  final double fio2;
  final int ratio;
  final String diagnosis;
  final String summary;
  final bool isSaving;
  final ValueChanged<double> onPhChanged;
  final ValueChanged<double> onPaCo2Changed;
  final ValueChanged<double> onPaO2Changed;
  final ValueChanged<double> onHco3Changed;
  final VoidCallback onSave;

  const AbgScreenBodyWidget({
    super.key,
    required this.patient,
    required this.ph,
    required this.paCo2,
    required this.paO2,
    required this.hco3,
    required this.baseExcess,
    required this.fio2,
    required this.ratio,
    required this.diagnosis,
    required this.summary,
    required this.isSaving,
    required this.onPhChanged,
    required this.onPaCo2Changed,
    required this.onPaO2Changed,
    required this.onHco3Changed,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SingleChildScrollView(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AbgPatientHeaderWidget(patient: patient),
          verticalSpace16,
          AbgInterpretationCardWidget(
            ratio: ratio,
            diagnosis: diagnosis,
            summary: summary,
          ),
          verticalSpace16,
          AbgValueGridWidget(
            ph: ph,
            paCo2: paCo2,
            paO2: paO2,
            hco3: hco3,
            baseExcess: baseExcess,
            fio2: fio2,
          ),
          verticalSpace16,
          AbgSlidersWidget(
            ph: ph,
            paCo2: paCo2,
            paO2: paO2,
            hco3: hco3,
            onPhChanged: onPhChanged,
            onPaCo2Changed: onPaCo2Changed,
            onPaO2Changed: onPaO2Changed,
            onHco3Changed: onHco3Changed,
          ),
          verticalSpace16,
          AbgSaveButtonWidget(isSaving: isSaving, onPressed: onSave),
          verticalSpace20,
          AbgHistoryWidget(results: patient.recentABGs),
          verticalSpace32,
        ],
      ),
    ),
  );
}
