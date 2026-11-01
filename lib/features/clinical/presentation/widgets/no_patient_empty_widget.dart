import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';

class NoPatientEmptyWidget extends StatelessWidget {
  final VoidCallback onAdmitPatient;

  const NoPatientEmptyWidget({super.key, required this.onAdmitPatient});

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.air, size: 56, color: ColorsManager.primaryText),
          verticalSpace16,
          Text(
            appTranslation().get('no_patients_title'),
            style: TextStylesManager.title,
            textAlign: TextAlign.center,
          ),
          verticalSpace8,
          Text(
            appTranslation().get('no_patients_message'),
            style: TextStylesManager.bodySmall,
            textAlign: TextAlign.center,
          ),
          verticalSpace20,
          ElevatedButton.icon(
            onPressed: onAdmitPatient,
            icon: const Icon(Icons.add),
            label: Text(appTranslation().get('admit_patient')),
          ),
        ],
      ),
    ),
  );
}
