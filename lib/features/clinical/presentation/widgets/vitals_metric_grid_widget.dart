import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/vital_metric_card_widget.dart';

class VitalsMetricGridWidget extends StatelessWidget {
  final int heartRate;
  final int spo2;
  final int respiratoryRate;
  final int systolicBloodPressure;
  final int diastolicBloodPressure;
  final int etCo2;
  final double temperature;

  const VitalsMetricGridWidget({
    super.key,
    required this.heartRate,
    required this.spo2,
    required this.respiratoryRate,
    required this.systolicBloodPressure,
    required this.diastolicBloodPressure,
    required this.etCo2,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) => GridView.count(
    crossAxisCount: 2,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    childAspectRatio: 1.5,
    children: [
      VitalMetricCardWidget(
        labelKey: 'heart_rate',
        value: '$heartRate',
        unitKey: 'unit_bpm',
        icon: Icons.favorite,
        accentColor: ColorsManager.red,
      ),
      VitalMetricCardWidget(
        labelKey: 'spo2_pulse_ox',
        value: '$spo2',
        unitKey: 'unit_percent',
        icon: Icons.water_drop,
        accentColor: ColorsManager.blue,
      ),
      VitalMetricCardWidget(
        labelKey: 'respiratory_rate',
        value: '$respiratoryRate',
        unitKey: 'unit_per_minute',
        icon: Icons.air,
        accentColor: ColorsManager.primary,
      ),
      VitalMetricCardWidget(
        labelKey: 'blood_pressure',
        value: '$systolicBloodPressure/$diastolicBloodPressure',
        unitKey: 'unit_mmhg',
        icon: Icons.speed,
        accentColor: ColorsManager.purple,
      ),
      VitalMetricCardWidget(
        labelKey: 'end_tidal_co2',
        value: '$etCo2',
        unitKey: 'unit_mmhg',
        icon: Icons.cloud,
        accentColor: ColorsManager.amber,
      ),
      VitalMetricCardWidget(
        labelKey: 'body_temperature',
        value: temperature.toStringAsFixed(1),
        unitKey: 'unit_celsius',
        icon: Icons.thermostat,
        accentColor: ColorsManager.orange,
      ),
    ],
  );
}
