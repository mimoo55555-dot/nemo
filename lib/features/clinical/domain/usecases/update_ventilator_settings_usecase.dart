import 'package:nemoventrt/features/clinical/domain/entities/patient.dart';
import 'package:nemoventrt/features/clinical/domain/repositories/patient_repository.dart';

class UpdateVentilatorSettingsUseCase {
  final PatientRepository repository;

  UpdateVentilatorSettingsUseCase(this.repository);

  Future<void> call(String patientId, VentilatorSettings settings) {
    return repository.updateVentilatorSettings(patientId, settings);
  }
}
