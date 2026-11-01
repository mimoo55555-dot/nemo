import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/admit_patient_form_data.dart';

class AdmitPatientFormController {
  final VoidCallback onChanged;

  AdmitPatientFormController({required this.onChanged});

  String firstName = '';
  String lastName = '';
  String bed = appTranslation().get('default_bed');
  String mrn = 'MRN-100201';
  String diagnosis = appTranslation().get('default_ards_diagnosis');
  String mode = 'VC-CMV';
  PatientCategory category = PatientCategory.adult;
  BiologicalSex sex = BiologicalSex.male;
  double heightCm = 175;
  double actualWeightKg = 75;
  double tidalVolume = 450;
  int setRate = 16;
  double peep = 10;
  double fio2 = 60;

  AdmitPatientFormData get values => AdmitPatientFormData(
    firstName: firstName,
    lastName: lastName,
    bed: bed,
    mrn: mrn,
    diagnosis: diagnosis,
    category: category,
    sex: sex,
    heightCm: heightCm,
    actualWeightKg: actualWeightKg,
    mode: mode,
    tidalVolume: tidalVolume,
    setRate: setRate,
    peep: peep,
    fio2: fio2,
  );

  AdmitPatientFormCallbacks get callbacks => AdmitPatientFormCallbacks(
    onFirstNameSaved: (value) => firstName = value,
    onLastNameSaved: (value) => lastName = value,
    onBedSaved: (value) => bed = value,
    onMrnSaved: (value) => mrn = value,
    onDiagnosisSaved: (value) => diagnosis = value,
    onCategoryChanged: (value) {
      category = value;
      onChanged();
    },
    onSexChanged: (value) {
      sex = value;
      onChanged();
    },
    onHeightSaved: (value) => heightCm = value,
    onWeightSaved: (value) => actualWeightKg = value,
    onModeChanged: (value) {
      mode = value;
      onChanged();
    },
    onTidalVolumeSaved: (value) => tidalVolume = value,
    onRateSaved: (value) => setRate = value,
    onPeepSaved: (value) => peep = value,
    onFio2Saved: (value) => fio2 = value,
  );
}
