import 'package:flutter/material.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/extensions/context_extension.dart';
import 'package:nemoventrt/features/clinical/logic/patient_cubit.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/alert_tile_widget.dart';

class AlertsDialogWidget extends StatelessWidget {
  const AlertsDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final patients = PatientCubit.get(context).state.patients;
    final alerts = [
      for (final patient in patients)
        for (final alert in patient.criticalAlerts)
          (patient: patient, alert: alert),
    ];

    return AlertDialog(
      title: Text(appTranslation().get('critical_alerts')),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: double.maxFinite),
        child: alerts.isEmpty
            ? Text(appTranslation().get('no_active_alerts'))
            : ListView.builder(
                shrinkWrap: true,
                itemCount: alerts.length,
                itemBuilder: (context, index) {
                  final item = alerts[index];
                  return AlertTileWidget(
                    patient: item.patient,
                    alert: item.alert,
                  );
                },
              ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop,
          child: Text(appTranslation().get('close')),
        ),
      ],
    );
  }
}
