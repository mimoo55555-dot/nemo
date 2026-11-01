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
      padding: const EdgeInsetsDirectional.fromSTEB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  appTranslation().get(labelKey),
                  style: TextStylesManager.caption.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              horizontalSpace4,
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 17, color: accentColor),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Flexible(
                child: Text(
                  value,
                  style: TextStylesManager.metricValue.copyWith(
                    color: accentColor,
                    fontSize: 26,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              horizontalSpace4,
              Flexible(
                child: Text(
                  appTranslation().get(unitKey),
                  style: TextStylesManager.caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
