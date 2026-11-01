import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/theme/colors.dart';
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
  Widget build(BuildContext context) => ListTile(
    leading: Icon(
      Icons.warning,
      color: alert.severity == 'High'
          ? ColorsManager.red
          : ColorsManager.orange,
    ),
    title: Text('${patient.bed} · ${alert.parameter} (${alert.value})'),
    subtitle: Text(alert.message),
    trailing: alert.acknowledged
        ? const Icon(Icons.check, color: ColorsManager.green)
        : TextButton(
            onPressed: () => _acknowledge(context),
            child: Text(appTranslation().get('acknowledge')),
          ),
  );

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
    } else {
      final key =
          PatientCubit.get(context).state.errorMessage ?? 'error_unknown';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(appTranslation().get(key))),
      );
    }
  }
}
