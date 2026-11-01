import 'package:nemoventrt/features/clinical/domain/entities/patient.dart';
import 'package:nemoventrt/features/clinical/domain/repositories/patient_repository.dart';

class AcknowledgeAlertUseCase {
  final PatientRepository repository;

  AcknowledgeAlertUseCase(this.repository);

  Future<void> call(
    String patientId,
    String alertId,
    String staffName,
    List<CriticalAlert> currentList,
  ) {
    return repository.acknowledgeAlert(
      patientId,
      alertId,
      staffName,
      currentList,
    );
  }
}
