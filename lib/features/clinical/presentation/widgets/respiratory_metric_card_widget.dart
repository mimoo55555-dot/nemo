import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';

class RespiratoryMetricCardWidget extends StatelessWidget {
  final String label;
  final String value;
  final String note;
  final IconData icon;
  final bool isAlert;

  const RespiratoryMetricCardWidget({
    super.key,
    required this.label,
    required this.value,
    required this.note,
    required this.icon,
    this.isAlert = false,
  });

  @override
  Widget build(BuildContext context) => Card(
    color: isAlert ? ColorsManager.redLight : ColorsManager.surface,
    child: Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(14, 14, 14, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStylesManager.caption.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              horizontalSpace4,
              Icon(
                icon,
                size: 18,
                color: isAlert ? ColorsManager.red : ColorsManager.primaryText,
              ),
            ],
          ),
          verticalSpace8,
          Text(
            value,
            style: TextStylesManager.metricValue.copyWith(
              fontSize: 21,
              color: isAlert ? ColorsManager.red : ColorsManager.textPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          verticalSpace4,
          Text(
            note,
            style: TextStylesManager.caption,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}
