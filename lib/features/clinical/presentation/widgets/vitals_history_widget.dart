import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/primary/conditional_builder.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/vitals_history_item_widget.dart';

class VitalsHistoryWidget extends StatelessWidget {
  final List<VitalObservation> observations;

  const VitalsHistoryWidget({super.key, required this.observations});

  @override
  Widget build(BuildContext context) => ConditionalBuilder(
    loadingState: false,
    emptyState: observations.isEmpty,
    emptyBuilder: (_) => Card(
      color: ColorsManager.surface,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Text(appTranslation().get('no_telemetry_records')),
        ),
      ),
    ),
    successBuilder: (_) => ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: observations.length,
      separatorBuilder: (_, _) => verticalSpace6,
      itemBuilder: (context, index) => VitalsHistoryItemWidget(
        observation: observations[index],
      ),
    ),
  );
}
