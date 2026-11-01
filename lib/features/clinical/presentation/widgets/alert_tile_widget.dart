import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/extensions/context_extension.dart';
import 'package:nemoventrt/features/clinical/logic/patient_cubit.dart';
import 'package:nemoventrt/features/clinical/presentation/logic/auth_cubit.dart';

class AlertTileWidget extends StatelessWidget {
  final Patient patient;
  final CriticalAlert alert;

  const AlertTileWidget({
    super.key,
    required this.patient,
    required this.alert,
  });

  @override
  Widget build(BuildContext context) {
    final isCritical = alert.severity == 'High';
    return Card(
      color: ColorsManager.surface,
      child: ListTile(
        leading: Icon(
          isCritical ? Icons.error_outline : Icons.warning_amber_rounded,
          color: isCritical ? ColorsManager.red : ColorsManager.amber,
        ),
        title: Text(
          '${translateKnownValue(patient.bed)} · ${alert.parameter} (${alert.value})',
          style: TextStylesManager.subtitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          alert.message,
          style: TextStylesManager.bodySmall,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: alert.acknowledged
            ? Icon(Icons.check_circle_outline, color: ColorsManager.green)
            : TextButton(
                onPressed: () => _acknowledge(context),
                child: Text(appTranslation().get('acknowledge')),
              ),
      ),
    );
  }

  Future<void> _acknowledge(BuildContext context) async {
    final currentUser = AuthCubit.get(context).state;
    final saved = await PatientCubit.get(context).acknowledgeAlert(
      patient.id,
      alert.id,
      currentUser?.name ?? appTranslation().get('clinician'),
      patient.criticalAlerts,
    );
    if (!context.mounted) return;
    if (saved) {
      context.pop;
      return;
    }
    final key = PatientCubit.get(context).state.errorMessage ?? 'error_unknown';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(appTranslation().get(key))),
    );
  }
}
