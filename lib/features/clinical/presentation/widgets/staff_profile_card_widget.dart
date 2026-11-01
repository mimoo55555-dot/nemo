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
    final roleAndCredentials = [
      if (clinician != null && clinician.role.trim().isNotEmpty)
        appTranslation().get(clinician.role),
      if (clinician != null && clinician.credentials.trim().isNotEmpty)
        clinician.credentials,
    ].join(' · ');
    final profileDetails = [
      '${appTranslation().get('badge_id')}: ${clinician?.badgeId.isNotEmpty == true ? clinician!.badgeId : appTranslation().get('not_available')}',
      if (clinician != null && clinician.department.trim().isNotEmpty)
        appTranslation().get(clinician.department),
    ].join(' · ');
    return Card(
      color: ColorsManager.surface,
      margin: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 12),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(14, 14, 14, 14),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: ColorsManager.primaryLight,
              child: Text(
                _initials(clinician?.name),
                style: TextStylesManager.subtitle.copyWith(
                  color: ColorsManager.primaryText,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            horizontalSpace12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    clinician?.name ?? appTranslation().get('clinician'),
                    style: TextStylesManager.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (roleAndCredentials.isNotEmpty) ...[
                    verticalSpace2,
                    Text(
                      roleAndCredentials,
                      style: TextStylesManager.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  Text(
                    profileDetails,
                    style: TextStylesManager.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
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
