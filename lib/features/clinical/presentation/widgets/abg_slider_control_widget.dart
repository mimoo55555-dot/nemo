import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';

class AbgSliderControlWidget extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final ValueChanged<double> onChanged;

  const AbgSliderControlWidget({
    super.key,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) => Card(
    color: ColorsManager.surface,
    child: Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(12, 6, 12, 6),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: TextStylesManager.bodySmall),
              Text(
                value.toStringAsFixed(value == value.roundToDouble() ? 0 : 2),
                style: TextStylesManager.subtitle.copyWith(
                  color: ColorsManager.primary,
                ),
              ),
            ],
          ),
          verticalSpace2,
          Slider(
            value: value.clamp(min, max),
            min: min,
            max: max,
            divisions: divisions,
            activeColor: ColorsManager.primary,
            onChanged: onChanged,
          ),
        ],
      ),
    ),
  );
}
