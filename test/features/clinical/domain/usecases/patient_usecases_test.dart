import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nemoventrt/features/clinical/domain/entities/patient.dart';
import 'package:nemoventrt/features/clinical/domain/repositories/patient_repository.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/acknowledge_alert_usecase.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/add_abg_result_usecase.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/add_vital_observation_usecase.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/discharge_patient_usecase.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/get_patients_stream_usecase.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/save_patient_usecase.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/update_ventilator_settings_usecase.dart';

class MockPatientRepository extends Mock implements PatientRepository {}

void main() {
  late MockPatientRepository repository;

  setUp(() {
    repository = MockPatientRepository();
  });

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

  test(
    'GetPatientsStreamUseCase should forward stream from repository',
    () async {
      final useCase = GetPatientsStreamUseCase(repository);
      when(() => repository.getPatientsStream())
          .thenAnswer((_) => Stream.value([testPatient]));

      final result = useCase();

      expect(await result.first, equals([testPatient]));
      verify(() => repository.getPatientsStream()).called(1);
    },
  );

  test('SavePatientUseCase should call savePatient on repository', () async {
    final useCase = SavePatientUseCase(repository);
    when(() => repository.savePatient(testPatient)).thenAnswer((_) async {});

    await useCase(testPatient);

    verify(() => repository.savePatient(testPatient)).called(1);
  });

  test('UpdateVentilatorSettingsUseCase should call repository', () async {
    final useCase = UpdateVentilatorSettingsUseCase(repository);
    when(
      () => repository.updateVentilatorSettings(
        'pat-1',
        testPatient.ventilatorSettings,
      ),
    ).thenAnswer((_) async {});

    await useCase('pat-1', testPatient.ventilatorSettings);

    verify(
      () => repository.updateVentilatorSettings(
        'pat-1',
        testPatient.ventilatorSettings,
      ),
    ).called(1);
  });

  test('AddABGResultUseCase should call repository', () async {
    final useCase = AddABGResultUseCase(repository);
    const testAbg = ABGResult(
      id: 'abg-1',
      timestamp: '12:00',
      sampleType: 'Arterial',
      ph: 7.4,
      paCo2: 40,
      paO2: 95,
      hco3: 24,
      baseExcess: 0,
      fio2: 40,
      pfRatio: 237,
      interpretation: 'Normal',
    );

    when(() => repository.addABGResult('pat-1', testAbg, []))
        .thenAnswer((_) async {});

    await useCase('pat-1', testAbg, []);

    verify(() => repository.addABGResult('pat-1', testAbg, [])).called(1);
  });

  test('AddVitalObservationUseCase should call repository', () async {
    final useCase = AddVitalObservationUseCase(repository);
    const testObs = VitalObservation(
      id: 'obs-1',
      timestamp: '12:00',
      heartRate: 75,
      spo2: 98,
      respiratoryRate: 16,
      systolicBp: 120,
      diastolicBp: 80,
      temperatureC: 37.0,
    );

    when(() => repository.addVitalObservation('pat-1', testObs, []))
        .thenAnswer((_) async {});

    await useCase('pat-1', testObs, []);

    verify(() => repository.addVitalObservation('pat-1', testObs, []))
        .called(1);
  });

  test('AcknowledgeAlertUseCase should call repository', () async {
    final useCase = AcknowledgeAlertUseCase(repository);
    when(() => repository.acknowledgeAlert('pat-1', 'alt-1', 'Marcus', []))
        .thenAnswer((_) async {});

    await useCase('pat-1', 'alt-1', 'Marcus', []);

    verify(() => repository.acknowledgeAlert('pat-1', 'alt-1', 'Marcus', []))
        .called(1);
  });

  test('DischargePatientUseCase should call repository', () async {
    final useCase = DischargePatientUseCase(repository);
    when(() => repository.dischargePatient('pat-1')).thenAnswer((_) async {});

    await useCase('pat-1');

    verify(() => repository.dischargePatient('pat-1')).called(1);
  });
}
