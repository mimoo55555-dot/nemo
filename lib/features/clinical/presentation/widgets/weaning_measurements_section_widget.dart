import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/weaning_stepper_widget.dart';

class WeaningMeasurementsSectionWidget extends StatelessWidget {
  final int respiratoryRate;
  final double tidalVolume;
  final int inspiratoryForce;
  final ValueChanged<int> onRespiratoryRateChanged;
  final ValueChanged<double> onTidalVolumeChanged;
  final ValueChanged<int> onInspiratoryForceChanged;

  const WeaningMeasurementsSectionWidget({
    super.key,
    required this.respiratoryRate,
    required this.tidalVolume,
    required this.inspiratoryForce,
    required this.onRespiratoryRateChanged,
    required this.onTidalVolumeChanged,
    required this.onInspiratoryForceChanged,
  });

  @override
  Widget build(BuildContext context) => Card(
    color: ColorsManager.surface,
    child: Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 14, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.air_rounded, color: ColorsManager.primaryText),
              horizontalSpace8,
              Expanded(
                child: Text(
                  appTranslation().get('spontaneous_measurements'),
                  style: TextStylesManager.sectionTitle,
                ),
              ),
            ],
          ),
          verticalSpace8,
          WeaningStepperWidget(
            titleKey: 'spontaneous_rate',
            value:
                '$respiratoryRate ${appTranslation().get('breaths_per_minute')}',
            onDecrement: () => onRespiratoryRateChanged(
              (respiratoryRate - 1).clamp(6, 50),
            ),
            onIncrement: () => onRespiratoryRateChanged(
              (respiratoryRate + 1).clamp(6, 50),
            ),
          ),
          Divider(height: 1, color: ColorsManager.border),
          WeaningStepperWidget(
            titleKey: 'spontaneous_tidal_volume',
            value: '${tidalVolume.toInt()} ${appTranslation().get('unit_ml')}',
            onDecrement: () => onTidalVolumeChanged(
              (tidalVolume - 10).clamp(100, 900),
            ),
            onIncrement: () => onTidalVolumeChanged(
              (tidalVolume + 10).clamp(100, 900),
            ),
          ),
          Divider(height: 1, color: ColorsManager.border),
          WeaningStepperWidget(
            titleKey: 'negative_inspiratory_force',
            value: '$inspiratoryForce ${appTranslation().get('unit_cm_h2o')}',
            onDecrement: () => onInspiratoryForceChanged(
              (inspiratoryForce - 2).clamp(-60, 0),
            ),
            onIncrement: () => onInspiratoryForceChanged(
              (inspiratoryForce + 2).clamp(-60, 0),
            ),
          ),
        ],
      ),
    ),
  );
}
