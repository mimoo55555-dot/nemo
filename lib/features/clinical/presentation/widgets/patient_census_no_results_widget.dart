import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';

class PatientCensusNoResultsWidget extends StatelessWidget {
  const PatientCensusNoResultsWidget({super.key});

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.airline_seat_flat,
            size: 48,
            color: ColorsManager.lightGrey,
          ),
          verticalSpace8,
          Text(
            appTranslation().get('no_matching_patients'),
            style: TextStylesManager.subtitle,
          ),
          verticalSpace4,
          Text(
            appTranslation().get('admit_or_clear_filters'),
            style: TextStylesManager.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
