import 'package:nemoventrt/features/clinical/domain/entities/patient.dart';

abstract class PatientEvent {
  const PatientEvent();
}

class LoadPatients extends PatientEvent {
  const LoadPatients();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is LoadPatients;

  @override
  int get hashCode => runtimeType.hashCode;
}

class PatientsUpdated extends PatientEvent {
  final List<Patient> patients;

  const PatientsUpdated(this.patients);
}

class PatientsStreamError extends PatientEvent {
  final String message;

  const PatientsStreamError(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PatientsStreamError && message == other.message;

  @override
  int get hashCode => message.hashCode;
}

class SelectPatient extends PatientEvent {
  final String? patientId;

  const SelectPatient(this.patientId);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectPatient && patientId == other.patientId;

  @override
  int get hashCode => patientId.hashCode;
}

class FilterPatientsByCategory extends PatientEvent {
  final String category;

  const FilterPatientsByCategory(this.category);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterPatientsByCategory && category == other.category;

  @override
  int get hashCode => category.hashCode;
}

class SavePatientEvent extends PatientEvent {
  final Patient patient;

  const SavePatientEvent(this.patient);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavePatientEvent && patient == other.patient;

  @override
  int get hashCode => patient.hashCode;
}

class UpdateVentilatorSettingsEvent extends PatientEvent {
  final String patientId;
  final VentilatorSettings settings;

  const UpdateVentilatorSettingsEvent(this.patientId, this.settings);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdateVentilatorSettingsEvent &&
          patientId == other.patientId &&
          settings == other.settings;

  @override
  int get hashCode => Object.hash(patientId, settings);
}

class AddABGResultEvent extends PatientEvent {
  final String patientId;
  final ABGResult abg;
  final List<ABGResult> currentList;

  const AddABGResultEvent(this.patientId, this.abg, this.currentList);
}

class AddVitalObservationEvent extends PatientEvent {
  final String patientId;
  final VitalObservation obs;
  final List<VitalObservation> currentList;

  const AddVitalObservationEvent(this.patientId, this.obs, this.currentList);
}

class AcknowledgeAlertEvent extends PatientEvent {
  final String patientId;
  final String alertId;
  final String staffName;
  final List<CriticalAlert> currentList;

  const AcknowledgeAlertEvent({
    required this.patientId,
    required this.alertId,
    required this.staffName,
    required this.currentList,
  });
}

class DischargePatientEvent extends PatientEvent {
  final String patientId;

  const DischargePatientEvent(this.patientId);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DischargePatientEvent && patientId == other.patientId;

  @override
  int get hashCode => patientId.hashCode;
}
