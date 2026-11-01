import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/primary/primary_icon_button_widget.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';

class AdmitPatientSheetHeaderWidget extends StatelessWidget {
  final VoidCallback onClose;

  const AdmitPatientSheetHeaderWidget({
    super.key,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 12, 12),
    child: Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: ColorsManager.primaryLight,
          child: Icon(
            Icons.person_add_alt_1_rounded,
            color: ColorsManager.primaryText,
          ),
        ),
        horizontalSpace12,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appTranslation().get('admit_new_icu_patient'),
                style: TextStylesManager.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              verticalSpace2,
              Text(
                appTranslation().get('admit_patient_sheet_subtitle'),
                style: TextStylesManager.caption,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        PrimaryIconButtonWidget(
          semanticLabelKey: 'close',
          onPressed: onClose,
          icon: const Icon(Icons.close_rounded),
        ),
      ],
    ),
  );
}
