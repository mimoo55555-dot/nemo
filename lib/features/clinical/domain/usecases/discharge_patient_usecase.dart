import 'package:nemoventrt/features/clinical/domain/repositories/patient_repository.dart';

class DischargePatientUseCase {
  final PatientRepository repository;

  DischargePatientUseCase(this.repository);

  Future<void> call(String patientId) {
    return repository.dischargePatient(patientId);
  }
}
