import 'package:nemoventrt/features/clinical/domain/entities/patient.dart';

abstract class PatientRepository {
  /// Real-time stream of all ICU patients
  Stream<List<Patient>> getPatientsStream();

  /// Save or update a patient in storage
  Future<void> savePatient(Patient patient);

  /// Update ventilator settings for a specific patient
  Future<void> updateVentilatorSettings(
    String patientId,
    VentilatorSettings settings,
  );

  /// Add ABG result to patient record
  Future<void> addABGResult(
    String patientId,
    ABGResult abg,
    List<ABGResult> currentList,
  );

  /// Add Vital observation to patient record
  Future<void> addVitalObservation(
    String patientId,
    VitalObservation obs,
    List<VitalObservation> currentList,
  );

  /// Acknowledge a critical alert
  Future<void> acknowledgeAlert(
    String patientId,
    String alertId,
    String staffName,
    List<CriticalAlert> currentList,
  );

  /// Discharge and remove a patient
  Future<void> dischargePatient(String patientId);
}
