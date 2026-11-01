import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/ventilator_slider_control_widget.dart';

class VentilatorSettingsSlidersWidget extends StatelessWidget {
  final VentilatorSettings settings;
  final ValueChanged<VentilatorSettings> onChanged;

  const VentilatorSettingsSlidersWidget({
    super.key,
    required this.settings,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) => Column(
    children: [
      VentilatorSliderControlWidget(
        label: appTranslation().get('tidal_volume'),
        value: settings.tidalVolume,
        min: 50,
        max: 900,
        unit: appTranslation().get('unit_ml'),
        onChanged: (value) => onChanged(settings.copyWith(tidalVolume: value)),
      ),
      const Divider(height: 12),
      VentilatorSliderControlWidget(
        label: appTranslation().get('respiratory_rate'),
        value: settings.setRate.toDouble(),
        min: 4,
        max: 45,
        unit: appTranslation().get('breaths_per_minute'),
        onChanged: (value) => onChanged(
          settings.copyWith(setRate: value.toInt(), totalRate: value.toInt()),
        ),
      ),
      const Divider(height: 12),
      VentilatorSliderControlWidget(
        label: appTranslation().get('peep'),
        value: settings.peep,
        min: 0,
        max: 24,
        unit: appTranslation().get('unit_cm_h2o'),
        onChanged: (value) => onChanged(settings.copyWith(peep: value)),
      ),
      const Divider(height: 12),
      VentilatorSliderControlWidget(
        label: appTranslation().get('fio2_oxygen'),
        value: settings.fio2,
        min: 21,
        max: 100,
        unit: appTranslation().get('unit_percent'),
        onChanged: (value) => onChanged(settings.copyWith(fio2: value)),
      ),
      const Divider(height: 12),
      VentilatorSliderControlWidget(
        label: appTranslation().get('inspiratory_time'),
        value: settings.inspTime,
        min: 0.4,
        max: 3,
        divisions: 26,
        unit: appTranslation().get('seconds_abbreviation'),
        onChanged: (value) => onChanged(
          settings.copyWith(inspTime: double.parse(value.toStringAsFixed(2))),
        ),
      ),
    ],
  );
}
