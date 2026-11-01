import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/weaning_readiness_checkbox_widget.dart';

class WeaningChecklistWidget extends StatelessWidget {
  final bool gasExchangeAcceptable;
  final bool hemodynamicStable;
  final bool mentalStatusAlert;
  final bool airwayCuffLeakPositive;
  final ValueChanged<bool?> onGasExchangeChanged;
  final ValueChanged<bool?> onHemodynamicChanged;
  final ValueChanged<bool?> onMentalStatusChanged;
  final ValueChanged<bool?> onCuffLeakChanged;

  const WeaningChecklistWidget({
    super.key,
    required this.gasExchangeAcceptable,
    required this.hemodynamicStable,
    required this.mentalStatusAlert,
    required this.airwayCuffLeakPositive,
    required this.onGasExchangeChanged,
    required this.onHemodynamicChanged,
    required this.onMentalStatusChanged,
    required this.onCuffLeakChanged,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        appTranslation().get('extubation_readiness_criteria'),
        style: TextStylesManager.subtitle,
      ),
      verticalSpace8,
      WeaningReadinessCheckboxWidget(
        titleKey: 'adequate_gas_exchange',
        value: gasExchangeAcceptable,
        onChanged: onGasExchangeChanged,
      ),
      WeaningReadinessCheckboxWidget(
        titleKey: 'hemodynamic_stability',
        value: hemodynamicStable,
        onChanged: onHemodynamicChanged,
      ),
      WeaningReadinessCheckboxWidget(
        titleKey: 'neurological_readiness',
        value: mentalStatusAlert,
        onChanged: onMentalStatusChanged,
      ),
      WeaningReadinessCheckboxWidget(
        titleKey: 'positive_cuff_leak_test',
        value: airwayCuffLeakPositive,
        onChanged: onCuffLeakChanged,
      ),
    ],
  );
}
