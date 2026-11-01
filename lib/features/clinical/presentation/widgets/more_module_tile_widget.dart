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
  Widget build(BuildContext context) => ListTile(
    contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 6),
    leading: CircleAvatar(
      radius: 21,
      backgroundColor: iconColor.withValues(alpha: 0.12),
      child: Icon(icon, color: iconColor, size: 21),
    ),
    title: Text(
      appTranslation().get(titleKey),
      style: TextStylesManager.subtitle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
    subtitle: Text(
      appTranslation().get(subtitleKey),
      style: TextStylesManager.bodySmall,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    ),
    trailing: Icon(
      Icons.arrow_forward_rounded,
      color: ColorsManager.grey,
    ),
    onTap: onTap,
  );
}
