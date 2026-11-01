import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/utils/extensions/context_extension.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/more_module_tile_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/more_modules_section_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/module_info_dialog_widget.dart';

class AdvancedModulesSectionWidget extends StatelessWidget {
  final Patient? activePatient;

  const AdvancedModulesSectionWidget({
    super.key,
    required this.activePatient,
  });

  @override
  Widget build(BuildContext context) => MoreModulesSectionWidget(
    titleKey: 'advanced_modules',
    tiles: [
      MoreModuleTileWidget(
        titleKey: 'pharmacology_title',
        subtitleKey: 'pharmacology_subtitle',
        icon: Icons.medication_outlined,
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
        icon: Icons.medical_services_outlined,
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
        icon: Icons.monitor_heart_outlined,
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
        icon: Icons.child_care_outlined,
        iconColor: ColorsManager.amber,
        onTap: () => _showInfo(
          context,
          'pediatric_info_title',
          'pediatric_info_body',
        ),
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
