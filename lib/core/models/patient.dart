enum PatientCategory { adult, pediatric, neonate }

enum BiologicalSex { male, female }

class VentilatorSettings {
  final String mode;
  final double tidalVolume;
  final int setRate;
  final int totalRate;
  final double peep;
  final double fio2;
  final double peakPressure;
  final double plateauPressure;
  final double inspTime;
  final String ieRatio;
  final double peakFlow;

  // Neonatal / Pediatric Specific Fields
  final double? volumeGuaranteeMl;
  final double? frequencyHz;
  final double? amplitudeDeltaP;
  final double? meanAirwayPressurePaw;
  final double? biasFlowLpm;

  const VentilatorSettings({
    required this.mode,
    required this.tidalVolume,
    required this.setRate,
    required this.totalRate,
    required this.peep,
    required this.fio2,
    required this.peakPressure,
    required this.plateauPressure,
    required this.inspTime,
    required this.ieRatio,
    required this.peakFlow,
    this.volumeGuaranteeMl,
    this.frequencyHz,
    this.amplitudeDeltaP,
    this.meanAirwayPressurePaw,
    this.biasFlowLpm,
  });

  VentilatorSettings copyWith({
    String? mode,
    double? tidalVolume,
    int? setRate,
    int? totalRate,
    double? peep,
    double? fio2,
    double? peakPressure,
    double? plateauPressure,
    double? inspTime,
    String? ieRatio,
    double? peakFlow,
    double? volumeGuaranteeMl,
    double? frequencyHz,
    double? amplitudeDeltaP,
    double? meanAirwayPressurePaw,
    double? biasFlowLpm,
  }) {
    return VentilatorSettings(
      mode: mode ?? this.mode,
      tidalVolume: tidalVolume ?? this.tidalVolume,
      setRate: setRate ?? this.setRate,
      totalRate: totalRate ?? this.totalRate,
      peep: peep ?? this.peep,
      fio2: fio2 ?? this.fio2,
      peakPressure: peakPressure ?? this.peakPressure,
      plateauPressure: plateauPressure ?? this.plateauPressure,
      inspTime: inspTime ?? this.inspTime,
      ieRatio: ieRatio ?? this.ieRatio,
      peakFlow: peakFlow ?? this.peakFlow,
      volumeGuaranteeMl: volumeGuaranteeMl ?? this.volumeGuaranteeMl,
      frequencyHz: frequencyHz ?? this.frequencyHz,
      amplitudeDeltaP: amplitudeDeltaP ?? this.amplitudeDeltaP,
      meanAirwayPressurePaw:
          meanAirwayPressurePaw ?? this.meanAirwayPressurePaw,
      biasFlowLpm: biasFlowLpm ?? this.biasFlowLpm,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VentilatorSettings &&
          runtimeType == other.runtimeType &&
          mode == other.mode &&
          tidalVolume == other.tidalVolume &&
          setRate == other.setRate &&
          totalRate == other.totalRate &&
          peep == other.peep &&
          fio2 == other.fio2 &&
          peakPressure == other.peakPressure &&
          plateauPressure == other.plateauPressure &&
          inspTime == other.inspTime &&
          ieRatio == other.ieRatio &&
          peakFlow == other.peakFlow &&
          volumeGuaranteeMl == other.volumeGuaranteeMl &&
          frequencyHz == other.frequencyHz &&
          amplitudeDeltaP == other.amplitudeDeltaP &&
          meanAirwayPressurePaw == other.meanAirwayPressurePaw &&
          biasFlowLpm == other.biasFlowLpm;

  @override
  int get hashCode => Object.hash(
    mode,
    tidalVolume,
    setRate,
    totalRate,
    peep,
    fio2,
    peakPressure,
    plateauPressure,
    inspTime,
    ieRatio,
    peakFlow,
    volumeGuaranteeMl,
    frequencyHz,
    amplitudeDeltaP,
    meanAirwayPressurePaw,
    biasFlowLpm,
  );
}

class ABGResult {
  final String id;
  final String timestamp;
  final String sampleType;
  final double ph;
  final double paCo2;
  final double paO2;
  final double hco3;
  final double baseExcess;
  final double fio2;
  final double pfRatio;
  final String interpretation;

  const ABGResult({
    required this.id,
    required this.timestamp,
    required this.sampleType,
    required this.ph,
    required this.paCo2,
    required this.paO2,
    required this.hco3,
    required this.baseExcess,
    required this.fio2,
    required this.pfRatio,
    required this.interpretation,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ABGResult && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class CriticalAlert {
  final String id;
  final String parameter;
  final String severity; // 'High' | 'Warning'
  final String value;
  final String message;
  final String timestamp;
  final bool acknowledged;
  final String? acknowledgedBy;

  const CriticalAlert({
    required this.id,
    required this.parameter,
    required this.severity,
    required this.value,
    required this.message,
    required this.timestamp,
    required this.acknowledged,
    this.acknowledgedBy,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CriticalAlert &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class VitalObservation {
  final String id;
  final String timestamp;
  final int heartRate;
  final int spo2;
  final int respiratoryRate;
  final int systolicBp;
  final int diastolicBp;
  final double temperatureC;
  final int? etCo2;

  const VitalObservation({
    required this.id,
    required this.timestamp,
    required this.heartRate,
    required this.spo2,
    required this.respiratoryRate,
    required this.systolicBp,
    required this.diastolicBp,
    required this.temperatureC,
    this.etCo2,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VitalObservation &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class WeaningStatus {
  final String stage;
  final double? rsbi;
  final int? sbtDurationMinutes;
  final String? lastTrialOutcome;
  final String? clinicalNotes;

  const WeaningStatus({
    required this.stage,
    this.rsbi,
    this.sbtDurationMinutes,
    this.lastTrialOutcome,
    this.clinicalNotes,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeaningStatus &&
          runtimeType == other.runtimeType &&
          stage == other.stage &&
          rsbi == other.rsbi &&
          sbtDurationMinutes == other.sbtDurationMinutes &&
          lastTrialOutcome == other.lastTrialOutcome &&
          clinicalNotes == other.clinicalNotes;

  @override
  int get hashCode => Object.hash(
    stage,
    rsbi,
    sbtDurationMinutes,
    lastTrialOutcome,
    clinicalNotes,
  );
}

class DoctorOrder {
  final String id;
  final String timestamp;
  final String physicianName;
  final String orderText;
  final String status;
  final String category;

  const DoctorOrder({
    required this.id,
    required this.timestamp,
    required this.physicianName,
    required this.orderText,
    required this.status,
    required this.category,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoctorOrder &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class Patient {
  final String id;
  final String mrn;
  final String bed;
  final String unit;
  final String firstName;
  final String lastName;
  final int age;
  final PatientCategory category;
  final BiologicalSex sex;
  final double heightCm;
  final double actualWeightKg;
  final String diagnosis;
  final VentilatorSettings ventilatorSettings;

  // Population metrics
  final double? gestationalAgeWeeks;
  final double? currentWeightGrams;
  final String? broselowColor;

  // Clinical records
  final String admissionDate;
  final String intubationDate;
  final double etTubeSize;
  final int etTubeDepth;
  final List<ABGResult> recentABGs;
  final List<CriticalAlert> criticalAlerts;
  final List<VitalObservation> vitalsHistory;
  final WeaningStatus? weaningStatus;
  final List<DoctorOrder> doctorOrders;
  final String? nursingNotes;

  const Patient({
    required this.id,
    required this.mrn,
    required this.bed,
    required this.unit,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.category,
    required this.sex,
    required this.heightCm,
    required this.actualWeightKg,
    required this.diagnosis,
    required this.ventilatorSettings,
    this.gestationalAgeWeeks,
    this.currentWeightGrams,
    this.broselowColor,
    required this.admissionDate,
    required this.intubationDate,
    required this.etTubeSize,
    required this.etTubeDepth,
    this.recentABGs = const [],
    this.criticalAlerts = const [],
    this.vitalsHistory = const [],
    this.weaningStatus,
    this.doctorOrders = const [],
    this.nursingNotes,
  });

  String get fullName => '$firstName $lastName';

  Patient copyWith({
    String? id,
    String? mrn,
    String? bed,
    String? unit,
    String? firstName,
    String? lastName,
    int? age,
    PatientCategory? category,
    BiologicalSex? sex,
    double? heightCm,
    double? actualWeightKg,
    String? diagnosis,
    VentilatorSettings? ventilatorSettings,
    double? gestationalAgeWeeks,
    double? currentWeightGrams,
    String? broselowColor,
    String? admissionDate,
    String? intubationDate,
    double? etTubeSize,
    int? etTubeDepth,
    List<ABGResult>? recentABGs,
    List<CriticalAlert>? criticalAlerts,
    List<VitalObservation>? vitalsHistory,
    WeaningStatus? weaningStatus,
    List<DoctorOrder>? doctorOrders,
    String? nursingNotes,
  }) {
    return Patient(
      id: id ?? this.id,
      mrn: mrn ?? this.mrn,
      bed: bed ?? this.bed,
      unit: unit ?? this.unit,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      category: category ?? this.category,
      sex: sex ?? this.sex,
      heightCm: heightCm ?? this.heightCm,
      actualWeightKg: actualWeightKg ?? this.actualWeightKg,
      diagnosis: diagnosis ?? this.diagnosis,
      ventilatorSettings: ventilatorSettings ?? this.ventilatorSettings,
      gestationalAgeWeeks: gestationalAgeWeeks ?? this.gestationalAgeWeeks,
      currentWeightGrams: currentWeightGrams ?? this.currentWeightGrams,
      broselowColor: broselowColor ?? this.broselowColor,
      admissionDate: admissionDate ?? this.admissionDate,
      intubationDate: intubationDate ?? this.intubationDate,
      etTubeSize: etTubeSize ?? this.etTubeSize,
      etTubeDepth: etTubeDepth ?? this.etTubeDepth,
      recentABGs: recentABGs ?? this.recentABGs,
      criticalAlerts: criticalAlerts ?? this.criticalAlerts,
      vitalsHistory: vitalsHistory ?? this.vitalsHistory,
      weaningStatus: weaningStatus ?? this.weaningStatus,
      doctorOrders: doctorOrders ?? this.doctorOrders,
      nursingNotes: nursingNotes ?? this.nursingNotes,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Patient && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Patient(id: $id, bed: $bed, name: $fullName)';
}
