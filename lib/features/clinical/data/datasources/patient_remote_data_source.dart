import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nemoventrt/features/clinical/data/models/patient_model.dart';
import 'package:nemoventrt/features/clinical/domain/entities/patient.dart';

abstract class PatientRemoteDataSource {
  Stream<List<Patient>> getPatientsStream();
  Future<void> savePatient(Patient patient);
  Future<void> updateVentilatorSettings(
    String patientId,
    VentilatorSettings settings,
  );
  Future<void> addABGResult(
    String patientId,
    ABGResult abg,
    List<ABGResult> currentList,
  );
  Future<void> addVitalObservation(
    String patientId,
    VitalObservation obs,
    List<VitalObservation> currentList,
  );
  Future<void> acknowledgeAlert(
    String patientId,
    String alertId,
    String staffName,
    List<CriticalAlert> currentList,
  );
  Future<void> dischargePatient(String patientId);
}

class PatientRemoteDataSourceImpl implements PatientRemoteDataSource {
  final FirebaseFirestore firestore;

  PatientRemoteDataSourceImpl({required this.firestore});

  @override
  Stream<List<Patient>> getPatientsStream() {
    return firestore.collection('patients').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => PatientModel.fromFirestore(doc))
          .toList();
    });
  }

  @override
  Future<void> savePatient(Patient patient) async {
    await firestore
        .collection('patients')
        .doc(patient.id)
        .set(PatientModel.toMap(patient), SetOptions(merge: true));
  }

  @override
  Future<void> updateVentilatorSettings(
    String patientId,
    VentilatorSettings settings,
  ) async {
    await firestore.collection('patients').doc(patientId).update({
      'ventilatorSettings': VentilatorSettingsModel.toMap(settings),
    });
  }

  @override
  Future<void> addABGResult(
    String patientId,
    ABGResult abg,
    List<ABGResult> currentList,
  ) async {
    final updated = [
      ABGResultModel.toMap(abg),
      ...currentList.map(ABGResultModel.toMap),
    ];
    await firestore.collection('patients').doc(patientId).update({
      'recentABGs': updated,
    });
  }

  @override
  Future<void> addVitalObservation(
    String patientId,
    VitalObservation obs,
    List<VitalObservation> currentList,
  ) async {
    final updated = [
      VitalObservationModel.toMap(obs),
      ...currentList.map(VitalObservationModel.toMap),
    ];
    await firestore.collection('patients').doc(patientId).update({
      'vitalsHistory': updated,
    });
  }

  @override
  Future<void> acknowledgeAlert(
    String patientId,
    String alertId,
    String staffName,
    List<CriticalAlert> currentList,
  ) async {
    final updated = currentList.map((a) {
      if (a.id == alertId) {
        return {
          ...CriticalAlertModel.toMap(a),
          'acknowledged': true,
          'acknowledgedBy': staffName,
        };
      }
      return CriticalAlertModel.toMap(a);
    }).toList();

    await firestore.collection('patients').doc(patientId).update({
      'criticalAlerts': updated,
    });
  }

  @override
  Future<void> dischargePatient(String patientId) async {
    await firestore.collection('patients').doc(patientId).delete();
  }
}
