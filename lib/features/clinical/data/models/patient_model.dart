import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nemoventrt/features/clinical/domain/entities/patient.dart';

class VentilatorSettingsModel extends VentilatorSettings {
  const VentilatorSettingsModel({
    required super.mode,
    required super.tidalVolume,
    required super.setRate,
    required super.totalRate,
    required super.peep,
    required super.fio2,
    required super.peakPressure,
    required super.plateauPressure,
    required super.inspTime,
    required super.ieRatio,
    required super.peakFlow,
    super.volumeGuaranteeMl,
    super.frequencyHz,
    super.amplitudeDeltaP,
    super.meanAirwayPressurePaw,
    super.biasFlowLpm,
  });

  factory VentilatorSettingsModel.fromMap(Map<String, dynamic> map) {
    return VentilatorSettingsModel(
      mode: map['mode'] as String? ?? 'VC-CMV',
      tidalVolume: (map['tidalVolume'] as num?)?.toDouble() ?? 450.0,
      setRate: (map['setRate'] as num?)?.toInt() ?? 14,
      totalRate: (map['totalRate'] as num?)?.toInt() ?? 14,
      peep: (map['peep'] as num?)?.toDouble() ?? 5.0,
      fio2: (map['fio2'] as num?)?.toDouble() ?? 40.0,
      peakPressure: (map['peakPressure'] as num?)?.toDouble() ?? 22.0,
      plateauPressure: (map['plateauPressure'] as num?)?.toDouble() ?? 18.0,
      inspTime: (map['inspTime'] as num?)?.toDouble() ?? 0.9,
      ieRatio: map['ieRatio'] as String? ?? '1:2.0',
      peakFlow: (map['peakFlow'] as num?)?.toDouble() ?? 60.0,
      volumeGuaranteeMl: (map['volumeGuaranteeMl'] as num?)?.toDouble(),
      frequencyHz: (map['frequencyHz'] as num?)?.toDouble(),
      amplitudeDeltaP: (map['amplitudeDeltaP'] as num?)?.toDouble(),
      meanAirwayPressurePaw: (map['meanAirwayPressurePaw'] as num?)?.toDouble(),
      biasFlowLpm: (map['biasFlowLpm'] as num?)?.toDouble(),
    );
  }

  static Map<String, dynamic> toMap(VentilatorSettings settings) => {
    'mode': settings.mode,
    'tidalVolume': settings.tidalVolume,
    'setRate': settings.setRate,
    'totalRate': settings.totalRate,
    'peep': settings.peep,
    'fio2': settings.fio2,
    'peakPressure': settings.peakPressure,
    'plateauPressure': settings.plateauPressure,
    'inspTime': settings.inspTime,
    'ieRatio': settings.ieRatio,
    'peakFlow': settings.peakFlow,
    'volumeGuaranteeMl': settings.volumeGuaranteeMl,
    'frequencyHz': settings.frequencyHz,
    'amplitudeDeltaP': settings.amplitudeDeltaP,
    'meanAirwayPressurePaw': settings.meanAirwayPressurePaw,
    'biasFlowLpm': settings.biasFlowLpm,
  };
}

class ABGResultModel extends ABGResult {
  const ABGResultModel({
    required super.id,
    required super.timestamp,
    required super.sampleType,
    required super.ph,
    required super.paCo2,
    required super.paO2,
    required super.hco3,
    required super.baseExcess,
    required super.fio2,
    required super.pfRatio,
    required super.interpretation,
  });

  factory ABGResultModel.fromMap(Map<String, dynamic> map) {
    return ABGResultModel(
      id: map['id'] as String? ?? '',
      timestamp: map['timestamp'] as String? ?? '',
      sampleType: map['sampleType'] as String? ?? 'Arterial',
      ph: (map['pH'] as num?)?.toDouble() ?? 7.40,
      paCo2: (map['paCO2'] as num?)?.toDouble() ?? 40.0,
      paO2: (map['paO2'] as num?)?.toDouble() ?? 95.0,
      hco3: (map['hco3'] as num?)?.toDouble() ?? 24.0,
      baseExcess: (map['baseExcess'] as num?)?.toDouble() ?? 0.0,
      fio2: (map['fio2'] as num?)?.toDouble() ?? 21.0,
      pfRatio: (map['pfRatio'] as num?)?.toDouble() ?? 450.0,
      interpretation:
          map['interpretation'] as String? ?? 'Normal arterial blood gas',
    );
  }

