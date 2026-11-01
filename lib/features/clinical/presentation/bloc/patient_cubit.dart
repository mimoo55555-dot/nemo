import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemoventrt/features/clinical/domain/entities/patient.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/acknowledge_alert_usecase.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/add_abg_result_usecase.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/add_vital_observation_usecase.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/discharge_patient_usecase.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/get_patients_stream_usecase.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/save_patient_usecase.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/update_ventilator_settings_usecase.dart';
import 'package:nemoventrt/features/clinical/presentation/bloc/patient_state.dart';

class PatientCubit extends Cubit<PatientState> {
  final GetPatientsStreamUseCase getPatientsStreamUseCase;
  final SavePatientUseCase savePatientUseCase;
  final UpdateVentilatorSettingsUseCase updateVentilatorSettingsUseCase;
  final AddABGResultUseCase addABGResultUseCase;
  final AddVitalObservationUseCase addVitalObservationUseCase;
  final AcknowledgeAlertUseCase acknowledgeAlertUseCase;
  final DischargePatientUseCase dischargePatientUseCase;

  StreamSubscription<List<Patient>>? _patientsSubscription;

  PatientCubit({
    required this.getPatientsStreamUseCase,
    required this.savePatientUseCase,
    required this.updateVentilatorSettingsUseCase,
    required this.addABGResultUseCase,
    required this.addVitalObservationUseCase,
    required this.acknowledgeAlertUseCase,
    required this.dischargePatientUseCase,
  }) : super(const PatientState());

  Future<void> loadPatients() async {
    emit(state.copyWith(status: PatientStatus.loading));
    await _patientsSubscription?.cancel();
    _patientsSubscription = getPatientsStreamUseCase().listen(
      (patients) {
        emit(
          state.copyWith(
            status: PatientStatus.loaded,
            patients: patients,
          ),
        );
      },
      onError: (Object error) {
        emit(
          state.copyWith(
            status: PatientStatus.error,
            errorMessage: error.toString(),
          ),
        );
      },
    );
  }

  void selectPatient(String? patientId) {
    emit(state.copyWith(selectedPatientId: patientId));
  }

  void filterPatientsByCategory(String category) {
    emit(state.copyWith(categoryFilter: category));
  }

  Future<void> savePatient(Patient patient) async {
    try {
      await savePatientUseCase(patient);
      emit(state.copyWith(selectedPatientId: patient.id));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> updateVentilatorSettings(
    String patientId,
    VentilatorSettings settings,
  ) async {
    try {
      await updateVentilatorSettingsUseCase(patientId, settings);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> addABGResult(
    String patientId,
    ABGResult abg,
    List<ABGResult> currentList,
  ) async {
    try {
      await addABGResultUseCase(patientId, abg, currentList);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> addVitalObservation(
    String patientId,
    VitalObservation obs,
    List<VitalObservation> currentList,
  ) async {
    try {
      await addVitalObservationUseCase(patientId, obs, currentList);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> acknowledgeAlert(
    String patientId,
    String alertId,
    String staffName,
    List<CriticalAlert> currentList,
  ) async {
    try {
      await acknowledgeAlertUseCase(
        patientId,
        alertId,
        staffName,
        currentList,
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> dischargePatient(String patientId) async {
    try {
      await dischargePatientUseCase(patientId);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _patientsSubscription?.cancel();
    return super.close();
  }
}
