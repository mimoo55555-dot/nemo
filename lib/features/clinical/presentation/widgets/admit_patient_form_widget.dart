import 'package:flutter/material.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/admit_patient_form_data.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/admit_patient_identity_fields_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/admit_patient_measurements_fields_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/admit_patient_ventilator_fields_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/admit_patient_form_section_widget.dart';

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
            AdmitPatientFormSectionWidget(
              titleKey: 'patient_identity',
              icon: Icons.badge_outlined,
              child: AdmitPatientIdentityFieldsWidget(
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
            ),
            AdmitPatientFormSectionWidget(
              titleKey: 'patient_measurements',
              icon: Icons.straighten_rounded,
              child: AdmitPatientMeasurementsFieldsWidget(
                age: values.age,
                heightCm: values.heightCm,
                actualWeightKg: values.actualWeightKg,
                onAgeSaved: callbacks.onAgeSaved,
                onHeightSaved: callbacks.onHeightSaved,
                onWeightSaved: callbacks.onWeightSaved,
              ),
            ),
            AdmitPatientFormSectionWidget(
              titleKey: 'initial_ventilator_settings',
              icon: Icons.air_rounded,
              child: AdmitPatientVentilatorFieldsWidget(
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
            ),
          ],
        ),
      ),
    ),
  );
}
