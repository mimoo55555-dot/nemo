import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/admit_patient_category_sex_fields_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/admit_patient_name_fields_widget.dart';

class AdmitPatientIdentityFieldsWidget extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String bed;
  final String mrn;
  final String diagnosis;
  final PatientCategory category;
  final BiologicalSex sex;
  final ValueChanged<String> onFirstNameSaved;
  final ValueChanged<String> onLastNameSaved;
  final ValueChanged<String> onBedSaved;
  final ValueChanged<String> onMrnSaved;
  final ValueChanged<String> onDiagnosisSaved;
  final ValueChanged<PatientCategory> onCategoryChanged;
  final ValueChanged<BiologicalSex> onSexChanged;

  const AdmitPatientIdentityFieldsWidget({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.bed,
    required this.mrn,
    required this.diagnosis,
    required this.category,
    required this.sex,
    required this.onFirstNameSaved,
    required this.onLastNameSaved,
    required this.onBedSaved,
    required this.onMrnSaved,
    required this.onDiagnosisSaved,
    required this.onCategoryChanged,
    required this.onSexChanged,
  });

  @override
  Widget build(BuildContext context) => Column(
    children: [
      AdmitPatientNameFieldsWidget(
        firstName: firstName,
        lastName: lastName,
        bed: bed,
        mrn: mrn,
        onFirstNameSaved: onFirstNameSaved,
        onLastNameSaved: onLastNameSaved,
        onBedSaved: onBedSaved,
        onMrnSaved: onMrnSaved,
      ),
      verticalSpace8,
      AdmitPatientCategorySexFieldsWidget(
        diagnosis: diagnosis,
        category: category,
        sex: sex,
        onDiagnosisSaved: onDiagnosisSaved,
        onCategoryChanged: onCategoryChanged,
        onSexChanged: onSexChanged,
      ),
    ],
  );
}
