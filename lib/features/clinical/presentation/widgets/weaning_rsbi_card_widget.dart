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
    final color = ready ? ColorsManager.primary : ColorsManager.red;
    return Card(
      color: ready ? ColorsManager.primaryLight : ColorsManager.redLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: color.withValues(alpha: 0.35)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appTranslation().get('rapid_shallow_breathing_index'),
                        style: TextStylesManager.subtitle,
                      ),
                      Text(
                        appTranslation().get('rsbi_formula'),
                        style: TextStylesManager.caption,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    appTranslation().get(ready ? 'ready_to_wean' : 'not_ready'),
                    style: TextStylesManager.bodySmall.copyWith(
                      color: ColorsManager.surface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            verticalSpace16,
            Text(
              rsbi.toInt().toString(),
              style: TextStylesManager.headline.copyWith(
                fontSize: 48,
                color: color,
              ),
            ),
            Text(
              appTranslation().get(
                ready ? 'rsbi_ready_message' : 'rsbi_not_ready_message',
              ),
              style: TextStylesManager.bodySmall.copyWith(color: color),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
