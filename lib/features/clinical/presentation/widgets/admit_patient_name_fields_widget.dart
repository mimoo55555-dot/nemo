import 'package:flutter/material.dart';
import 'package:nemoventrt/core/utils/constants/primary/primary_text_form_field.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';

class AdmitPatientNameFieldsWidget extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String bed;
  final String mrn;
  final ValueChanged<String> onFirstNameSaved;
  final ValueChanged<String> onLastNameSaved;
  final ValueChanged<String> onBedSaved;
  final ValueChanged<String> onMrnSaved;

  const AdmitPatientNameFieldsWidget({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.bed,
    required this.mrn,
    required this.onFirstNameSaved,
    required this.onLastNameSaved,
    required this.onBedSaved,
    required this.onMrnSaved,
  });

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Row(
        children: [
          Expanded(
            child: PrimaryTextFormField(
              labelKey: 'first_name',
              initialValue: firstName,
              isRequired: true,
              onSaved: (value) => onFirstNameSaved(value ?? ''),
            ),
          ),
          horizontalSpace8,
          Expanded(
            child: PrimaryTextFormField(
              labelKey: 'last_name',
              initialValue: lastName,
              isRequired: true,
              onSaved: (value) => onLastNameSaved(value ?? ''),
            ),
          ),
        ],
      ),
      verticalSpace8,
      Row(
        children: [
          Expanded(
            child: PrimaryTextFormField(
              labelKey: 'bed_unit',
              initialValue: bed,
              onSaved: (value) => onBedSaved(value ?? ''),
            ),
          ),
          horizontalSpace8,
          Expanded(
            child: PrimaryTextFormField(
              labelKey: 'mrn_number',
              initialValue: mrn,
              onSaved: (value) => onMrnSaved(value ?? ''),
            ),
          ),
        ],
      ),
    ],
  );
}
