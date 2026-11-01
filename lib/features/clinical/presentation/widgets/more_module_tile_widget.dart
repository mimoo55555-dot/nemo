import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';

class MoreModuleTileWidget extends StatelessWidget {
  final String titleKey;
  final String subtitleKey;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const MoreModuleTileWidget({
    super.key,
    required this.titleKey,
    required this.subtitleKey,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => Card(
    color: ColorsManager.surface,
    child: ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        appTranslation().get(titleKey),
        style: TextStylesManager.subtitle,
      ),
      subtitle: Text(
        appTranslation().get(subtitleKey),
        style: TextStylesManager.bodySmall,
      ),
      trailing: Icon(Icons.chevron_right, color: ColorsManager.grey),
      onTap: onTap,
    ),
  );
}
