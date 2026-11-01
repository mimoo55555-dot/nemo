import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/staff_user.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';

class StaffProfileCardWidget extends StatelessWidget {
  final StaffUser? user;

  const StaffProfileCardWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final clinician = user;
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 12),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: ColorsManager.primary,
            child: Text(_initials(clinician?.name)),
          ),
          horizontalSpace12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clinician?.name ?? appTranslation().get('clinician'),
                  style: TextStylesManager.subtitle,
                ),
                Text(
                  '${appTranslation().get(clinician?.role ?? '')} · ${clinician?.credentials ?? ''}',
                  style: TextStylesManager.bodySmall,
                ),
                Text(
                  '${appTranslation().get('badge_id')}: ${clinician?.badgeId ?? appTranslation().get('not_available')} · ${appTranslation().get(clinician?.department ?? '')}',
                  style: TextStylesManager.caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _initials(String? name) {
    if (name == null || name.trim().isEmpty) {
      return appTranslation().get('clinician_abbreviation');
    }
    return name
        .trim()
        .split(RegExp(r'\s+'))
        .map((part) => part[0])
        .take(2)
        .join();
  }
}
