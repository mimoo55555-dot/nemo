import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';

class PatientCensusFilterChipWidget extends StatelessWidget {
  final String titleKey;
  final String value;
  final String selectedValue;
  final ValueChanged<String> onSelected;

  const PatientCensusFilterChipWidget({
    super.key,
    required this.titleKey,
    required this.value,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final selected = selectedValue == value;
    return ChoiceChip(
      label: Text(appTranslation().get(titleKey)),
      selected: selected,
      selectedColor: ColorsManager.primaryLight,
      labelStyle: TextStylesManager.caption.copyWith(
        color: selected ? ColorsManager.primary : ColorsManager.textSecondary,
        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
      ),
      onSelected: (_) => onSelected(value),
    );
  }
}
