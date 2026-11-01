import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/acknowledge_alert_usecase.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/add_abg_result_usecase.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/add_vital_observation_usecase.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/discharge_patient_usecase.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/get_patients_stream_usecase.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/save_patient_usecase.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/update_ventilator_settings_usecase.dart';
import 'package:nemoventrt/features/clinical/presentation/bloc/patient_event.dart';
import 'package:nemoventrt/features/clinical/presentation/bloc/patient_state.dart';

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  final GetPatientsStreamUseCase getPatientsStreamUseCase;
  final SavePatientUseCase savePatientUseCase;
  final UpdateVentilatorSettingsUseCase updateVentilatorSettingsUseCase;
  final AddABGResultUseCase addABGResultUseCase;
  final AddVitalObservationUseCase addVitalObservationUseCase;
  final AcknowledgeAlertUseCase acknowledgeAlertUseCase;
  final DischargePatientUseCase dischargePatientUseCase;

  StreamSubscription? _patientsSubscription;

  PatientBloc({
    required this.getPatientsStreamUseCase,
    required this.savePatientUseCase,
    required this.updateVentilatorSettingsUseCase,
    required this.addABGResultUseCase,
    required this.addVitalObservationUseCase,
    required this.acknowledgeAlertUseCase,
    required this.dischargePatientUseCase,
  }) : super(const PatientState()) {
    on<LoadPatients>(_onLoadPatients);
    on<PatientsUpdated>(_onPatientsUpdated);
    on<PatientsStreamError>(_onPatientsStreamError);
    on<SelectPatient>(_onSelectPatient);
    on<FilterPatientsByCategory>(_onFilterPatientsByCategory);
    on<SavePatientEvent>(_onSavePatient);
    on<UpdateVentilatorSettingsEvent>(_onUpdateVentilatorSettings);
    on<AddABGResultEvent>(_onAddABGResult);
    on<AddVitalObservationEvent>(_onAddVitalObservation);
    on<AcknowledgeAlertEvent>(_onAcknowledgeAlert);
    on<DischargePatientEvent>(_onDischargePatient);
  }

  Future<void> _onLoadPatients(
    LoadPatients event,
    Emitter<PatientState> emit,
  ) async {
    emit(state.copyWith(status: PatientStatus.loading));
    await _patientsSubscription?.cancel();
    _patientsSubscription = getPatientsStreamUseCase().listen(
      (patients) => add(PatientsUpdated(patients)),
      onError: (Object error) => add(PatientsStreamError(error.toString())),
    );
  }

  void _onPatientsUpdated(
    PatientsUpdated event,
    Emitter<PatientState> emit,
  ) {
    emit(
      state.copyWith(
        status: PatientStatus.loaded,
        patients: event.patients,
      ),
    );
  }

  void _onPatientsStreamError(
    PatientsStreamError event,
    Emitter<PatientState> emit,
  ) {
    emit(
      state.copyWith(
        status: PatientStatus.error,
        errorMessage: event.message,
      ),
    );
  }

  void _onSelectPatient(
    SelectPatient event,
    Emitter<PatientState> emit,
  ) {
    emit(state.copyWith(selectedPatientId: event.patientId));
  }

  void _onFilterPatientsByCategory(
    FilterPatientsByCategory event,
    Emitter<PatientState> emit,
  ) {
    emit(state.copyWith(categoryFilter: event.category));
  }

  Future<void> _onSavePatient(
    SavePatientEvent event,
    Emitter<PatientState> emit,
  ) async {
    try {
      await savePatientUseCase(event.patient);
      emit(state.copyWith(selectedPatientId: event.patient.id));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> _onUpdateVentilatorSettings(
    UpdateVentilatorSettingsEvent event,
    Emitter<PatientState> emit,
  ) async {
    try {
      await updateVentilatorSettingsUseCase(
        event.patientId,
        event.settings,
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> _onAddABGResult(
    AddABGResultEvent event,
    Emitter<PatientState> emit,
  ) async {
    try {
      await addABGResultUseCase(
        event.patientId,
        event.abg,
        event.currentList,
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> _onAddVitalObservation(
    AddVitalObservationEvent event,
    Emitter<PatientState> emit,
  ) async {
    try {
      await addVitalObservationUseCase(
        event.patientId,
        event.obs,
        event.currentList,
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> _onAcknowledgeAlert(
    AcknowledgeAlertEvent event,
    Emitter<PatientState> emit,
  ) async {
    try {
      await acknowledgeAlertUseCase(
        event.patientId,
        event.alertId,
        event.staffName,
        event.currentList,
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> _onDischargePatient(
    DischargePatientEvent event,
    Emitter<PatientState> emit,
  ) async {
    try {
      await dischargePatientUseCase(event.patientId);
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
