import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/primary/conditional_builder.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';
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
      title: Text(
        appTranslation().get('critical_alerts'),
        style: TextStylesManager.title,
      ),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: double.maxFinite,
          maxHeight: MediaQuery.sizeOf(context).height * 0.58,
        ),
        child: ConditionalBuilder(
          loadingState: false,
          emptyState: alerts.isEmpty,
          emptyBuilder: (_) => Center(
            child: Text(
              appTranslation().get('no_active_alerts'),
              style: TextStylesManager.bodySmall,
              textAlign: TextAlign.center,
            ),
          ),
          successBuilder: (_) => ListView.separated(
            shrinkWrap: true,
            itemCount: alerts.length,
            separatorBuilder: (_, _) => verticalSpace8,
            itemBuilder: (_, index) => AlertTileWidget(
              patient: alerts[index].patient,
              alert: alerts[index].alert,
            ),
          ),
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
