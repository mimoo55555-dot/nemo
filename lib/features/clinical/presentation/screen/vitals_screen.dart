import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';
import 'package:nemoventrt/features/clinical/logic/patient_cubit.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/vitals_action_button_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/vitals_header_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/vitals_history_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/vitals_metric_grid_widget.dart';

class VitalsScreen extends StatefulWidget {
  final Patient patient;

  const VitalsScreen({super.key, required this.patient});

  @override
  State<VitalsScreen> createState() => _VitalsScreenState();
}

class _VitalsScreenState extends State<VitalsScreen> {
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    final latest = widget.patient.vitalsHistory.isEmpty
        ? null
        : widget.patient.vitalsHistory.first;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VitalsHeaderWidget(patient: widget.patient),
            verticalSpace16,
            VitalsMetricGridWidget(
              heartRate: latest?.heartRate ?? 78,
              spo2: latest?.spo2 ?? 98,
              respiratoryRate: latest?.respiratoryRate ?? 18,
              systolicBloodPressure: latest?.systolicBp ?? 124,
              diastolicBloodPressure: latest?.diastolicBp ?? 76,
              etCo2: latest?.etCo2 ?? 36,
              temperature: latest?.temperatureC ?? 37.1,
            ),
            verticalSpace20,
            VitalsActionButtonWidget(
              isLoading: _isSaving,
              onPressed: _logObservation,
            ),
            verticalSpace20,
            Text(
              appTranslation().get('telemetry_history'),
              style: TextStylesManager.sectionTitle,
            ),
            verticalSpace8,
            VitalsHistoryWidget(observations: widget.patient.vitalsHistory),
            verticalSpace32,
          ],
        ),
      ),
    );
  }

  Future<void> _logObservation() async {
    setState(() => _isSaving = true);
    final now = DateTime.now();
    final observation = _currentObservation(now);
    try {
      final saved = await PatientCubit.get(context).addVitalObservation(
        widget.patient.id,
        observation,
        widget.patient.vitalsHistory,
      );
      if (!mounted) return;
      final message = saved
          ? appTranslation().get('vitals_saved')
          : appTranslation().get(
              PatientCubit.get(context).state.errorMessage ?? 'error_unknown',
            );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  VitalObservation _currentObservation(DateTime now) {
    final latest = widget.patient.vitalsHistory.isEmpty
        ? null
        : widget.patient.vitalsHistory.first;
    return VitalObservation(
      id: 'obs-${now.millisecondsSinceEpoch}',
      timestamp:
          '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}',
      heartRate: latest?.heartRate ?? 78,
      spo2: latest?.spo2 ?? 98,
      respiratoryRate: latest?.respiratoryRate ?? 18,
      systolicBp: latest?.systolicBp ?? 124,
      diastolicBp: latest?.diastolicBp ?? 76,
      temperatureC: latest?.temperatureC ?? 37.1,
      etCo2: latest?.etCo2 ?? 36,
    );
  }
}
