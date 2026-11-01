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
  Widget build(BuildContext context) => Card(
    color: isAlert ? ColorsManager.redLight : ColorsManager.surface,
    child: Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(14, 12, 14, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStylesManager.caption.copyWith(
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            value,
            style: TextStylesManager.metricValue.copyWith(
              color: isAlert ? ColorsManager.red : ColorsManager.textPrimary,
              fontSize: 24,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            range,
            style: TextStylesManager.caption,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}
