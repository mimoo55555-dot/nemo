import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/respiratory_metrics_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/sbt_control_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/ventilator_mode_selector_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/ventilator_patient_header_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/ventilator_save_button_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/ventilator_settings_controls_widget.dart';

class VentilatorScreenBodyWidget extends StatelessWidget {
  final Patient patient;
  final VentilatorSettings settings;
  final double ibw;
  final int targetVolume;
  final Map<String, dynamic> mechanics;
  final bool isSaving;
  final ValueChanged<String> onModeChanged;
  final ValueChanged<VentilatorSettings> onSettingsChanged;
  final VoidCallback onSave;

  const VentilatorScreenBodyWidget({
    super.key,
    required this.patient,
    required this.settings,
    required this.ibw,
    required this.targetVolume,
    required this.mechanics,
    required this.isSaving,
    required this.onModeChanged,
    required this.onSettingsChanged,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SingleChildScrollView(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VentilatorPatientHeaderWidget(
            patient: patient,
            mode: settings.mode,
            ibw: ibw,
            targetVolume: targetVolume,
          ),
          verticalSpace12,
          RespiratoryMetricsWidget(mechanics: mechanics),
          verticalSpace16,
          VentilatorModeSelectorWidget(
            selectedMode: settings.mode,
            onSelected: onModeChanged,
          ),
          verticalSpace16,
          VentilatorSettingsControlsWidget(
            settings: settings,
            onChanged: onSettingsChanged,
          ),
          verticalSpace16,
          const SbtControlWidget(),
          verticalSpace20,
          VentilatorSaveButtonWidget(isSaving: isSaving, onPressed: onSave),
          verticalSpace32,
        ],
      ),
    ),
  );
}
