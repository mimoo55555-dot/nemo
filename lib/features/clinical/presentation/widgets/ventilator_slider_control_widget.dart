import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';

class VentilatorSliderControlWidget extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final int? divisions;
  final String unit;
  final ValueChanged<double> onChanged;

  const VentilatorSliderControlWidget({
    super.key,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.unit,
    required this.onChanged,
    this.divisions,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.symmetric(vertical: 4),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStylesManager.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            horizontalSpace8,
            Text(
              '${value.toStringAsFixed(value == value.roundToDouble() ? 0 : 2)} $unit',
              style: TextStylesManager.subtitle.copyWith(
                color: ColorsManager.primaryText,
                fontWeight: FontWeight.bold,
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
  );
}
