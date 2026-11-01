import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';

class AdmitPatientFormData {
  final String firstName;
  final String lastName;
  final String bed;
  final String mrn;
  final String diagnosis;
  final PatientCategory category;
  final BiologicalSex sex;
  final int age;
  final double heightCm;
  final double actualWeightKg;
  final String mode;
  final double tidalVolume;
  final int setRate;
  final double peep;
  final double fio2;

  const AdmitPatientFormData({
    required this.firstName,
    required this.lastName,
    required this.bed,
    required this.mrn,
    required this.diagnosis,
    required this.category,
    required this.sex,
    required this.age,
    required this.heightCm,
    required this.actualWeightKg,
    required this.mode,
    required this.tidalVolume,
    required this.setRate,
    required this.peep,
    required this.fio2,
  });
}

class AdmitPatientFormCallbacks {
  final ValueChanged<String> onFirstNameSaved;
  final ValueChanged<String> onLastNameSaved;
  final ValueChanged<String> onBedSaved;
  final ValueChanged<String> onMrnSaved;
  final ValueChanged<String> onDiagnosisSaved;
  final ValueChanged<PatientCategory> onCategoryChanged;
  final ValueChanged<BiologicalSex> onSexChanged;
  final ValueChanged<int> onAgeSaved;
  final ValueChanged<double> onHeightSaved;
  final ValueChanged<double> onWeightSaved;
  final ValueChanged<String> onModeChanged;
  final ValueChanged<double> onTidalVolumeSaved;
  final ValueChanged<int> onRateSaved;
  final ValueChanged<double> onPeepSaved;
  final ValueChanged<double> onFio2Saved;

  const AdmitPatientFormCallbacks({
    required this.onFirstNameSaved,
    required this.onLastNameSaved,
    required this.onBedSaved,
    required this.onMrnSaved,
    required this.onDiagnosisSaved,
    required this.onCategoryChanged,
    required this.onSexChanged,
    required this.onAgeSaved,
    required this.onHeightSaved,
    required this.onWeightSaved,
    required this.onModeChanged,
    required this.onTidalVolumeSaved,
    required this.onRateSaved,
    required this.onPeepSaved,
    required this.onFio2Saved,
  });
}
