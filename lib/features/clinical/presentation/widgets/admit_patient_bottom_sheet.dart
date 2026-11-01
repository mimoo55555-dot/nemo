import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/primary/primary_sheet_handle_widget.dart';
import 'package:nemoventrt/core/utils/extensions/context_extension.dart';
import 'package:nemoventrt/features/clinical/logic/patient_cubit.dart';
import 'package:nemoventrt/features/clinical/presentation/logic/admit_patient_form_controller.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/admit_patient_form_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/admit_patient_sheet_actions_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/admit_patient_sheet_header_widget.dart';

class AdmitPatientBottomSheet extends StatefulWidget {
  const AdmitPatientBottomSheet({super.key});

  @override
  State<AdmitPatientBottomSheet> createState() =>
      _AdmitPatientBottomSheetState();
}

class _AdmitPatientBottomSheetState extends State<AdmitPatientBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late final _formController = AdmitPatientFormController(onChanged: _refresh);
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) => AnimatedPadding(
    duration: const Duration(milliseconds: 220),
    curve: Curves.easeOut,
    padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
    child: Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.94,
      ),
      decoration: BoxDecoration(
        color: ColorsManager.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            const PrimarySheetHandleWidget(),
            AdmitPatientSheetHeaderWidget(onClose: () => context.pop),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                child: AdmitPatientFormWidget(
                  formKey: _formKey,
                  values: _formController.values,
                  callbacks: _formController.callbacks,
                ),
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
              child: AdmitPatientSheetActionsWidget(
                isSaving: _isSaving,
                onCancel: () => context.pop,
                onSubmit: _savePatient,
              ),
            ),
          ],
        ),
      ),
    ),
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
        age: values.age,
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
      SnackBar(content: Text(message)),
    );
  }

  void _refresh() => setState(() {});
}
