import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/primary/primary_action_button_widget.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';

class PatientErrorStateWidget extends StatelessWidget {
  final String messageKey;
  final VoidCallback onRetry;

  const PatientErrorStateWidget({
    super.key,
    required this.messageKey,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.cloud_off, size: 48, color: ColorsManager.orange),
          verticalSpace12,
          Text(appTranslation().get(messageKey), textAlign: TextAlign.center),
          verticalSpace16,
          PrimaryActionButtonWidget(
            labelKey: 'retry_connection',
            icon: Icons.refresh,
            isFullWidth: false,
            onPressed: onRetry,
          ),
        ],
      ),
    ),
  );
}
