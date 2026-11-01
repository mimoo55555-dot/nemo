import 'package:flutter/material.dart';
import 'package:nemoventrt/core/utils/constants/primary/primary_action_button_widget.dart';

class PatientCensusFooterWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const PatientCensusFooterWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsetsDirectional.fromSTEB(
      20,
      8,
      20,
      MediaQuery.paddingOf(context).bottom + 12,
    ),
    child: PrimaryActionButtonWidget(
      labelKey: 'admit_patient',
      icon: Icons.add,
      onPressed: onPressed,
    ),
  );
}
