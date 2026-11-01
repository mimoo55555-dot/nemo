import 'package:flutter/material.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';

class PrimaryIconButtonWidget extends StatelessWidget {
  final String semanticLabelKey;
  final VoidCallback onPressed;
  final Widget icon;

  const PrimaryIconButtonWidget({
    super.key,
    required this.semanticLabelKey,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) => IconButton(
    tooltip: appTranslation().get(semanticLabelKey),
    constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
    onPressed: onPressed,
    icon: icon,
  );
}
