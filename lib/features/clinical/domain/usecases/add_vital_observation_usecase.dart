import 'package:nemoventrt/features/clinical/domain/entities/patient.dart';
import 'package:nemoventrt/features/clinical/domain/repositories/patient_repository.dart';

class AddVitalObservationUseCase {
  final PatientRepository repository;

  AddVitalObservationUseCase(this.repository);

  Future<void> call(
    String patientId,
    VitalObservation obs,
    List<VitalObservation> currentList,
  ) {
    return repository.addVitalObservation(patientId, obs, currentList);
  }
}
