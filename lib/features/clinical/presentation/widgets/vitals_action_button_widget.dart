import 'package:flutter/material.dart';
import 'package:nemoventrt/core/utils/constants/primary/primary_action_button_widget.dart';

class VitalsActionButtonWidget extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const VitalsActionButtonWidget({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => PrimaryActionButtonWidget(
    labelKey: 'log_vitals_observation',
    loadingLabelKey: 'saving_vitals',
    icon: Icons.add_chart,
    isLoading: isLoading,
    onPressed: onPressed,
  );
}