  static Map<String, dynamic> toMap(ABGResult result) => {
    'id': result.id,
    'timestamp': result.timestamp,
    'sampleType': result.sampleType,
    'pH': result.ph,
    'paCO2': result.paCo2,
    'paO2': result.paO2,
    'hco3': result.hco3,
    'baseExcess': result.baseExcess,
    'fio2': result.fio2,
    'pfRatio': result.pfRatio,
    'interpretation': result.interpretation,
  };
}

class CriticalAlertModel extends CriticalAlert {
  const CriticalAlertModel({
    required super.id,
    required super.parameter,
    required super.severity,
    required super.value,
    required super.message,
    required super.timestamp,
    required super.acknowledged,
    super.acknowledgedBy,
  });

  factory CriticalAlertModel.fromMap(Map<String, dynamic> map) {
    return CriticalAlertModel(
      id: map['id'] as String? ?? '',
      parameter: map['parameter'] as String? ?? '',
      severity: map['severity'] as String? ?? 'Warning',
      value: map['value'] as String? ?? '',
      message: map['message'] as String? ?? '',
      timestamp: map['timestamp'] as String? ?? '',
      acknowledged: map['acknowledged'] as bool? ?? false,
      acknowledgedBy: map['acknowledgedBy'] as String?,
    );
  }

  static Map<String, dynamic> toMap(CriticalAlert alert) => {
    'id': alert.id,
    'parameter': alert.parameter,
    'severity': alert.severity,
    'value': alert.value,
    'message': alert.message,
    'timestamp': alert.timestamp,
    'acknowledged': alert.acknowledged,
    'acknowledgedBy': alert.acknowledgedBy,
  };
}

class VitalObservationModel extends VitalObservation {
  const VitalObservationModel({
    required super.id,
    required super.timestamp,
    required super.heartRate,
    required super.spo2,
    required super.respiratoryRate,
    required super.systolicBp,
    required super.diastolicBp,
    required super.temperatureC,
    super.etCo2,
  });

  factory VitalObservationModel.fromMap(Map<String, dynamic> map) {
    return VitalObservationModel(
      id: map['id'] as String? ?? '',
      timestamp: map['timestamp'] as String? ?? '',
      heartRate: (map['heartRate'] as num?)?.toInt() ?? 75,
      spo2: (map['spo2'] as num?)?.toInt() ?? 98,
      respiratoryRate: (map['respiratoryRate'] as num?)?.toInt() ?? 16,
      systolicBp: (map['systolicBp'] as num?)?.toInt() ?? 120,
      diastolicBp: (map['diastolicBp'] as num?)?.toInt() ?? 80,
      temperatureC: (map['temperatureC'] as num?)?.toDouble() ?? 37.0,
      etCo2: (map['etCo2'] as num?)?.toInt(),
    );
  }

  static Map<String, dynamic> toMap(VitalObservation obs) => {
    'id': obs.id,
    'timestamp': obs.timestamp,
    'heartRate': obs.heartRate,
    'spo2': obs.spo2,
    'respiratoryRate': obs.respiratoryRate,
    'systolicBp': obs.systolicBp,
    'diastolicBp': obs.diastolicBp,
    'temperatureC': obs.temperatureC,
    'etCo2': obs.etCo2,
  };
}

class WeaningStatusModel extends WeaningStatus {
  const WeaningStatusModel({
    required super.stage,
    super.rsbi,
    super.sbtDurationMinutes,
    super.lastTrialOutcome,
    super.clinicalNotes,
  });

