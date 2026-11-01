import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nemoventrt/features/clinical/domain/entities/patient.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/acknowledge_alert_usecase.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/add_abg_result_usecase.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/add_vital_observation_usecase.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/discharge_patient_usecase.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/get_patients_stream_usecase.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/save_patient_usecase.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/update_ventilator_settings_usecase.dart';
import 'package:nemoventrt/features/clinical/presentation/bloc/patient_bloc.dart';
import 'package:nemoventrt/features/clinical/presentation/bloc/patient_event.dart';
import 'package:nemoventrt/features/clinical/presentation/bloc/patient_state.dart';

class MockGetPatientsStreamUseCase extends Mock
    implements GetPatientsStreamUseCase {}

class MockSavePatientUseCase extends Mock implements SavePatientUseCase {}

class MockUpdateVentilatorSettingsUseCase extends Mock
    implements UpdateVentilatorSettingsUseCase {}

class MockAddABGResultUseCase extends Mock implements AddABGResultUseCase {}

class MockAddVitalObservationUseCase extends Mock
    implements AddVitalObservationUseCase {}

class MockAcknowledgeAlertUseCase extends Mock
    implements AcknowledgeAlertUseCase {}

class MockDischargePatientUseCase extends Mock
    implements DischargePatientUseCase {}

void main() {
  late MockGetPatientsStreamUseCase mockGetPatientsStreamUseCase;
  late MockSavePatientUseCase mockSavePatientUseCase;
  late MockUpdateVentilatorSettingsUseCase mockUpdateVentilatorSettingsUseCase;
  late MockAddABGResultUseCase mockAddABGResultUseCase;
  late MockAddVitalObservationUseCase mockAddVitalObservationUseCase;
  late MockAcknowledgeAlertUseCase mockAcknowledgeAlertUseCase;
  late MockDischargePatientUseCase mockDischargePatientUseCase;

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
    heightCm: 175.0,
    actualWeightKg: 75.0,
    diagnosis: 'ARDS',
    ventilatorSettings: VentilatorSettings(
      mode: 'VC-CMV',
      tidalVolume: 450.0,
      setRate: 14,
      totalRate: 14,
      peep: 5.0,
      fio2: 40.0,
      peakPressure: 22.0,
      plateauPressure: 18.0,
      inspTime: 0.9,
      ieRatio: '1:2.0',
      peakFlow: 60.0,
    ),
    admissionDate: '2026-11-01',
    intubationDate: '2026-11-01',
    etTubeSize: 7.5,
    etTubeDepth: 22,
  );

  setUp(() {
    mockGetPatientsStreamUseCase = MockGetPatientsStreamUseCase();
    mockSavePatientUseCase = MockSavePatientUseCase();
    mockUpdateVentilatorSettingsUseCase = MockUpdateVentilatorSettingsUseCase();
    mockAddABGResultUseCase = MockAddABGResultUseCase();
    mockAddVitalObservationUseCase = MockAddVitalObservationUseCase();
    mockAcknowledgeAlertUseCase = MockAcknowledgeAlertUseCase();
    mockDischargePatientUseCase = MockDischargePatientUseCase();
  });

  PatientBloc buildBloc() {
    return PatientBloc(
      getPatientsStreamUseCase: mockGetPatientsStreamUseCase,
      savePatientUseCase: mockSavePatientUseCase,
      updateVentilatorSettingsUseCase: mockUpdateVentilatorSettingsUseCase,
      addABGResultUseCase: mockAddABGResultUseCase,
      addVitalObservationUseCase: mockAddVitalObservationUseCase,
      acknowledgeAlertUseCase: mockAcknowledgeAlertUseCase,
      dischargePatientUseCase: mockDischargePatientUseCase,
    );
  }

  group('PatientBloc', () {
    test('initial state has PatientStatus.initial', () {
      final bloc = buildBloc();
      expect(bloc.state.status, equals(PatientStatus.initial));
      expect(bloc.state.patients, isEmpty);
      expect(bloc.state.selectedPatientId, isNull);
    });

    blocTest<PatientBloc, PatientState>(
      'emits [loading, loaded] when LoadPatients is added and stream yields patients',
      build: () {
        when(() => mockGetPatientsStreamUseCase())
            .thenAnswer((_) => Stream.value([testPatient]));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const LoadPatients()),
      expect: () => [
        const PatientState(status: PatientStatus.loading),
        const PatientState(
          status: PatientStatus.loaded,
          patients: [testPatient],
        ),
      ],
    );

    blocTest<PatientBloc, PatientState>(
      'updates selectedPatientId when SelectPatient is added',
      build: buildBloc,
      act: (bloc) => bloc.add(const SelectPatient('pat-1')),
      expect: () => [
        const PatientState(selectedPatientId: 'pat-1'),
      ],
    );

    blocTest<PatientBloc, PatientState>(
      'updates categoryFilter when FilterPatientsByCategory is added',
      build: buildBloc,
      act: (bloc) => bloc.add(const FilterPatientsByCategory('pediatric')),
      expect: () => [
        const PatientState(categoryFilter: 'pediatric'),
      ],
    );

    blocTest<PatientBloc, PatientState>(
      'calls savePatientUseCase when SavePatientEvent is added',
      build: () {
        when(() => mockSavePatientUseCase(testPatient))
            .thenAnswer((_) async {});
        return buildBloc();
      },
      act: (bloc) => bloc.add(const SavePatientEvent(testPatient)),
      expect: () => [
        const PatientState(selectedPatientId: 'pat-1'),
      ],
      verify: (_) {
        verify(() => mockSavePatientUseCase(testPatient)).called(1);
      },
    );

    blocTest<PatientBloc, PatientState>(
      'calls dischargePatientUseCase when DischargePatientEvent is added',
      build: () {
        when(() => mockDischargePatientUseCase('pat-1'))
            .thenAnswer((_) async {});
        return buildBloc();
      },
      act: (bloc) => bloc.add(const DischargePatientEvent('pat-1')),
      verify: (_) {
        verify(() => mockDischargePatientUseCase('pat-1')).called(1);
      },
    );
  });
}
