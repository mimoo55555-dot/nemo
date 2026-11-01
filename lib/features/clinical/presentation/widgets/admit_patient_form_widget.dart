import 'package:flutter/material.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/admit_patient_form_data.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/admit_patient_identity_fields_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/admit_patient_measurements_fields_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/admit_patient_ventilator_fields_widget.dart';

class AdmitPatientFormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final AdmitPatientFormData values;
  final AdmitPatientFormCallbacks callbacks;

  const AdmitPatientFormWidget({
    super.key,
    required this.formKey,
    required this.values,
    required this.callbacks,
  });

  @override
  Widget build(BuildContext context) => ConstrainedBox(
    constraints: BoxConstraints(
      maxWidth: MediaQuery.sizeOf(context).width * .9,
    ),
    child: Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AdmitPatientIdentityFieldsWidget(
              firstName: values.firstName,
              lastName: values.lastName,
              bed: values.bed,
              mrn: values.mrn,
              diagnosis: values.diagnosis,
              category: values.category,
              sex: values.sex,
              onFirstNameSaved: callbacks.onFirstNameSaved,
              onLastNameSaved: callbacks.onLastNameSaved,
              onBedSaved: callbacks.onBedSaved,
              onMrnSaved: callbacks.onMrnSaved,
              onDiagnosisSaved: callbacks.onDiagnosisSaved,
              onCategoryChanged: callbacks.onCategoryChanged,
              onSexChanged: callbacks.onSexChanged,
            ),
            AdmitPatientMeasurementsFieldsWidget(
              heightCm: values.heightCm,
              actualWeightKg: values.actualWeightKg,
              onHeightSaved: callbacks.onHeightSaved,
              onWeightSaved: callbacks.onWeightSaved,
            ),
            AdmitPatientVentilatorFieldsWidget(
              mode: values.mode,
              tidalVolume: values.tidalVolume,
              setRate: values.setRate,
              peep: values.peep,
              fio2: values.fio2,
              onModeChanged: callbacks.onModeChanged,
              onTidalVolumeSaved: callbacks.onTidalVolumeSaved,
              onRateSaved: callbacks.onRateSaved,
              onPeepSaved: callbacks.onPeepSaved,
              onFio2Saved: callbacks.onFio2Saved,
            ),
          ],
        ),
      ),
    ),
  );
}
