import 'package:nemoventrt/features/clinical/domain/entities/patient.dart';
import 'package:nemoventrt/features/clinical/domain/repositories/patient_repository.dart';

class GetPatientsStreamUseCase {
  final PatientRepository repository;

  GetPatientsStreamUseCase(this.repository);

  Stream<List<Patient>> call() {
    return repository.getPatientsStream();
  }
}
