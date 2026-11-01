import 'package:nemoventrt/features/clinical/domain/entities/patient.dart';

class ClinicalCalculators {
  /// Calculate Ideal Body Weight (IBW) based on ARDSNet formulas
  static double calculateIBW({
    required double heightCm,
    required BiologicalSex sex,
    required PatientCategory category,
    required double actualWeightKg,
  }) {
    if (category == PatientCategory.neonate ||
        category == PatientCategory.pediatric) {
      return actualWeightKg;
    }

    final heightInches = heightCm / 2.54;
    final inchesOver5Ft = heightInches > 60 ? heightInches - 60 : 0.0;

    if (sex == BiologicalSex.male) {
      return 50.0 + (2.3 * inchesOver5Ft);
    } else {
      return 45.5 + (2.3 * inchesOver5Ft);
    }
  }

  /// Target Tidal Volumes according to ARDSNet Lung-Protective Ventilation Strategy (4, 6, 8 mL/kg IBW)
  static Map<String, double> calculateTargetTidalVolumes(double ibwKg) {
    return {
      '4mL_kg': (ibwKg * 4).roundToDouble(),
      '6mL_kg': (ibwKg * 6).roundToDouble(),
      '8mL_kg': (ibwKg * 8).roundToDouble(),
    };
  }

  /// Respiratory Mechanics & Lung Protective Thresholds
  static Map<String, dynamic> calculateMechanics(
    VentilatorSettings settings,
    double ibwKg,
  ) {
    final drivingPressure = settings.plateauPressure - settings.peep;

    // Static Compliance = Vt / (Pplat - PEEP)
    final staticCompliance = drivingPressure > 0
        ? (settings.tidalVolume / drivingPressure).roundToDouble()
        : 0.0;

    // Dynamic Compliance = Vt / (PIP - PEEP)
    final pipMinusPeep = settings.peakPressure - settings.peep;
    final dynamicCompliance = pipMinusPeep > 0
        ? (settings.tidalVolume / pipMinusPeep).roundToDouble()
        : 0.0;

    // Airway Resistance Raw = (PIP - Pplat) / (Flow in L/s)
    final flowLps = settings.peakFlow / 60.0;
    final airwayResistance = flowLps > 0
        ? ((settings.peakPressure - settings.plateauPressure) / flowLps)
              .roundToDouble()
        : 0.0;

    // mL/kg IBW
    final mlPerKg = ibwKg > 0 ? (settings.tidalVolume / ibwKg) : 0.0;

    return {
      'drivingPressure': drivingPressure,
      'staticCompliance': staticCompliance,
      'dynamicCompliance': dynamicCompliance,
      'airwayResistance': airwayResistance,
      'mlPerKg': double.parse(mlPerKg.toStringAsFixed(1)),
      'isDrivingPressureSafe': drivingPressure <= 15,
      'isPlateauSafe': settings.plateauPressure <= 30,
    };
  }

  /// Rapid Shallow Breathing Index (RSBI = f / Vt(L))
  static double calculateRSBI(int totalRate, double tidalVolumeMl) {
    final vtL = tidalVolumeMl / 1000.0;
    if (vtL <= 0) return 0.0;
    return (totalRate / vtL).roundToDouble();
  }

  /// Arterial Blood Gas (ABG) Clinical Interpretation
  static Map<String, dynamic> interpretABG({
    required double ph,
    required double paCo2,
    required double paO2,
    required double hco3,
    required double fio2,
  }) {
    // P/F Ratio
    final fio2Fraction = fio2 > 1.0 ? fio2 / 100.0 : fio2;
    final pfRatio = fio2Fraction > 0
        ? (paO2 / fio2Fraction).roundToDouble()
        : 0.0;

    String primaryDiagnosis = 'Normal Acid-Base Balance';
    String compensation = 'Uncompensated';

    if (ph < 7.35) {
      if (paCo2 > 45 && hco3 >= 22 && hco3 <= 26) {
        primaryDiagnosis = 'Acute Respiratory Acidosis';
      } else if (paCo2 > 45 && hco3 > 26) {
        primaryDiagnosis = 'Partially Compensated Respiratory Acidosis';
        compensation = 'Partial Renal Compensation';
      } else if (hco3 < 22 && paCo2 <= 45) {
        primaryDiagnosis = 'Metabolic Acidosis';
      } else if (paCo2 > 45 && hco3 < 22) {
        primaryDiagnosis = 'Mixed Respiratory & Metabolic Acidosis';
      }
    } else if (ph > 7.45) {
      if (paCo2 < 35 && hco3 >= 22 && hco3 <= 26) {
        primaryDiagnosis = 'Acute Respiratory Alkalosis';
      } else if (paCo2 < 35 && hco3 < 22) {
        primaryDiagnosis = 'Partially Compensated Respiratory Alkalosis';
        compensation = 'Partial Renal Compensation';
      } else if (hco3 > 26 && paCo2 >= 35) {
        primaryDiagnosis = 'Metabolic Alkalosis';
      } else if (paCo2 < 35 && hco3 > 26) {
        primaryDiagnosis = 'Mixed Respiratory & Metabolic Alkalosis';
      }
    }

    String oxygenationStatus = 'Adequate Oxygenation';
    if (pfRatio < 100) {
      oxygenationStatus = 'Severe ARDS (P/F < 100)';
    } else if (pfRatio < 200) {
      oxygenationStatus = 'Moderate ARDS (P/F 100-200)';
    } else if (pfRatio < 300) {
      oxygenationStatus = 'Mild ARDS (P/F 200-300)';
    } else if (paO2 < 60) {
      oxygenationStatus = 'Severe Hypoxemia';
    }

    return {
      'pfRatio': pfRatio,
      'primaryDiagnosis': primaryDiagnosis,
      'compensation': compensation,
      'oxygenationStatus': oxygenationStatus,
    };
  }
}
