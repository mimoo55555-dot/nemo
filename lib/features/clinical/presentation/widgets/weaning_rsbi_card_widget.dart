import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';

class WeaningRsbiCardWidget extends StatelessWidget {
  final double rsbi;

  const WeaningRsbiCardWidget({super.key, required this.rsbi});

  @override
  Widget build(BuildContext context) {
    final ready = rsbi < 105;
    final color = ready ? ColorsManager.primaryText : ColorsManager.red;
    return Card(
      color: ready ? ColorsManager.primaryLight : ColorsManager.redLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appTranslation().get('rapid_shallow_breathing_index'),
                        style: TextStylesManager.sectionTitle,
                      ),
                      verticalSpace4,
                      Text(
                        appTranslation().get('rsbi_formula'),
                        style: TextStylesManager.caption,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                horizontalSpace8,
                Container(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    10,
                    6,
                    10,
                    6,
                  ),
                  decoration: BoxDecoration(
                    color: ColorsManager.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    appTranslation().get(ready ? 'ready_to_wean' : 'not_ready'),
                    style: TextStylesManager.bodySmall.copyWith(
                      color: color,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            verticalSpace12,
            Row(
              children: [
                Expanded(
                  child: Text(
                    appTranslation().get(
                      ready ? 'rsbi_ready_message' : 'rsbi_not_ready_message',
                    ),
                    style: TextStylesManager.body.copyWith(color: color),
                  ),
                ),
                horizontalSpace12,
                Container(
                  constraints: const BoxConstraints(minWidth: 76),
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    14,
                    8,
                    14,
                    8,
                  ),
                  decoration: BoxDecoration(
                    color: ColorsManager.surface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    rsbi.toInt().toString(),
                    textAlign: TextAlign.center,
                    style: TextStylesManager.headline.copyWith(
                      color: color,
                      fontSize: 32,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
