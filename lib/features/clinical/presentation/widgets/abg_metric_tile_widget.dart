import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';

class AbgMetricTileWidget extends StatelessWidget {
  final String label;
  final String value;
  final String range;
  final bool isAlert;

  const AbgMetricTileWidget({
    super.key,
    required this.label,
    required this.value,
    required this.range,
    required this.isAlert,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: isAlert ? ColorsManager.redLight : ColorsManager.surface,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: isAlert ? ColorsManager.red : ColorsManager.border,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStylesManager.caption),
        Text(
          value,
          style: TextStylesManager.metricValue.copyWith(
            color: isAlert ? ColorsManager.red : ColorsManager.textPrimary,
          ),
        ),
        Text(range, style: TextStylesManager.caption),
      ],
    ),
  );
}
