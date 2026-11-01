import 'package:flutter_test/flutter_test.dart';
import 'package:nemoventrt/core/utils/clinical_calculators.dart';
import 'package:nemoventrt/features/clinical/domain/entities/patient.dart';

void main() {
  group('ClinicalCalculators', () {
    test('calculateIBW for Adult Male (> 5ft)', () {
      // 175 cm is ~68.89 inches (8.89 inches over 60)
      final ibw = ClinicalCalculators.calculateIBW(
        heightCm: 175.0,
        sex: BiologicalSex.male,
        category: PatientCategory.adult,
        actualWeightKg: 80.0,
      );
      expect(ibw, closeTo(70.46, 0.1));
    });

    test('calculateIBW for Adult Female (> 5ft)', () {
      final ibw = ClinicalCalculators.calculateIBW(
        heightCm: 165.0,
        sex: BiologicalSex.female,
        category: PatientCategory.adult,
        actualWeightKg: 65.0,
      );
      expect(ibw, closeTo(56.9, 0.1));
    });

    test('calculateIBW returns actual weight for pediatric and neonate', () {
      final pedIbw = ClinicalCalculators.calculateIBW(
        heightCm: 110.0,
        sex: BiologicalSex.female,
        category: PatientCategory.pediatric,
        actualWeightKg: 18.0,
      );
      expect(pedIbw, equals(18.0));

      final neoIbw = ClinicalCalculators.calculateIBW(
        heightCm: 45.0,
        sex: BiologicalSex.male,
        category: PatientCategory.neonate,
        actualWeightKg: 2.8,
      );
      expect(neoIbw, equals(2.8));
    });

    test('calculateTargetTidalVolumes returns 4, 6, 8 mL/kg correctly', () {
      final vols = ClinicalCalculators.calculateTargetTidalVolumes(70.0);
      expect(vols['4mL_kg'], equals(280.0));
      expect(vols['6mL_kg'], equals(420.0));
      expect(vols['8mL_kg'], equals(560.0));
    });

    test(
      'calculateMechanics calculates driving pressure, compliance & resistance',
      () {
        const settings = VentilatorSettings(
          mode: 'VC-CMV',
          tidalVolume: 450.0,
          setRate: 14,
          totalRate: 14,
          peep: 5.0,
          fio2: 40.0,
          peakPressure: 25.0,
          plateauPressure: 19.0,
          inspTime: 0.9,
          ieRatio: '1:2.0',
          peakFlow: 60.0, // 60 L/min = 1 L/s
        );

        final mechanics = ClinicalCalculators.calculateMechanics(
          settings,
          70.0,
        );

        // Driving pressure = 19 - 5 = 14
        expect(mechanics['drivingPressure'], equals(14.0));
        expect(mechanics['isDrivingPressureSafe'], isTrue);

        // Static Compliance = 450 / 14 = 32.14 -> 32
        expect(mechanics['staticCompliance'], equals(32.0));

        // Dynamic Compliance = 450 / (25 - 5) = 450 / 20 = 22.5 -> 23 or 22.5
        expect(mechanics['dynamicCompliance'], closeTo(22.5, 0.5));

        // Airway resistance Raw = (25 - 19) / 1.0 = 6.0
        expect(mechanics['airwayResistance'], equals(6.0));

        // mL / kg = 450 / 70 = 6.4
        expect(mechanics['mlPerKg'], equals(6.4));
      },
    );

    test('calculateRSBI returns f / Vt(L)', () {
      // 20 breaths/min / 0.400 L = 50
      final rsbi = ClinicalCalculators.calculateRSBI(20, 400.0);
      expect(rsbi, equals(50.0));
    });

    test(
      'interpretABG detects Acute Respiratory Acidosis and ARDS severity',
      () {
        final result = ClinicalCalculators.interpretABG(
          ph: 7.28,
          paCo2: 55.0,
          paO2: 70.0,
          hco3: 24.0,
          fio2: 50.0,
        );

        expect(
          result['primaryDiagnosis'],
          equals('Acute Respiratory Acidosis'),
        );
        // PaO2 / 0.50 = 140 -> Moderate ARDS (100-200)
        expect(result['pfRatio'], equals(140.0));
        expect(result['oxygenationStatus'], contains('Moderate ARDS'));
      },
    );
  });
}
