import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';

class PrimaryTextFormField extends StatelessWidget {
  final String labelKey;
  final String? initialValue;
  final TextInputType keyboardType;
  final FormFieldSetter<String>? onSaved;
  final bool isRequired;

  const PrimaryTextFormField({
    super.key,
    required this.labelKey,
    this.initialValue,
    this.keyboardType = TextInputType.text,
    this.onSaved,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    initialValue: initialValue,
    keyboardType: keyboardType,
    style: TextStylesManager.body,
    decoration: InputDecoration(
      labelText: appTranslation().get(labelKey),
      labelStyle: TextStylesManager.bodySmall,
    ),
    validator: isRequired
        ? (value) => value == null || value.isEmpty
              ? appTranslation().get('required')
              : null
        : null,
    onSaved: onSaved,
  );
}
