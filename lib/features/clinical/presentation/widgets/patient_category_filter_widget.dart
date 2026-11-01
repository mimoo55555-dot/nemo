import 'package:flutter/material.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/patient_census_filter_chip_widget.dart';

class PatientCategoryFilterWidget extends StatelessWidget {
  final String selectedValue;
  final ValueChanged<String> onChanged;

  const PatientCategoryFilterWidget({
    super.key,
    required this.selectedValue,
    required this.onChanged,
  });

  static const _filters = [
    ('all_units', 'all'),
    ('adult_icu', 'adult'),
    ('picu', 'pediatric'),
    ('nicu', 'neonate'),
  ];

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 8),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final filter in _filters) ...[
            PatientCensusFilterChipWidget(
              titleKey: filter.$1,
              value: filter.$2,
              selectedValue: selectedValue,
              onSelected: onChanged,
            ),
            horizontalSpace8,
          ],
        ],
      ),
    ),
  );
}
