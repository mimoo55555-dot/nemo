import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';

class AbgInterpretationCardWidget extends StatelessWidget {
  final int ratio;
  final String diagnosis;
  final String summary;

  const AbgInterpretationCardWidget({
    super.key,
    required this.ratio,
    required this.diagnosis,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) => Card(
    color: ColorsManager.primaryLight,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  appTranslation().get('automated_clinical_interpretation'),
                  style: TextStylesManager.caption.copyWith(
                    color: ColorsManager.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Chip(
                label: Text(
                  '${appTranslation().get('pf_ratio')}: $ratio',
                  style: TextStylesManager.caption.copyWith(
                    color: ColorsManager.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: ColorsManager.primary,
              ),
            ],
          ),
          verticalSpace8,
          Text(diagnosis, style: TextStylesManager.title),
          verticalSpace4,
          Text(summary, style: TextStylesManager.bodySmall),
        ],
      ),
    ),
  );
}
