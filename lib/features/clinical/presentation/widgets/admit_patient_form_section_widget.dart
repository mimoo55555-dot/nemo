import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';

class AdmitPatientFormSectionWidget extends StatelessWidget {
  final String titleKey;
  final IconData icon;
  final Widget child;

  const AdmitPatientFormSectionWidget({
    super.key,
    required this.titleKey,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: ColorsManager.primaryLight,
            child: Icon(icon, size: 18, color: ColorsManager.primaryText),
          ),
          horizontalSpace8,
          Expanded(
            child: Text(
              appTranslation().get(titleKey),
              style: TextStylesManager.sectionTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      verticalSpace8,
      Card(
        color: ColorsManager.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.all(16),
          child: child,
        ),
      ),
      verticalSpace16,
    ],
  );
}
