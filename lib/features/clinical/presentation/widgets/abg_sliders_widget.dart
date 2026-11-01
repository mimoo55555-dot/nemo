import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/abg_slider_control_widget.dart';

class AbgSlidersWidget extends StatelessWidget {
  final double ph;
  final double paCo2;
  final double paO2;
  final double hco3;
  final ValueChanged<double> onPhChanged;
  final ValueChanged<double> onPaCo2Changed;
  final ValueChanged<double> onPaO2Changed;
  final ValueChanged<double> onHco3Changed;

  const AbgSlidersWidget({
    super.key,
    required this.ph,
    required this.paCo2,
    required this.paO2,
    required this.hco3,
    required this.onPhChanged,
    required this.onPaCo2Changed,
    required this.onPaO2Changed,
    required this.onHco3Changed,
  });

  @override
  Widget build(BuildContext context) => Card(
    color: ColorsManager.surface,
    child: Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appTranslation().get('interactive_abg_values'),
            style: TextStylesManager.sectionTitle,
          ),
          verticalSpace8,
          AbgSliderControlWidget(
            label: appTranslation().get('ph'),
            value: ph,
            min: 6.9,
            max: 7.7,
            divisions: 80,
            onChanged: (value) =>
                onPhChanged(double.parse(value.toStringAsFixed(2))),
          ),
          const Divider(height: 12),
          AbgSliderControlWidget(
            label:
                '${appTranslation().get('paco2')} (${appTranslation().get('unit_mmhg')})',
            value: paCo2,
            min: 15,
            max: 95,
            divisions: 80,
            onChanged: (value) => onPaCo2Changed(value.roundToDouble()),
          ),
          const Divider(height: 12),
          AbgSliderControlWidget(
            label:
                '${appTranslation().get('pao2')} (${appTranslation().get('unit_mmhg')})',
            value: paO2,
            min: 30,
            max: 300,
            divisions: 270,
            onChanged: (value) => onPaO2Changed(value.roundToDouble()),
          ),
          const Divider(height: 12),
          AbgSliderControlWidget(
            label:
                '${appTranslation().get('hco3')} (${appTranslation().get('unit_meq_per_l')})',
            value: hco3,
            min: 10,
            max: 45,
            divisions: 35,
            onChanged: (value) =>
                onHco3Changed(double.parse(value.toStringAsFixed(1))),
          ),
        ],
      ),
    ),
  );
}
