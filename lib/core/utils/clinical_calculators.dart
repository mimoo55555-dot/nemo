import 'package:nemoventrt/core/models/patient.dart';

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

    String primaryDiagnosis = 'abg_normal_acid_base_balance';
    String compensation = 'abg_uncompensated';

    if (ph < 7.35) {
      if (paCo2 > 45 && hco3 >= 22 && hco3 <= 26) {
        primaryDiagnosis = 'abg_acute_respiratory_acidosis';
      } else if (paCo2 > 45 && hco3 > 26) {
        primaryDiagnosis = 'abg_partially_compensated_respiratory_acidosis';
        compensation = 'abg_partial_renal_compensation';
      } else if (hco3 < 22 && paCo2 <= 45) {
        primaryDiagnosis = 'abg_metabolic_acidosis';
      } else if (paCo2 > 45 && hco3 < 22) {
        primaryDiagnosis = 'abg_mixed_respiratory_metabolic_acidosis';
      }
    } else if (ph > 7.45) {
      if (paCo2 < 35 && hco3 >= 22 && hco3 <= 26) {
        primaryDiagnosis = 'abg_acute_respiratory_alkalosis';
      } else if (paCo2 < 35 && hco3 < 22) {
        primaryDiagnosis = 'abg_partially_compensated_respiratory_alkalosis';
        compensation = 'abg_partial_renal_compensation';
      } else if (hco3 > 26 && paCo2 >= 35) {
        primaryDiagnosis = 'abg_metabolic_alkalosis';
      } else if (paCo2 < 35 && hco3 > 26) {
        primaryDiagnosis = 'abg_mixed_respiratory_metabolic_alkalosis';
      }
    }

    String oxygenationStatus = 'abg_adequate_oxygenation';
    if (pfRatio < 100) {
      oxygenationStatus = 'abg_severe_ards';
    } else if (pfRatio < 200) {
      oxygenationStatus = 'abg_moderate_ards';
    } else if (pfRatio < 300) {
      oxygenationStatus = 'abg_mild_ards';
    } else if (paO2 < 60) {
      oxygenationStatus = 'abg_severe_hypoxemia';
    }

    return {
      'pfRatio': pfRatio,
      'primaryDiagnosis': primaryDiagnosis,
      'compensation': compensation,
      'oxygenationStatus': oxygenationStatus,
    };
  }
}
