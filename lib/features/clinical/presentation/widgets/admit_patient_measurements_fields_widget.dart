import 'package:flutter/material.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/primary/primary_text_form_field.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';

class AdmitPatientMeasurementsFieldsWidget extends StatelessWidget {
  final int age;
  final double heightCm;
  final double actualWeightKg;
  final ValueChanged<int> onAgeSaved;
  final ValueChanged<double> onHeightSaved;
  final ValueChanged<double> onWeightSaved;

  const AdmitPatientMeasurementsFieldsWidget({
    super.key,
    required this.age,
    required this.heightCm,
    required this.actualWeightKg,
    required this.onAgeSaved,
    required this.onHeightSaved,
    required this.onWeightSaved,
  });

  @override
  Widget build(BuildContext context) => Column(
    children: [
      verticalSpace8,
      PrimaryTextFormField(
        labelKey: 'age',
        initialValue: '$age',
        keyboardType: TextInputType.number,
        isRequired: true,
        validator: (value) {
          final parsedAge = int.tryParse(value?.trim() ?? '');
          return parsedAge == null || parsedAge < 1 || parsedAge > 120
              ? appTranslation().get('enter_valid_age')
              : null;
        },
        onSaved: (value) => onAgeSaved(
          int.tryParse(value?.trim() ?? '') ?? age,
        ),
      ),
      verticalSpace8,
      Row(
        children: [
          Expanded(
            child: PrimaryTextFormField(
              labelKey: 'height_cm',
              initialValue: heightCm.toString(),
              keyboardType: TextInputType.number,
              onSaved: (value) => onHeightSaved(
                double.tryParse(value ?? '') ?? heightCm,
              ),
            ),
          ),
          horizontalSpace8,
          Expanded(
            child: PrimaryTextFormField(
              labelKey: 'weight_kg',
              initialValue: actualWeightKg.toString(),
              keyboardType: TextInputType.number,
              onSaved: (value) => onWeightSaved(
                double.tryParse(value ?? '') ?? actualWeightKg,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
