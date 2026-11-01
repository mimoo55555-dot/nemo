import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/utils/constants/primary/primary_dropdown_form_field.dart';
import 'package:nemoventrt/core/utils/constants/primary/primary_text_form_field.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';

class AdmitPatientCategorySexFieldsWidget extends StatelessWidget {
  static const _categoryOptions = [
    PrimaryDropdownOption(value: PatientCategory.adult, labelKey: 'adult'),
    PrimaryDropdownOption(
      value: PatientCategory.pediatric,
      labelKey: 'pediatric',
    ),
    PrimaryDropdownOption(value: PatientCategory.neonate, labelKey: 'neonate'),
  ];
  static const _sexOptions = [
    PrimaryDropdownOption(value: BiologicalSex.male, labelKey: 'male'),
    PrimaryDropdownOption(value: BiologicalSex.female, labelKey: 'female'),
  ];

  final String diagnosis;
  final PatientCategory category;
  final BiologicalSex sex;
  final ValueChanged<String> onDiagnosisSaved;
  final ValueChanged<PatientCategory> onCategoryChanged;
  final ValueChanged<BiologicalSex> onSexChanged;

  const AdmitPatientCategorySexFieldsWidget({
    super.key,
    required this.diagnosis,
    required this.category,
    required this.sex,
    required this.onDiagnosisSaved,
    required this.onCategoryChanged,
    required this.onSexChanged,
  });

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Row(
        children: [
          Expanded(
            child: PrimaryDropdownFormField<PatientCategory>(
              labelKey: 'category',
              value: category,
              options: _categoryOptions,
              onChanged: (value) {
                if (value != null) onCategoryChanged(value);
              },
            ),
          ),
          horizontalSpace8,
          Expanded(
            child: PrimaryDropdownFormField<BiologicalSex>(
              labelKey: 'sex',
              value: sex,
              options: _sexOptions,
              onChanged: (value) {
                if (value != null) onSexChanged(value);
              },
            ),
          ),
        ],
      ),
      verticalSpace8,
      PrimaryTextFormField(
        labelKey: 'primary_icu_diagnosis',
        initialValue: diagnosis,
        onSaved: (value) => onDiagnosisSaved(value ?? ''),
      ),
      verticalSpace8,
    ],
  );
}
