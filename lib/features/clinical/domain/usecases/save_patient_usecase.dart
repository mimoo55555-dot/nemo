import 'package:nemoventrt/features/clinical/domain/entities/patient.dart';
import 'package:nemoventrt/features/clinical/domain/repositories/patient_repository.dart';

class SavePatientUseCase {
  final PatientRepository repository;

  SavePatientUseCase(this.repository);

  Future<void> call(Patient patient) {
    return repository.savePatient(patient);
  }
}
