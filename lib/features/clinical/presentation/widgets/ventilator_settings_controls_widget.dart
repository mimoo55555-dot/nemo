import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/ventilator_settings_sliders_widget.dart';

class VentilatorSettingsControlsWidget extends StatelessWidget {
  final VentilatorSettings settings;
  final ValueChanged<VentilatorSettings> onChanged;

  const VentilatorSettingsControlsWidget({
    super.key,
    required this.settings,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) => Card(
    color: ColorsManager.surface,
    child: Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appTranslation().get('ventilator_settings'),
            style: TextStylesManager.sectionTitle,
          ),
          verticalSpace8,
          VentilatorSettingsSlidersWidget(
            settings: settings,
            onChanged: onChanged,
          ),
        ],
      ),
    ),
  );
}
