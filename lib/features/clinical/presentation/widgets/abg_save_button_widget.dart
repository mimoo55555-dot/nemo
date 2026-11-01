import 'package:flutter/material.dart';
import 'package:nemoventrt/core/utils/constants/primary/primary_action_button_widget.dart';

class AbgSaveButtonWidget extends StatelessWidget {
  final bool isSaving;
  final VoidCallback onPressed;

  const AbgSaveButtonWidget({
    super.key,
    required this.isSaving,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => PrimaryActionButtonWidget(
    labelKey: 'save_abg_to_patient_flowsheet',
    icon: Icons.save,
    isLoading: isSaving,
    onPressed: onPressed,
  );
}
