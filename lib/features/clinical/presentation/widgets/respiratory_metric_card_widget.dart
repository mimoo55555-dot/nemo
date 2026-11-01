import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';

class RespiratoryMetricCardWidget extends StatelessWidget {
  final String label;
  final String value;
  final String note;
  final bool isAlert;

  const RespiratoryMetricCardWidget({
    super.key,
    required this.label,
    required this.value,
    required this.note,
    this.isAlert = false,
  });

  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 12, 10, 12),
      decoration: BoxDecoration(
        color: isAlert ? ColorsManager.redLight : ColorsManager.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isAlert ? ColorsManager.red : ColorsManager.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStylesManager.caption,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          verticalSpace4,
          Text(
            value,
            style: TextStylesManager.subtitle.copyWith(
              color: isAlert ? ColorsManager.red : ColorsManager.textPrimary,
            ),
          ),
          verticalSpace2,
          Text(note, style: TextStylesManager.caption),
        ],
      ),
    ),
  );
}
