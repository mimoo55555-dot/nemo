import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/utils/constants/primary/primary_action_button_widget.dart';
import 'package:nemoventrt/core/utils/extensions/context_extension.dart';

class PatientDischargeDialogWidget extends StatelessWidget {
  final Patient patient;
  final VoidCallback onConfirm;

  const PatientDischargeDialogWidget({
    super.key,
    required this.patient,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(appTranslation().get('discharge_patient_question')),
    content: Text(
      appTranslation()
          .get('remove_patient_from_flowsheet')
          .replaceFirst('{name}', translateKnownValue(patient.fullName))
          .replaceFirst('{bed}', translateKnownValue(patient.bed)),
      style: TextStylesManager.body,
    ),
    actions: [
      TextButton(
        onPressed: () => context.pop,
        child: Text(appTranslation().get('cancel')),
      ),
      PrimaryActionButtonWidget(
        labelKey: 'discharge_and_remove',
        icon: Icons.delete_outline,
        isFullWidth: false,
        backgroundColor: ColorsManager.redAction,
        onPressed: () {
          context.pop;
          onConfirm();
        },
      ),
    ],
  );
}
