import 'package:flutter/material.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/respiratory_metric_card_widget.dart';

class RespiratoryMetricsWidget extends StatelessWidget {
  final Map<String, dynamic> mechanics;

  const RespiratoryMetricsWidget({super.key, required this.mechanics});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Row(
        children: [
          Expanded(
            child: RespiratoryMetricCardWidget(
              label: appTranslation().get('driving_pressure'),
              value: '${mechanics['drivingPressure']} cmH2O',
              note: appTranslation().get('plateau_minus_peep_limit'),
              icon: Icons.speed_outlined,
              isAlert: !(mechanics['isDrivingPressureSafe'] as bool),
            ),
          ),
          horizontalSpace8,
          Expanded(
            child: RespiratoryMetricCardWidget(
              label: appTranslation().get('static_compliance'),
              value: '${mechanics['staticCompliance']} mL/cmH2O',
              note: appTranslation().get('compliance_normal_range'),
              icon: Icons.air_outlined,
            ),
          ),
        ],
      ),
      verticalSpace8,
      Row(
        children: [
          Expanded(
            child: RespiratoryMetricCardWidget(
              label: appTranslation().get('volume_per_ibw'),
              value: '${mechanics['mlPerKg']} mL/kg',
              note: appTranslation().get('tidal_volume_target_range'),
              icon: Icons.straighten_outlined,
            ),
          ),
        ],
      ),
    ],
  );
}
