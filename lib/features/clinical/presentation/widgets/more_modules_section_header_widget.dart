import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';

class MoreModulesSectionHeaderWidget extends StatelessWidget {
  final String titleKey;

  const MoreModulesSectionHeaderWidget({
    super.key,
    required this.titleKey,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(4, 8, 4, 4),
    child: Text(
      appTranslation().get(titleKey),
      style: TextStylesManager.bodySmall.copyWith(
        color: ColorsManager.grey,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
