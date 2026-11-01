import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/utils/extensions/context_extension.dart';
import 'package:nemoventrt/features/clinical/presentation/logic/auth_cubit.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/more_module_tile_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/more_modules_section_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/module_info_dialog_widget.dart';

class SecurityModulesSectionWidget extends StatelessWidget {
  const SecurityModulesSectionWidget({super.key});

  @override
  Widget build(BuildContext context) => MoreModulesSectionWidget(
    titleKey: 'app_security',
    tiles: [
      MoreModuleTileWidget(
        titleKey: 'audit_title',
        subtitleKey: 'audit_subtitle',
        icon: Icons.verified_user_outlined,
        iconColor: ColorsManager.green,
        onTap: () => _showInfo(context, 'audit_info_title', 'audit_info_body'),
      ),
      MoreModuleTileWidget(
        titleKey: 'legal_title',
        subtitleKey: 'legal_subtitle',
        icon: Icons.gavel_rounded,
        iconColor: ColorsManager.purple,
        onTap: () => _showInfo(context, 'legal_info_title', 'legal_info_body'),
      ),
      MoreModuleTileWidget(
        titleKey: 'sign_out_title',
        subtitleKey: 'sign_out_subtitle',
        icon: Icons.logout_rounded,
        iconColor: ColorsManager.grey,
        onTap: () {
          AuthCubit.get(context).logout();
          context.pop;
        },
      ),
    ],
  );

  void _showInfo(BuildContext context, String titleKey, String bodyKey) {
    context.pop;
    showDialog<void>(
      context: context,
      builder: (_) => ModuleInfoDialogWidget(
        titleKey: titleKey,
        bodyKey: bodyKey,
      ),
    );
  }
}