  factory WeaningStatusModel.fromMap(Map<String, dynamic> map) {
    return WeaningStatusModel(
      stage: map['stage'] as String? ?? 'not_started',
      rsbi: (map['rsbi'] as num?)?.toDouble(),
      sbtDurationMinutes: (map['sbtDurationMinutes'] as num?)?.toInt(),
      lastTrialOutcome: map['lastTrialOutcome'] as String?,
      clinicalNotes: map['clinicalNotes'] as String?,
    );
  }

  static Map<String, dynamic> toMap(WeaningStatus status) => {
    'stage': status.stage,
    'rsbi': status.rsbi,
    'sbtDurationMinutes': status.sbtDurationMinutes,
    'lastTrialOutcome': status.lastTrialOutcome,
    'clinicalNotes': status.clinicalNotes,
  };
}

class DoctorOrderModel extends DoctorOrder {
  const DoctorOrderModel({
    required super.id,
    required super.timestamp,
    required super.physicianName,
    required super.orderText,
    required super.status,
    required super.category,
  });

  factory DoctorOrderModel.fromMap(Map<String, dynamic> map) {
    return DoctorOrderModel(
      id: map['id'] as String? ?? '',
      timestamp: map['timestamp'] as String? ?? '',
      physicianName: map['physicianName'] as String? ?? 'Attending MD',
      orderText: map['orderText'] as String? ?? '',
      status: map['status'] as String? ?? 'Active',
      category: map['category'] as String? ?? 'Ventilator',
    );
  }

  static Map<String, dynamic> toMap(DoctorOrder order) => {
    'id': order.id,
    'timestamp': order.timestamp,
    'physicianName': order.physicianName,
    'orderText': order.orderText,
    'status': order.status,
    'category': order.category,
  };
}

class PatientModel extends Patient {
  const PatientModel({
    required super.id,
    required super.mrn,
    required super.bed,
    required super.unit,
    required super.firstName,
    required super.lastName,
    required super.age,
    required super.category,
    required super.sex,
    required super.heightCm,
    required super.actualWeightKg,
    required super.diagnosis,
    required super.ventilatorSettings,
    super.gestationalAgeWeeks,
    super.currentWeightGrams,
    super.broselowColor,
    required super.admissionDate,
    required super.intubationDate,
    required super.etTubeSize,
    required super.etTubeDepth,
    super.recentABGs = const [],
    super.criticalAlerts = const [],
    super.vitalsHistory = const [],
    super.weaningStatus,
    super.doctorOrders = const [],
    super.nursingNotes,
  });

