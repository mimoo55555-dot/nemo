import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/utils/extensions/context_extension.dart';
import 'package:nemoventrt/features/clinical/presentation/logic/auth_cubit.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/more_modules_section_header_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/more_module_tile_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/module_info_dialog_widget.dart';

class MoreModulesListWidget extends StatelessWidget {
  final Patient? activePatient;

  const MoreModulesListWidget({super.key, required this.activePatient});

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 20),
    children: [
      const MoreModulesSectionHeaderWidget(titleKey: 'advanced_modules'),
      MoreModuleTileWidget(
        titleKey: 'pharmacology_title',
        subtitleKey: 'pharmacology_subtitle',
        icon: Icons.medication,
        iconColor: ColorsManager.purple,
        onTap: () => _showInfo(
          context,
          'pharmacology_info_title',
          'pharmacology_info_body',
        ),
      ),
      MoreModuleTileWidget(
        titleKey: 'airway_title',
        subtitleKey: 'airway_subtitle',
        icon: Icons.medical_services,
        iconColor: ColorsManager.primaryText,
        onTap: () => _showInfo(
          context,
          'airway_info_title',
          'airway_info_body',
          replacements: {
            'size': '${activePatient?.etTubeSize ?? 7.5}',
            'depth': '${activePatient?.etTubeDepth ?? 22}',
          },
        ),
      ),
      MoreModuleTileWidget(
        titleKey: 'hemodynamics_title',
        subtitleKey: 'hemodynamics_subtitle',
        icon: Icons.show_chart,
        iconColor: ColorsManager.blue,
        onTap: () => _showInfo(
          context,
          'hemodynamics_info_title',
          'hemodynamics_info_body',
        ),
      ),
      MoreModuleTileWidget(
        titleKey: 'pediatric_protocol_title',
        subtitleKey: 'pediatric_protocol_subtitle',
        icon: Icons.child_care,
        iconColor: ColorsManager.amber,
        onTap: () =>
            _showInfo(context, 'pediatric_info_title', 'pediatric_info_body'),
      ),
      const MoreModulesSectionHeaderWidget(titleKey: 'app_security'),
      MoreModuleTileWidget(
        titleKey: 'audit_title',
        subtitleKey: 'audit_subtitle',
        icon: Icons.verified_user,
        iconColor: ColorsManager.green,
        onTap: () => _showInfo(context, 'audit_info_title', 'audit_info_body'),
      ),
      MoreModuleTileWidget(
        titleKey: 'legal_title',
        subtitleKey: 'legal_subtitle',
        icon: Icons.gavel,
        iconColor: ColorsManager.purple,
        onTap: () => _showInfo(context, 'legal_info_title', 'legal_info_body'),
      ),
      MoreModuleTileWidget(
        titleKey: 'sign_out_title',
        subtitleKey: 'sign_out_subtitle',
        icon: Icons.logout,
        iconColor: ColorsManager.grey,
        onTap: () {
          AuthCubit.get(context).logout();
          context.pop;
        },
      ),
    ],
  );

  void _showInfo(
    BuildContext context,
    String titleKey,
    String bodyKey, {
    Map<String, String> replacements = const {},
  }) {
    context.pop;
    showDialog<void>(
      context: context,
      builder: (_) => ModuleInfoDialogWidget(
        titleKey: titleKey,
        bodyKey: bodyKey,
        replacements: replacements,
      ),
    );
  }
}
