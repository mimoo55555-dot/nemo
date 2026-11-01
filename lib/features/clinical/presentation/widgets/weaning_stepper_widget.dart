import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/primary/primary_icon_button_widget.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';

class WeaningStepperWidget extends StatelessWidget {
  final String titleKey;
  final String value;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const WeaningStepperWidget({
    super.key,
    required this.titleKey,
    required this.value,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(16, 10, 16, 10),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appTranslation().get(titleKey),
                style: TextStylesManager.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              verticalSpace4,
              Text(
                value,
                style: TextStylesManager.subtitle.copyWith(
                  color: ColorsManager.primaryText,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        horizontalSpace8,
        PrimaryIconButtonWidget(
          semanticLabelKey: 'decrease_value',
          onPressed: onDecrement,
          icon: const Icon(Icons.remove_rounded),
        ),
        PrimaryIconButtonWidget(
          semanticLabelKey: 'increase_value',
          onPressed: onIncrement,
          icon: const Icon(Icons.add_rounded),
        ),
      ],
    ),
  );
}
