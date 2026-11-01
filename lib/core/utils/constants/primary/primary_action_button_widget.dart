import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/primary/conditional_builder.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';

class PrimaryActionButtonWidget extends StatelessWidget {
  final String labelKey;
  final String? loadingLabelKey;
  final IconData icon;
  final bool isLoading;
  final bool isFullWidth;
  final double height;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback onPressed;

  const PrimaryActionButtonWidget({
    super.key,
    required this.labelKey,
    required this.icon,
    required this.onPressed,
    this.loadingLabelKey,
    this.isLoading = false,
    this.isFullWidth = true,
    this.height = 48,
    this.backgroundColor = ColorsManager.primary,
    this.foregroundColor = ColorsManager.white,
  });

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        minimumSize: Size.fromHeight(height),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      onPressed: isLoading ? null : onPressed,
      child: Row(
        mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          horizontalSpace8,
          ConditionalBuilder(
            loadingState: isLoading,
            loadingBuilder: (_) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(
                  color: ColorsManager.white,
                  strokeWidth: 2,
                ),
                horizontalSpace8,
                Text(
                  appTranslation().get(loadingLabelKey ?? labelKey),
                  style: TextStylesManager.buttonLabel,
                ),
              ],
            ),
            successBuilder: (_) => Text(
              appTranslation().get(labelKey),
              style: TextStylesManager.buttonLabel,
            ),
          ),
        ],
      ),
    );
    if (!isFullWidth) return button;
    return FractionallySizedBox(
      alignment: AlignmentDirectional.center,
      widthFactor: 1,
      child: button,
    );
  }
}
