import 'package:nemoventrt/core/models/translations.dart';
import 'package:nemoventrt/core/utils/cubit/theme/theme_cubit.dart';

TranslationModel appTranslation() =>
    ThemeCubit.currentTranslation ?? TranslationModel.fromJson(const {});

const _fallbackTranslationKeys = <String, String>{
  'Bed 1': 'default_bed',
  'Medical ICU': 'medical_icu',
  'Patient Unknown': 'unknown_patient',
  'Acute Respiratory Distress Syndrome': 'default_ards_diagnosis',
  'Normal arterial blood gas': 'abg_normal_acid_base_balance',
  'Marcus Vance': 'demo_clinician_name',
  'RRT, RRT-ACCS, RPFT': 'clinician_credentials',
};

String translateKnownValue(String value) =>
    appTranslation().get(_fallbackTranslationKeys[value] ?? value);
