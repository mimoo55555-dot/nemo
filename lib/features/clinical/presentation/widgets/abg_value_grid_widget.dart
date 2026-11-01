import 'package:flutter/material.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/abg_metric_tile_widget.dart';

class AbgValueGridWidget extends StatelessWidget {
  final double ph;
  final double paCo2;
  final double paO2;
  final double hco3;
  final double baseExcess;
  final double fio2;

  const AbgValueGridWidget({
    super.key,
    required this.ph,
    required this.paCo2,
    required this.paO2,
    required this.hco3,
    required this.baseExcess,
    required this.fio2,
  });

  @override
  Widget build(BuildContext context) => GridView.count(
    crossAxisCount: 2,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
    childAspectRatio: 1.55,
    children: [
      AbgMetricTileWidget(
        label: appTranslation().get('ph'),
        value: ph.toStringAsFixed(2),
        range: appTranslation().get('abg_ph_normal_range'),
        isAlert: ph < 7.35 || ph > 7.45,
      ),
      AbgMetricTileWidget(
        label: appTranslation().get('paco2'),
        value: paCo2.toInt().toString(),
        range:
            '${appTranslation().get('abg_paco2_normal_range')} ${appTranslation().get('unit_mmhg')}',
        isAlert: paCo2 < 35 || paCo2 > 45,
      ),
      AbgMetricTileWidget(
        label: appTranslation().get('pao2'),
        value: paO2.toInt().toString(),
        range:
            '${appTranslation().get('abg_pao2_normal_range')} ${appTranslation().get('unit_mmhg')}',
        isAlert: paO2 < 60,
      ),
      AbgMetricTileWidget(
        label: appTranslation().get('hco3'),
        value: hco3.toStringAsFixed(1),
        range:
            '${appTranslation().get('abg_hco3_normal_range')} ${appTranslation().get('unit_meq_per_l')}',
        isAlert: hco3 < 22 || hco3 > 26,
      ),
      AbgMetricTileWidget(
        label: appTranslation().get('base_excess'),
        value: baseExcess.toStringAsFixed(1),
        range: appTranslation().get('abg_base_excess_range'),
        isAlert: baseExcess.abs() > 2,
      ),
      AbgMetricTileWidget(
        label: appTranslation().get('fio2'),
        value: '${fio2.toInt()}${appTranslation().get('unit_percent')}',
        range: appTranslation().get('current_ventilator'),
        isAlert: false,
      ),
    ],
  );
}
