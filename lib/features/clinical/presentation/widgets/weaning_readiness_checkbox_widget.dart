import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';

class WeaningReadinessCheckboxWidget extends StatelessWidget {
  final String titleKey;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const WeaningReadinessCheckboxWidget({
    super.key,
    required this.titleKey,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) => CheckboxListTile(
    contentPadding: EdgeInsets.zero,
    checkboxShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),
    activeColor: ColorsManager.primaryText,
    title: Text(
      appTranslation().get(titleKey),
      style: TextStylesManager.body,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    ),
    value: value,
    onChanged: onChanged,
  );
}
