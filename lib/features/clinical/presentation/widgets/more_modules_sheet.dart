import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/models/staff_user.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/primary/conditional_builder.dart';
import 'package:nemoventrt/core/utils/constants/primary/primary_icon_button_widget.dart';
import 'package:nemoventrt/core/utils/extensions/context_extension.dart';
import 'package:nemoventrt/features/clinical/presentation/logic/auth_cubit.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/active_patient_summary_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/appearance_language_settings_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/more_modules_list_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/staff_profile_card_widget.dart';

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
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      child: SafeArea(
        child: Column(
          children: [
            PrimaryIconButtonWidget(
              semanticLabelKey: 'close',
              onPressed: () => context.pop,
              icon: const Icon(Icons.close),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  appTranslation().get('clinical_suite_tools'),
                  style: TextStylesManager.title,
                ),
              ),
            ),
            StaffProfileCardWidget(user: user),
            const AppearanceLanguageSettingsWidget(),
            ConditionalBuilder(
              loadingState: false,
              emptyState: activePatient == null,
              emptyBuilder: (_) => const SizedBox.shrink(),
              successBuilder: (_) => ActivePatientSummaryWidget(
                patient: activePatient!,
              ),
            ),
            Expanded(
              child: MoreModulesListWidget(activePatient: activePatient),
            ),
          ],
        ),
      ),
    ),
  );
}
