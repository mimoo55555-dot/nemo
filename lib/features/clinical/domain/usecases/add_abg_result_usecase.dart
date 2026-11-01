import 'package:nemoventrt/features/clinical/domain/entities/patient.dart';
import 'package:nemoventrt/features/clinical/domain/repositories/patient_repository.dart';

class AddABGResultUseCase {
  final PatientRepository repository;

  AddABGResultUseCase(this.repository);

  Future<void> call(
    String patientId,
    ABGResult abg,
    List<ABGResult> currentList,
  ) {
    return repository.addABGResult(patientId, abg, currentList);
  }
}
