import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/utils/clinical_calculators.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/features/clinical/logic/patient_cubit.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/ventilator_screen_body_widget.dart';

class VentilatorScreen extends StatefulWidget {
  final Patient patient;

  const VentilatorScreen({super.key, required this.patient});

  @override
  State<VentilatorScreen> createState() => _VentilatorScreenState();
}

class _VentilatorScreenState extends State<VentilatorScreen> {
  late VentilatorSettings _settings;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _settings = widget.patient.ventilatorSettings;
  }

  @override
  void didUpdateWidget(covariant VentilatorScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.patient.id != widget.patient.id ||
        oldWidget.patient.ventilatorSettings !=
            widget.patient.ventilatorSettings) {
      _settings = widget.patient.ventilatorSettings;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ibw = ClinicalCalculators.calculateIBW(
      heightCm: widget.patient.heightCm,
      sex: widget.patient.sex,
      category: widget.patient.category,
      actualWeightKg: widget.patient.actualWeightKg,
    );
    final mechanics = ClinicalCalculators.calculateMechanics(_settings, ibw);
    final volumes = ClinicalCalculators.calculateTargetTidalVolumes(ibw);
    return VentilatorScreenBodyWidget(
      patient: widget.patient,
      settings: _settings,
      ibw: ibw,
      mechanics: mechanics,
      targetVolume: volumes['6mL_kg']!.toInt(),
      isSaving: _isSaving,
      onModeChanged: (mode) => setState(
        () => _settings = _settings.copyWith(mode: mode),
      ),
      onSettingsChanged: (settings) => setState(() => _settings = settings),
      onSave: _saveSettings,
    );
  }

  Future<void> _saveSettings() async {
    setState(() => _isSaving = true);
    try {
      final saved = await PatientCubit.get(context).updateVentilatorSettings(
        widget.patient.id,
        _settings,
      );
      if (!mounted) return;
      final key = saved
          ? 'ventilator_settings_saved'
          : PatientCubit.get(context).state.errorMessage ?? 'error_unknown';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(appTranslation().get(key))),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }
}
