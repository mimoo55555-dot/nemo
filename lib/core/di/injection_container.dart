import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:nemoventrt/features/clinical/data/datasources/patient_remote_data_source.dart';
import 'package:nemoventrt/features/clinical/data/repositories/patient_repository_impl.dart';
import 'package:nemoventrt/features/clinical/domain/repositories/patient_repository.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/acknowledge_alert_usecase.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/add_abg_result_usecase.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/add_vital_observation_usecase.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/discharge_patient_usecase.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/get_patients_stream_usecase.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/save_patient_usecase.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/update_ventilator_settings_usecase.dart';
import 'package:nemoventrt/features/clinical/presentation/bloc/auth_cubit.dart';
import 'package:nemoventrt/features/clinical/presentation/bloc/patient_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // -------------------------------------------------------------
  // External
  // -------------------------------------------------------------
  if (!sl.isRegistered<FirebaseFirestore>()) {
    sl.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    );
  }

  // -------------------------------------------------------------
  // Data sources
  // -------------------------------------------------------------
  sl.registerLazySingleton<PatientRemoteDataSource>(
    () => PatientRemoteDataSourceImpl(firestore: sl()),
  );

  // -------------------------------------------------------------
  // Repositories
  // -------------------------------------------------------------
  sl.registerLazySingleton<PatientRepository>(
    () => PatientRepositoryImpl(remoteDataSource: sl()),
  );

  // -------------------------------------------------------------
  // Use Cases
  // -------------------------------------------------------------
  sl.registerLazySingleton(() => GetPatientsStreamUseCase(sl()));
  sl.registerLazySingleton(() => SavePatientUseCase(sl()));
  sl.registerLazySingleton(() => UpdateVentilatorSettingsUseCase(sl()));
  sl.registerLazySingleton(() => AddABGResultUseCase(sl()));
  sl.registerLazySingleton(() => AddVitalObservationUseCase(sl()));
  sl.registerLazySingleton(() => AcknowledgeAlertUseCase(sl()));
  sl.registerLazySingleton(() => DischargePatientUseCase(sl()));

  // -------------------------------------------------------------
  // Blocs & Cubits
  // -------------------------------------------------------------
  sl.registerFactory(
    () => PatientBloc(
      getPatientsStreamUseCase: sl(),
      savePatientUseCase: sl(),
      updateVentilatorSettingsUseCase: sl(),
      addABGResultUseCase: sl(),
      addVitalObservationUseCase: sl(),
      acknowledgeAlertUseCase: sl(),
      dischargePatientUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(() => AuthCubit());
}
