import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';

class VitalMetricCardWidget extends StatelessWidget {
  final String labelKey;
  final String value;
  final String unitKey;
  final IconData icon;
  final Color accentColor;

  const VitalMetricCardWidget({
    super.key,
    required this.labelKey,
    required this.value,
    required this.unitKey,
    required this.icon,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) => Card(
    color: ColorsManager.surface,
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  appTranslation().get(labelKey),
                  style: TextStylesManager.caption,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(icon, size: 16, color: accentColor),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Flexible(
                child: Text(
                  value,
                  style: TextStylesManager.title.copyWith(color: accentColor),
                ),
              ),
              horizontalSpace4,
              Text(
                appTranslation().get(unitKey),
                style: TextStylesManager.caption.copyWith(
                  color: ColorsManager.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
