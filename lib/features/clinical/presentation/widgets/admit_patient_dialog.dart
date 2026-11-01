import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/extensions/context_extension.dart';
import 'package:nemoventrt/features/clinical/logic/patient_cubit.dart';
import 'package:nemoventrt/features/clinical/presentation/logic/admit_patient_form_controller.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/admit_patient_dialog_actions_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/admit_patient_form_widget.dart';

class AdmitPatientDialog extends StatefulWidget {
  const AdmitPatientDialog({super.key});

  @override
  State<AdmitPatientDialog> createState() => _AdmitPatientDialogState();
}

class _AdmitPatientDialogState extends State<AdmitPatientDialog> {
  static const _age = 58;
  final _formKey = GlobalKey<FormState>();
  late final _formController = AdmitPatientFormController(onChanged: _refresh);
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(
      appTranslation().get('admit_new_icu_patient'),
      style: TextStylesManager.title,
    ),
    content: AdmitPatientFormWidget(
      formKey: _formKey,
      values: _formController.values,
      callbacks: _formController.callbacks,
    ),
    actions: [
      AdmitPatientDialogActionsWidget(
        isSaving: _isSaving,
        onCancel: () => context.pop,
        onSubmit: _savePatient,
      ),
    ],
  );

  Future<void> _savePatient() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() => _isSaving = true);
    try {
      final values = _formController.values;
      final saved = await PatientCubit.get(context).admitPatient(
        mrn: values.mrn,
        bed: values.bed,
        unit: appTranslation().get('medical_icu'),
        firstName: values.firstName,
        lastName: values.lastName,
        age: _age,
        category: values.category,
        sex: values.sex,
        heightCm: values.heightCm,
        actualWeightKg: values.actualWeightKg,
        diagnosis: values.diagnosis,
        mode: values.mode,
        tidalVolume: values.tidalVolume,
        setRate: values.setRate,
        peep: values.peep,
        fio2: values.fio2,
      );
      if (mounted) _showResult(saved);
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _showResult(bool saved) {
    if (saved) context.pop;
    final key = saved
        ? 'patient_admitted'
        : PatientCubit.get(context).state.errorMessage ?? 'error_unknown';
    final message = appTranslation()
        .get(key)
        .replaceFirst('{name}', _formController.lastName)
        .replaceFirst('{bed}', _formController.bed);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: ColorsManager.textPrimary,
        content: Text(
          message,
          style: TextStylesManager.body.copyWith(color: ColorsManager.white),
        ),
      ),
    );
  }

  void _refresh() => setState(() {});
}
