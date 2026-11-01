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
    crossAxisCount: 3,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisSpacing: 8,
    mainAxisSpacing: 8,
    childAspectRatio: 1.3,
    children: [
      AbgMetricTileWidget(
        label: appTranslation().get('ph'),
        value: ph.toStringAsFixed(2),
        range: '7.35–7.45',
        isAlert: ph < 7.35 || ph > 7.45,
      ),
      AbgMetricTileWidget(
        label: appTranslation().get('paco2'),
        value: paCo2.toInt().toString(),
        range: '35–45 mmHg',
        isAlert: paCo2 < 35 || paCo2 > 45,
      ),
      AbgMetricTileWidget(
        label: appTranslation().get('pao2'),
        value: paO2.toInt().toString(),
        range: '80–100 mmHg',
        isAlert: paO2 < 60,
      ),
      AbgMetricTileWidget(
        label: appTranslation().get('hco3'),
        value: hco3.toStringAsFixed(1),
        range: '22–26 mEq/L',
        isAlert: hco3 < 22 || hco3 > 26,
      ),
      AbgMetricTileWidget(
        label: appTranslation().get('base_excess'),
        value: baseExcess.toStringAsFixed(1),
        range: '−2 to +2',
        isAlert: baseExcess.abs() > 2,
      ),
      AbgMetricTileWidget(
        label: appTranslation().get('fio2'),
        value: '${fio2.toInt()}%',
        range: appTranslation().get('current_ventilator'),
        isAlert: false,
      ),
    ],
  );
}
