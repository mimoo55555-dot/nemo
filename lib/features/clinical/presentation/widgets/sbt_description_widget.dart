import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';

class SbtDescriptionWidget extends StatelessWidget {
  final bool isActive;
  final int secondsRemaining;

  const SbtDescriptionWidget({
    super.key,
    required this.isActive,
    required this.secondsRemaining,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        appTranslation().get(
          isActive ? 'sbt_trial_in_progress' : 'spontaneous_breathing_trial',
        ),
        style: TextStylesManager.subtitle,
      ),
      Text(_subtitle, style: TextStylesManager.caption),
    ],
  );

  String get _subtitle => isActive
      ? '${(secondsRemaining ~/ 60).toString().padLeft(2, '0')}:${(secondsRemaining % 60).toString().padLeft(2, '0')} ${appTranslation().get('remaining')}'
      : appTranslation().get('sbt_duration_description');
}
