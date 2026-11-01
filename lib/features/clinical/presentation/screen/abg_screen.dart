import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/utils/clinical_calculators.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/features/clinical/logic/patient_cubit.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/abg_screen_body_widget.dart';

class ABGScreen extends StatefulWidget {
  final Patient patient;

  const ABGScreen({super.key, required this.patient});

  @override
  State<ABGScreen> createState() => _ABGScreenState();
}

class _ABGScreenState extends State<ABGScreen> {
  double _ph = 7.34;
  double _paCo2 = 48;
  double _paO2 = 68;
  double _hco3 = 25;
  double _baseExcess = -1.2;
  double _fio2 = 65;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    if (widget.patient.recentABGs.isEmpty) {
      _fio2 = widget.patient.ventilatorSettings.fio2;
      return;
    }
    final latest = widget.patient.recentABGs.first;
    _ph = latest.ph;
    _paCo2 = latest.paCo2;
    _paO2 = latest.paO2;
    _hco3 = latest.hco3;
    _baseExcess = latest.baseExcess;
    _fio2 = latest.fio2;
  }

  @override
  Widget build(BuildContext context) {
    final result = ClinicalCalculators.interpretABG(
      ph: _ph,
      paCo2: _paCo2,
      paO2: _paO2,
      hco3: _hco3,
      fio2: _fio2,
    );
    return AbgScreenBodyWidget(
      patient: widget.patient,
      ph: _ph,
      paCo2: _paCo2,
      paO2: _paO2,
      hco3: _hco3,
      baseExcess: _baseExcess,
      fio2: _fio2,
      ratio: (result['pfRatio'] as double).toInt(),
      diagnosis: appTranslation().get(result['primaryDiagnosis'] as String),
      summary:
          '${appTranslation().get(result['compensation'] as String)} · ${appTranslation().get(result['oxygenationStatus'] as String)}',
      isSaving: _isSaving,
      onPhChanged: (value) => setState(() => _ph = value),
      onPaCo2Changed: (value) => setState(() => _paCo2 = value),
      onPaO2Changed: (value) => setState(() => _paO2 = value),
      onHco3Changed: (value) => setState(() => _hco3 = value),
      onSave: _saveABG,
    );
  }

  Future<void> _saveABG() async {
    setState(() => _isSaving = true);
    try {
      final saved = await PatientCubit.get(context).addABGValues(
        patient: widget.patient,
        ph: _ph,
        paCo2: _paCo2,
        paO2: _paO2,
        hco3: _hco3,
        baseExcess: _baseExcess,
        fio2: _fio2,
      );
      if (!mounted) return;
      final key = saved
          ? 'abg_saved'
          : PatientCubit.get(context).state.errorMessage ?? 'error_unknown';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(appTranslation().get(key)),
        ),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }
}
