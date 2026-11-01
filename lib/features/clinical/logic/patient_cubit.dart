import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemoventrt/core/errors/failures.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/network/clinical_network_service.dart';
import 'package:nemoventrt/core/utils/clinical_calculators.dart';
import 'package:nemoventrt/core/utils/either.dart';
import 'package:nemoventrt/features/clinical/logic/patient_state.dart';

class PatientCubit extends Cubit<PatientState> {
  PatientCubit() : super(const PatientState());

  static PatientCubit get(BuildContext context) => BlocProvider.of(context);

  late final ClinicalNetworkService _networkService;
  StreamSubscription<Either<Failure, List<Patient>>>? _patientsSubscription;

  Future<void> init(ClinicalNetworkService networkService) async {
    _networkService = networkService;
    await loadPatients();
  }

  Future<void> loadPatients() async {
    emit(state.copyWith(status: PatientStatus.loading, errorMessage: null));
    await _patientsSubscription?.cancel();
    _patientsSubscription = _networkService.watchPatients().listen(
      _handlePatientsResult,
      onError: (_) => _emitFailure(const ServerFailure('error_unknown')),
    );
  }

  void _handlePatientsResult(Either<Failure, List<Patient>> result) {
    result.fold(
      _emitFailure,
      (patients) => emit(
        state.copyWith(
          status: patients.isEmpty ? PatientStatus.empty : PatientStatus.loaded,
          patients: patients,
          errorMessage: null,
        ),
      ),
    );
  }

  void _emitFailure(Failure failure) {
    emit(
      state.copyWith(
        status: PatientStatus.error,
        errorMessage: failure.messageKey,
      ),
    );
  }

  void selectPatient(String? patientId) {
    emit(state.copyWith(selectedPatientId: patientId));
  }

  void filterPatientsByCategory(String category) {
    emit(state.copyWith(categoryFilter: category));
  }

  Future<bool> savePatient(Patient patient) async => _emitActionResult(
    await _networkService.savePatient(patient),
    selectedPatientId: patient.id,
  );

  Future<bool> admitPatient({
    required String mrn,
    required String bed,
    required String unit,
    required String firstName,
    required String lastName,
    required int age,
    required PatientCategory category,
    required BiologicalSex sex,
    required double heightCm,
    required double actualWeightKg,
    required String diagnosis,
    required String mode,
    required double tidalVolume,
    required int setRate,
    required double peep,
    required double fio2,
  }) {
    final now = DateTime.now();
    return savePatient(
      Patient(
        id: 'pat-${now.millisecondsSinceEpoch}',
        mrn: mrn,
        bed: bed,
        unit: unit,
        firstName: firstName,
        lastName: lastName,
        age: age,
        category: category,
        sex: sex,
        heightCm: heightCm,
        actualWeightKg: actualWeightKg,
        diagnosis: diagnosis,
        ventilatorSettings: VentilatorSettings(
          mode: mode,
          tidalVolume: tidalVolume,
          setRate: setRate,
          totalRate: setRate,
          peep: peep,
          fio2: fio2,
          peakPressure: 22,
          plateauPressure: 18,
          inspTime: .9,
          ieRatio: '1:2.0',
          peakFlow: 60,
        ),
        admissionDate: now.toIso8601String().substring(0, 10),
        intubationDate: now.toIso8601String().substring(0, 10),
        etTubeSize: 7.5,
        etTubeDepth: 22,
        criticalAlerts: const [],
        recentABGs: const [],
        vitalsHistory: const [],
      ),
    );
  }

  Future<bool> updateVentilatorSettings(
    String patientId,
    VentilatorSettings settings,
  ) async => _emitActionResult(
    await _networkService.updateVentilatorSettings(patientId, settings),
  );

  Future<bool> addABGResult(
    String patientId,
    ABGResult result,
    List<ABGResult> currentList,
  ) async => _emitActionResult(
    await _networkService.addABGResult(patientId, result, currentList),
  );

  Future<bool> addABGValues({
    required Patient patient,
    required double ph,
    required double paCo2,
    required double paO2,
    required double hco3,
    required double baseExcess,
    required double fio2,
  }) async {
    final now = DateTime.now();
    final interpretation = ClinicalCalculators.interpretABG(
      ph: ph,
      paCo2: paCo2,
      paO2: paO2,
      hco3: hco3,
      fio2: fio2,
    );
    final result = ABGResult(
      id: 'abg-${now.millisecondsSinceEpoch}',
      timestamp:
          '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}',
      sampleType: 'Arterial',
      ph: ph,
      paCo2: paCo2,
      paO2: paO2,
      hco3: hco3,
      baseExcess: baseExcess,
      fio2: fio2,
      pfRatio: interpretation['pfRatio'] as double,
      interpretation:
          '${interpretation['primaryDiagnosis']}|${interpretation['oxygenationStatus']}',
    );
    return addABGResult(patient.id, result, patient.recentABGs);
  }

  Future<bool> addVitalObservation(
    String patientId,
    VitalObservation observation,
    List<VitalObservation> currentList,
  ) async => _emitActionResult(
    await _networkService.addVitalObservation(
      patientId,
      observation,
      currentList,
    ),
  );

  Future<bool> acknowledgeAlert(
    String patientId,
    String alertId,
    String staffName,
    List<CriticalAlert> currentList,
  ) async => _emitActionResult(
    await _networkService.acknowledgeAlert(
      patientId,
      alertId,
      staffName,
      currentList,
    ),
  );

  Future<bool> dischargePatient(String patientId) async => _emitActionResult(
    await _networkService.dischargePatient(patientId),
  );

  bool _emitActionResult(
    Either<Failure, bool> result, {
    String? selectedPatientId,
  }) => result.fold(
    (failure) {
      emit(state.copyWith(errorMessage: failure.messageKey));
      return false;
    },
    (_) {
      if (selectedPatientId != null || state.errorMessage != null) {
        emit(
          state.copyWith(
            selectedPatientId: selectedPatientId,
            errorMessage: null,
          ),
        );
      }
      return true;
    },
  );

  @override
  Future<void> close() async {
    await _patientsSubscription?.cancel();
    await super.close();
  }
}
