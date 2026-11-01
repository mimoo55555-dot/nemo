import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nemoventrt/core/errors/failures.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/network/clinical_network_service.dart';
import 'package:nemoventrt/core/utils/either.dart';
import 'package:nemoventrt/features/clinical/logic/patient_cubit.dart';
import 'package:nemoventrt/features/clinical/logic/patient_state.dart';

class MockClinicalNetworkService extends Mock
    implements ClinicalNetworkService {}

const testPatient = Patient(
  id: 'pat-1',
  mrn: 'MRN-001',
  bed: 'Bed 01',
  unit: 'Medical ICU',
  firstName: 'John',
  lastName: 'Doe',
  age: 55,
  category: PatientCategory.adult,
  sex: BiologicalSex.male,
  heightCm: 175,
  actualWeightKg: 75,
  diagnosis: 'ARDS',
  ventilatorSettings: VentilatorSettings(
    mode: 'VC-CMV',
    tidalVolume: 450,
    setRate: 14,
    totalRate: 14,
    peep: 5,
    fio2: 40,
    peakPressure: 22,
    plateauPressure: 18,
    inspTime: 0.9,
    ieRatio: '1:2.0',
    peakFlow: 60,
  ),
  admissionDate: '2026-11-01',
  intubationDate: '2026-11-01',
  etTubeSize: 7.5,
  etTubeDepth: 22,
);

void main() {
  late MockClinicalNetworkService networkService;

  setUp(() {
    networkService = MockClinicalNetworkService();
  });

  PatientCubit buildCubit() {
    final cubit = PatientCubit();
    unawaited(cubit.init(networkService));
    return cubit;
  }

  group('PatientCubit', () {
    test('starts in the initial state', () {
      final cubit = PatientCubit();
      expect(cubit.state.status, PatientStatus.initial);
      expect(cubit.state.patients, isEmpty);
      expect(cubit.state.selectedPatientId, isNull);
      unawaited(cubit.close());
    });

    blocTest<PatientCubit, PatientState>(
      'loads and emits patients from the live stream',
      setUp: () {
        when(() => networkService.watchPatients()).thenAnswer(
          (_) => Stream.value(
            const Right<Failure, List<Patient>>([testPatient]),
          ),
        );
      },
      build: buildCubit,
      expect: () => [
        const PatientState(status: PatientStatus.loading),
        const PatientState(
          status: PatientStatus.loaded,
          patients: [testPatient],
        ),
      ],
    );

    blocTest<PatientCubit, PatientState>(
      'updates the selected patient',
      build: PatientCubit.new,
      act: (cubit) => cubit.selectPatient('pat-1'),
      expect: () => [const PatientState(selectedPatientId: 'pat-1')],
    );

    blocTest<PatientCubit, PatientState>(
      'keeps a translated failure key when the stream fails',
      setUp: () {
        when(() => networkService.watchPatients()).thenAnswer(
          (_) => Stream.value(
            const Left<Failure, List<Patient>>(
              ServerFailure('error_network_unavailable'),
            ),
          ),
        );
      },
      build: buildCubit,
      expect: () => [
        const PatientState(status: PatientStatus.loading),
        const PatientState(
          status: PatientStatus.error,
          errorMessage: 'error_network_unavailable',
        ),
      ],
    );
  });
}
