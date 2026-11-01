import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/primary/conditional_builder.dart';
import 'package:nemoventrt/core/utils/constants/primary/primary_icon_button_widget.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';

class MainShellAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final Patient? patient;
  final int alertCount;
  final VoidCallback onOpenCensus;
  final VoidCallback onOpenAlerts;
  final VoidCallback onOpenMore;

  const MainShellAppBarWidget({
    super.key,
    required this.patient,
    required this.alertCount,
    required this.onOpenCensus,
    required this.onOpenAlerts,
    required this.onOpenMore,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final activePatient = patient;
    return AppBar(
      titleSpacing: 12,
      title: Row(
        children: [
          const Icon(Icons.air, color: ColorsManager.primary),
          horizontalSpace8,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  activePatient?.fullName ?? appTranslation().get('app_title'),
                  style: TextStylesManager.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                ConditionalBuilder(
                  loadingState: false,
                  emptyState: activePatient == null,
                  emptyBuilder: (_) => const SizedBox.shrink(),
                  successBuilder: (_) => Text(
                    '${activePatient!.bed} · ${activePatient.unit}',
                    style: TextStylesManager.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        PrimaryIconButtonWidget(
          semanticLabelKey: 'open_patient_census',
          onPressed: onOpenCensus,
          icon: const Icon(Icons.groups_2_outlined),
        ),
        PrimaryIconButtonWidget(
          semanticLabelKey: 'open_critical_alerts',
          onPressed: onOpenAlerts,
          icon: Badge(
            isLabelVisible: alertCount > 0,
            label: Text('$alertCount'),
            child: const Icon(Icons.notifications_none),
          ),
        ),
        PrimaryIconButtonWidget(
          semanticLabelKey: 'open_more',
          onPressed: onOpenMore,
          icon: const Icon(Icons.more_vert),
        ),
      ],
    );
  }
}
