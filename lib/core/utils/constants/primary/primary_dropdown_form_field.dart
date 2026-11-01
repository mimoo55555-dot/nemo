import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';

class PrimaryDropdownOption<ValueType> {
  final ValueType value;
  final String labelKey;

  const PrimaryDropdownOption({required this.value, required this.labelKey});
}

class PrimaryDropdownFormField<ValueType> extends StatelessWidget {
  final String labelKey;
  final ValueType value;
  final List<PrimaryDropdownOption<ValueType>> options;
  final ValueChanged<ValueType?>? onChanged;

  const PrimaryDropdownFormField({
    super.key,
    required this.labelKey,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) => DropdownButtonFormField<ValueType>(
    initialValue: value,
    style: TextStylesManager.body,
    decoration: InputDecoration(labelText: appTranslation().get(labelKey)),
    items: options
        .map(
          (option) => DropdownMenuItem<ValueType>(
            value: option.value,
            child: Text(appTranslation().get(option.labelKey)),
          ),
        )
        .toList(growable: false),
    onChanged: onChanged,
  );
}
