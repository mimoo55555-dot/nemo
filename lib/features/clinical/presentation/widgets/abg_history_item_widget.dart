import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';

class AbgHistoryItemWidget extends StatelessWidget {
  final ABGResult result;

  const AbgHistoryItemWidget({super.key, required this.result});

  @override
  Widget build(BuildContext context) => Card(
    color: ColorsManager.surface,
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(result.timestamp, style: TextStylesManager.subtitle),
              Text(
                '${appTranslation().get('pf_ratio')}: ${result.pfRatio.toInt()}',
                style: TextStylesManager.subtitle.copyWith(
                  color: ColorsManager.primaryText,
                ),
              ),
            ],
          ),
          verticalSpace4,
          Wrap(
            spacing: 12,
            runSpacing: 4,
            children: [
              Text(
                '${appTranslation().get('ph')}: ${result.ph.toStringAsFixed(2)}',
                style: TextStylesManager.bodySmall,
              ),
              Text(
                '${appTranslation().get('paco2')}: ${result.paCo2.toInt()} ${appTranslation().get('unit_mmhg')}',
                style: TextStylesManager.bodySmall,
              ),
              Text(
                '${appTranslation().get('pao2')}: ${result.paO2.toInt()} ${appTranslation().get('unit_mmhg')}',
                style: TextStylesManager.bodySmall,
              ),
              Text(
                '${appTranslation().get('hco3')}: ${result.hco3.toStringAsFixed(1)}',
                style: TextStylesManager.bodySmall,
              ),
              Text(
                '${appTranslation().get('base_excess')}: ${result.baseExcess.toStringAsFixed(1)}',
                style: TextStylesManager.bodySmall,
              ),
              Text(
                '${appTranslation().get('fio2')}: ${result.fio2.toInt()}${appTranslation().get('unit_percent')}',
                style: TextStylesManager.bodySmall,
              ),
            ],
          ),
          verticalSpace2,
          Text(
            _interpretation,
            style: TextStylesManager.caption.copyWith(
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    ),
  );

  String get _interpretation =>
      result.interpretation.split('|').map(translateKnownValue).join(' · ');
}
