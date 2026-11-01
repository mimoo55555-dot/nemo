import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nemoventrt/features/clinical/data/datasources/patient_remote_data_source.dart';
import 'package:nemoventrt/features/clinical/data/repositories/patient_repository_impl.dart';
import 'package:nemoventrt/features/clinical/domain/entities/patient.dart';

class MockPatientRemoteDataSource extends Mock
    implements PatientRemoteDataSource {}

void main() {
  late MockPatientRemoteDataSource remoteDataSource;
  late PatientRepositoryImpl repository;

  setUp(() {
    remoteDataSource = MockPatientRemoteDataSource();
    repository = PatientRepositoryImpl(remoteDataSource: remoteDataSource);
  });

  const testPatient = Patient(
    id: 'pat-1',
    mrn: 'MRN-001',
    bed: 'Bed 01',
    unit: 'Medical ICU',
    firstName: 'Jane',
    lastName: 'Smith',
    age: 42,
    category: PatientCategory.adult,
    sex: BiologicalSex.female,
    heightCm: 165.0,
    actualWeightKg: 60.0,
    diagnosis: 'Pneumonia',
    ventilatorSettings: VentilatorSettings(
      mode: 'VC-CMV',
      tidalVolume: 360.0,
      setRate: 16,
      totalRate: 16,
      peep: 8.0,
      fio2: 50.0,
      peakPressure: 24.0,
      plateauPressure: 20.0,
      inspTime: 0.8,
      ieRatio: '1:2.0',
      peakFlow: 55.0,
    ),
    admissionDate: '2026-11-01',
    intubationDate: '2026-11-01',
    etTubeSize: 7.0,
    etTubeDepth: 21,
  );

  test('getPatientsStream delegates to remoteDataSource', () async {
    when(() => remoteDataSource.getPatientsStream())
        .thenAnswer((_) => Stream.value([testPatient]));

    final result = repository.getPatientsStream();

    expect(await result.first, equals([testPatient]));
    verify(() => remoteDataSource.getPatientsStream()).called(1);
  });

  test('savePatient delegates to remoteDataSource', () async {
    when(() => remoteDataSource.savePatient(testPatient))
        .thenAnswer((_) async {});

    await repository.savePatient(testPatient);

    verify(() => remoteDataSource.savePatient(testPatient)).called(1);
  });

  test('dischargePatient delegates to remoteDataSource', () async {
    when(() => remoteDataSource.dischargePatient('pat-1'))
        .thenAnswer((_) async {});

    await repository.dischargePatient('pat-1');

    verify(() => remoteDataSource.dischargePatient('pat-1')).called(1);
  });
}
