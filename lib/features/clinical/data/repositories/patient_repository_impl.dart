import 'package:nemoventrt/features/clinical/data/datasources/patient_remote_data_source.dart';
import 'package:nemoventrt/features/clinical/domain/entities/patient.dart';
import 'package:nemoventrt/features/clinical/domain/repositories/patient_repository.dart';

class PatientRepositoryImpl implements PatientRepository {
  final PatientRemoteDataSource remoteDataSource;

  PatientRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<List<Patient>> getPatientsStream() {
    return remoteDataSource.getPatientsStream();
  }

  @override
  Future<void> savePatient(Patient patient) {
    return remoteDataSource.savePatient(patient);
  }

  @override
  Future<void> updateVentilatorSettings(
    String patientId,
    VentilatorSettings settings,
  ) {
    return remoteDataSource.updateVentilatorSettings(patientId, settings);
  }

  @override
  Future<void> addABGResult(
    String patientId,
    ABGResult abg,
    List<ABGResult> currentList,
  ) {
    return remoteDataSource.addABGResult(patientId, abg, currentList);
  }

  @override
  Future<void> addVitalObservation(
    String patientId,
    VitalObservation obs,
    List<VitalObservation> currentList,
  ) {
    return remoteDataSource.addVitalObservation(patientId, obs, currentList);
  }

  @override
  Future<void> acknowledgeAlert(
    String patientId,
    String alertId,
    String staffName,
    List<CriticalAlert> currentList,
  ) {
    return remoteDataSource.acknowledgeAlert(
      patientId,
      alertId,
      staffName,
      currentList,
    );
  }

  @override
  Future<void> dischargePatient(String patientId) {
    return remoteDataSource.dischargePatient(patientId);
  }
}
