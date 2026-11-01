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
                  color: ColorsManager.primary,
                ),
              ),
            ],
          ),
          verticalSpace4,
          Text(
            'pH: ${result.ph.toStringAsFixed(2)} · PaCO2: ${result.paCo2.toInt()} · PaO2: ${result.paO2.toInt()} · HCO3: ${result.hco3.toStringAsFixed(1)} · FiO2: ${result.fio2.toInt()}%',
            style: TextStylesManager.bodySmall,
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
      result.interpretation.split('|').map(appTranslation().get).join(' · ');
}
