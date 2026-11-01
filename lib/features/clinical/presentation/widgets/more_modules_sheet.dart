import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/models/staff_user.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/primary/primary_icon_button_widget.dart';
import 'package:nemoventrt/core/utils/constants/primary/primary_sheet_handle_widget.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';
import 'package:nemoventrt/core/utils/extensions/context_extension.dart';
import 'package:nemoventrt/features/clinical/presentation/logic/auth_cubit.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/more_modules_list_widget.dart';

class MoreModulesSheet extends StatelessWidget {
  final Patient? activePatient;

  const MoreModulesSheet({super.key, this.activePatient});

  @override
  Widget build(BuildContext context) => BlocBuilder<AuthCubit, StaffUser?>(
    buildWhen: (previous, current) => previous != current,
    builder: (context, user) => Container(
      decoration: BoxDecoration(
        color: ColorsManager.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.92,
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const PrimarySheetHandleWidget(),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 12, 8),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: ColorsManager.primaryLight,
                    child: Icon(
                      Icons.medical_information_outlined,
                      color: ColorsManager.primaryText,
                    ),
                  ),
                  horizontalSpace12,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appTranslation().get('clinical_suite_tools'),
                          style: TextStylesManager.title.copyWith(fontSize: 18),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        verticalSpace2,
                        Text(
                          appTranslation().get('suite_tools_subtitle'),
                          style: TextStylesManager.caption,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  PrimaryIconButtonWidget(
                    semanticLabelKey: 'close',
                    onPressed: () => context.pop,
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
            ),
            Expanded(
              child: MoreModulesListWidget(
                activePatient: activePatient,
                user: user,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
