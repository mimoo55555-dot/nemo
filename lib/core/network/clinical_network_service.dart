import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nemoventrt/core/errors/failures.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/models/patient_model.dart';
import 'package:nemoventrt/core/utils/either.dart';

class ClinicalNetworkService {
  final FirebaseFirestore _firestore;

  ClinicalNetworkService(this._firestore);

  Stream<Either<Failure, List<Patient>>> watchPatients() async* {
    try {
      await for (final snapshot
          in _firestore.collection('patients').snapshots()) {
        try {
          final patients = snapshot.docs
              .map(PatientModel.fromFirestore)
              .toList(growable: false);
          yield Right<Failure, List<Patient>>(patients);
        } catch (_) {
          yield const Left<Failure, List<Patient>>(
            ServerFailure('error_invalid_patient_data'),
          );
        }
      }
    } on FirebaseException catch (error) {
      yield Left<Failure, List<Patient>>(
        ServerFailure(_failureKey(error.code)),
      );
    } catch (_) {
      yield const Left<Failure, List<Patient>>(
        ServerFailure('error_unknown'),
      );
    }
  }

  Future<Either<Failure, bool>> savePatient(Patient patient) => _run(
    () => _firestore
        .collection('patients')
        .doc(patient.id)
        .set(PatientModel.toMap(patient), SetOptions(merge: true)),
  );

  Future<Either<Failure, bool>> updateVentilatorSettings(
    String patientId,
    VentilatorSettings settings,
  ) => _run(
    () => _firestore.collection('patients').doc(patientId).update({
      'ventilatorSettings': VentilatorSettingsModel.toMap(settings),
    }),
  );

  Future<Either<Failure, bool>> addABGResult(
    String patientId,
    ABGResult abg,
    List<ABGResult> currentList,
  ) {
    final updated = [
      ABGResultModel.toMap(abg),
      ...currentList.map(ABGResultModel.toMap),
    ];
    return _run(
      () => _firestore.collection('patients').doc(patientId).update({
        'recentABGs': updated,
      }),
    );
  }

  Future<Either<Failure, bool>> addVitalObservation(
    String patientId,
    VitalObservation observation,
    List<VitalObservation> currentList,
  ) {
    final updated = [
      VitalObservationModel.toMap(observation),
      ...currentList.map(VitalObservationModel.toMap),
    ];
    return _run(
      () => _firestore.collection('patients').doc(patientId).update({
        'vitalsHistory': updated,
      }),
    );
  }

  Future<Either<Failure, bool>> acknowledgeAlert(
    String patientId,
    String alertId,
    String staffName,
    List<CriticalAlert> currentList,
  ) {
    final updated = currentList
        .map((alert) {
          if (alert.id == alertId) {
            return {
              ...CriticalAlertModel.toMap(alert),
              'acknowledged': true,
              'acknowledgedBy': staffName,
            };
          }
          return CriticalAlertModel.toMap(alert);
        })
        .toList(growable: false);
    return _run(
      () => _firestore.collection('patients').doc(patientId).update({
        'criticalAlerts': updated,
      }),
    );
  }

  Future<Either<Failure, bool>> dischargePatient(String patientId) => _run(
    () => _firestore.collection('patients').doc(patientId).delete(),
  );

  Future<Either<Failure, bool>> _run(Future<void> Function() action) async {
    try {
      await action();
      return const Right<Failure, bool>(true);
    } on FirebaseException catch (error) {
      return Left<Failure, bool>(ServerFailure(_failureKey(error.code)));
    } catch (_) {
      return const Left<Failure, bool>(ServerFailure('error_unknown'));
    }
  }

  String _failureKey(String code) => switch (code) {
    'permission-denied' => 'error_permission_denied',
    'unavailable' || 'deadline-exceeded' => 'error_network_unavailable',
    'not-found' => 'error_patient_not_found',
    _ => 'error_unknown',
  };
}
