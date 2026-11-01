import 'package:flutter/material.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/primary/primary_action_button_widget.dart';

class AdmitPatientDialogActionsWidget extends StatelessWidget {
  final bool isSaving;
  final VoidCallback onCancel;
  final VoidCallback onSubmit;

  const AdmitPatientDialogActionsWidget({
    super.key,
    required this.isSaving,
    required this.onCancel,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) => OverflowBar(
    alignment: MainAxisAlignment.end,
    overflowAlignment: OverflowBarAlignment.end,
    overflowSpacing: 8,
    children: [
      TextButton(
        onPressed: isSaving ? null : onCancel,
        child: Text(appTranslation().get('cancel')),
      ),
      PrimaryActionButtonWidget(
        labelKey: 'admit_patient',
        loadingLabelKey: 'saving_patient',
        icon: Icons.person_add_alt_1,
        isLoading: isSaving,
        isFullWidth: false,
        onPressed: onSubmit,
      ),
    ],
  );
}
