import 'package:flutter/material.dart';
import 'package:nemoventrt/core/utils/constants/primary/primary_text_form_field.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';

class AdmitPatientMeasurementsFieldsWidget extends StatelessWidget {
  final double heightCm;
  final double actualWeightKg;
  final ValueChanged<double> onHeightSaved;
  final ValueChanged<double> onWeightSaved;

  const AdmitPatientMeasurementsFieldsWidget({
    super.key,
    required this.heightCm,
    required this.actualWeightKg,
    required this.onHeightSaved,
    required this.onWeightSaved,
  });

  @override
  Widget build(BuildContext context) => Column(
    children: [
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