  factory PatientModel.fromMap(Map<String, dynamic> map, String docId) {
    PatientCategory cat = PatientCategory.adult;
    final catRaw = (map['patientCategory'] ?? map['category'] ?? 'adult')
        .toString()
        .toLowerCase();
    if (catRaw == 'neonate') {
      cat = PatientCategory.neonate;
    } else if (catRaw == 'pediatric') {
      cat = PatientCategory.pediatric;
    }

    BiologicalSex sx = BiologicalSex.male;
    final sexRaw = (map['sex'] ?? 'male').toString().toLowerCase();
    if (sexRaw == 'female') {
      sx = BiologicalSex.female;
    }

    return PatientModel(
      id: docId.isNotEmpty
          ? docId
          : (map['id'] as String? ??
                'pat-${DateTime.now().millisecondsSinceEpoch}'),
      mrn: map['mrn'] as String? ?? 'MRN-000000',
      bed: map['bed'] as String? ?? 'Bed 1',
      unit: map['unit'] as String? ?? 'Medical ICU',
      firstName: map['firstName'] as String? ?? 'Patient',
      lastName: map['lastName'] as String? ?? 'Unknown',
      age: (map['age'] as num?)?.toInt() ?? 50,
      category: cat,
      sex: sx,
      heightCm: (map['heightCm'] as num?)?.toDouble() ?? 170.0,
      actualWeightKg: (map['actualWeightKg'] as num?)?.toDouble() ?? 70.0,
      diagnosis:
          map['diagnosis'] as String? ?? 'Acute Respiratory Distress Syndrome',
      ventilatorSettings: map['ventilatorSettings'] != null
          ? VentilatorSettingsModel.fromMap(
              Map<String, dynamic>.from(map['ventilatorSettings']),
            )
          : const VentilatorSettingsModel(
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
      gestationalAgeWeeks: (map['gestationalAgeWeeks'] as num?)?.toDouble(),
      currentWeightGrams: (map['currentWeightGrams'] as num?)?.toDouble(),
      broselowColor: map['broselowColor'] as String?,
      admissionDate:
          map['admissionDate'] as String? ??
          DateTime.now().toIso8601String().substring(0, 10),
      intubationDate:
          map['intubationDate'] as String? ??
          DateTime.now().toIso8601String().substring(0, 10),
      etTubeSize: (map['etTubeSize'] as num?)?.toDouble() ?? 7.5,
      etTubeDepth: (map['etTubeDepth'] as num?)?.toInt() ?? 22,
      recentABGs: map['recentABGs'] != null
          ? (map['recentABGs'] as List)
                .map(
                  (x) => ABGResultModel.fromMap(Map<String, dynamic>.from(x)),
                )
                .toList()
          : [],
      criticalAlerts: map['criticalAlerts'] != null
          ? (map['criticalAlerts'] as List)
                .map(
                  (x) =>
                      CriticalAlertModel.fromMap(Map<String, dynamic>.from(x)),
                )
                .toList()
          : [],
      vitalsHistory: map['vitalsHistory'] != null
          ? (map['vitalsHistory'] as List)
                .map(
                  (x) => VitalObservationModel.fromMap(
                    Map<String, dynamic>.from(x),
                  ),
                )
                .toList()
          : [],
      weaningStatus: map['weaningStatus'] != null
          ? WeaningStatusModel.fromMap(
              Map<String, dynamic>.from(map['weaningStatus']),
            )
          : null,
      doctorOrders: map['doctorOrders'] != null
          ? (map['doctorOrders'] as List)
                .map(
                  (x) => DoctorOrderModel.fromMap(Map<String, dynamic>.from(x)),
                )
                .toList()
          : [],
      nursingNotes: map['nursingNotes'] as String?,
    );
  }

  factory PatientModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return PatientModel.fromMap(data, doc.id);
  }

  static Map<String, dynamic> toMap(Patient patient) => {
    'id': patient.id,
    'mrn': patient.mrn,
    'bed': patient.bed,
    'unit': patient.unit,
    'firstName': patient.firstName,
    'lastName': patient.lastName,
    'age': patient.age,
    'patientCategory': patient.category.name,
    'sex': patient.sex.name,
    'heightCm': patient.heightCm,
    'actualWeightKg': patient.actualWeightKg,
    'diagnosis': patient.diagnosis,
    'ventilatorSettings': VentilatorSettingsModel.toMap(
      patient.ventilatorSettings,
    ),
    'gestationalAgeWeeks': patient.gestationalAgeWeeks,
    'currentWeightGrams': patient.currentWeightGrams,
    'broselowColor': patient.broselowColor,
    'admissionDate': patient.admissionDate,
    'intubationDate': patient.intubationDate,
    'etTubeSize': patient.etTubeSize,
    'etTubeDepth': patient.etTubeDepth,
    'recentABGs': patient.recentABGs.map(ABGResultModel.toMap).toList(),
    'criticalAlerts': patient.criticalAlerts
        .map(CriticalAlertModel.toMap)
        .toList(),
    'vitalsHistory': patient.vitalsHistory
        .map(VitalObservationModel.toMap)
        .toList(),
    'weaningStatus': patient.weaningStatus != null
        ? WeaningStatusModel.toMap(patient.weaningStatus!)
        : null,
    'doctorOrders': patient.doctorOrders.map(DoctorOrderModel.toMap).toList(),
    'nursingNotes': patient.nursingNotes,
  };
}
