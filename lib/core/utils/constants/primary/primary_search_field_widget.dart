import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';

class PrimarySearchFieldWidget extends StatelessWidget {
  final String hintKey;
  final ValueChanged<String> onChanged;

  const PrimarySearchFieldWidget({
    super.key,
    required this.hintKey,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) => TextField(
    style: TextStylesManager.body,
    decoration: InputDecoration(
      hintText: appTranslation().get(hintKey),
      hintStyle: TextStylesManager.bodySmall,
      prefixIcon: const Icon(Icons.search, size: 20),
      contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: ColorsManager.border),
      ),
      filled: true,
      fillColor: ColorsManager.surface,
    ),
    onChanged: onChanged,
  );
}
