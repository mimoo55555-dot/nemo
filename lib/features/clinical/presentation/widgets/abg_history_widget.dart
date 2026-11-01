import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/primary/conditional_builder.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/abg_history_item_widget.dart';

class AbgHistoryWidget extends StatelessWidget {
  final List<ABGResult> results;

  const AbgHistoryWidget({super.key, required this.results});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        appTranslation().get('serial_abg_history'),
        style: TextStylesManager.sectionTitle,
      ),
      verticalSpace8,
      ConditionalBuilder(
        loadingState: false,
        emptyState: results.isEmpty,
        emptyBuilder: (_) => Card(
          color: ColorsManager.surface,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                appTranslation().get('no_historical_abg_draws'),
                style: TextStylesManager.bodySmall,
              ),
            ),
          ),
        ),
        successBuilder: (_) => ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: results.length,
          separatorBuilder: (_, _) => verticalSpace6,
          itemBuilder: (_, index) => AbgHistoryItemWidget(
            result: results[index],
          ),
        ),
      ),
    ],
  );
}
