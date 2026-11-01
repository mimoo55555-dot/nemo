import 'package:flutter/material.dart';
import 'package:nemoventrt/core/utils/constants/primary/primary_dropdown_form_field.dart';
import 'package:nemoventrt/core/utils/constants/primary/primary_text_form_field.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';

class AdmitPatientVentilatorFieldsWidget extends StatelessWidget {
  static const _modes = [
    PrimaryDropdownOption(value: 'VC-CMV', labelKey: 'VC-CMV'),
    PrimaryDropdownOption(value: 'PC-CMV', labelKey: 'PC-CMV'),
    PrimaryDropdownOption(value: 'SIMV', labelKey: 'SIMV'),
    PrimaryDropdownOption(value: 'PSV', labelKey: 'PSV'),
    PrimaryDropdownOption(value: 'PRVC', labelKey: 'PRVC'),
    PrimaryDropdownOption(value: 'APRV', labelKey: 'APRV'),
  ];

  final String mode;
  final double tidalVolume;
  final int setRate;
  final double peep;
  final double fio2;
  final ValueChanged<String> onModeChanged;
  final ValueChanged<double> onTidalVolumeSaved;
  final ValueChanged<int> onRateSaved;
  final ValueChanged<double> onPeepSaved;
  final ValueChanged<double> onFio2Saved;

  const AdmitPatientVentilatorFieldsWidget({
    super.key,
    required this.mode,
    required this.tidalVolume,
    required this.setRate,
    required this.peep,
    required this.fio2,
    required this.onModeChanged,
    required this.onTidalVolumeSaved,
    required this.onRateSaved,
    required this.onPeepSaved,
    required this.onFio2Saved,
  });

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Row(
        children: [
          Expanded(
            child: PrimaryDropdownFormField<String>(
              labelKey: 'ventilation_mode',
              value: mode,
              options: _modes,
              onChanged: (value) {
                if (value != null) onModeChanged(value);
              },
            ),
          ),
          horizontalSpace8,
          Expanded(
            child: PrimaryTextFormField(
              labelKey: 'tidal_volume_ml',
              initialValue: tidalVolume.toInt().toString(),
              keyboardType: TextInputType.number,
              onSaved: (value) => onTidalVolumeSaved(
                double.tryParse(value ?? '') ?? tidalVolume,
              ),
            ),
          ),
        ],
      ),
      verticalSpace8,
      Row(
        children: [
          Expanded(
            child: PrimaryTextFormField(
              labelKey: 'rate_per_minute',
              initialValue: '$setRate',
              keyboardType: TextInputType.number,
              onSaved: (value) => onRateSaved(
                int.tryParse(value ?? '') ?? setRate,
              ),
            ),
          ),
          horizontalSpace8,
          Expanded(
            child: PrimaryTextFormField(
              labelKey: 'peep',
              initialValue: peep.toInt().toString(),
              keyboardType: TextInputType.number,
              onSaved: (value) => onPeepSaved(
                double.tryParse(value ?? '') ?? peep,
              ),
            ),
          ),
        ],
      ),
      verticalSpace8,
      PrimaryTextFormField(
        labelKey: 'fio2_percent',
        initialValue: fio2.toInt().toString(),
        keyboardType: TextInputType.number,
        onSaved: (value) => onFio2Saved(
          double.tryParse(value ?? '') ?? fio2,
        ),
      ),
    ],
  );
}
