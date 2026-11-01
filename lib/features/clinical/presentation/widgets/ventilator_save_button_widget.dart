import 'package:flutter/material.dart';
import 'package:nemoventrt/core/utils/constants/primary/primary_action_button_widget.dart';

class VentilatorSaveButtonWidget extends StatelessWidget {
  final bool isSaving;
  final VoidCallback onPressed;

  const VentilatorSaveButtonWidget({
    super.key,
    required this.isSaving,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => PrimaryActionButtonWidget(
    labelKey: 'save_sync_ventilator_settings',
    loadingLabelKey: 'syncing_to_cloud',
    icon: Icons.check_circle_outline,
    isLoading: isSaving,
    height: 50,
    onPressed: onPressed,
  );
}
