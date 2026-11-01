import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';

class VentilatorModeSelectorWidget extends StatelessWidget {
  final String selectedMode;
  final ValueChanged<String> onSelected;

  const VentilatorModeSelectorWidget({
    super.key,
    required this.selectedMode,
    required this.onSelected,
  });

  static const _modes = [
    'VC-CMV',
    'PC-CMV',
    'SIMV',
    'PSV',
    'PRVC',
    'APRV',
    'BiLevel',
    'HFOV',
  ];

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        appTranslation().get('ventilation_mode'),
        style: TextStylesManager.sectionTitle,
      ),
      verticalSpace8,
      Card(
        color: ColorsManager.surface,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(12, 10, 12, 6),
          child: Wrap(
            spacing: 8,
            runSpacing: 2,
            children: _modes
                .map(
                  (mode) => ChoiceChip(
                    label: Text(mode),
                    selected: selectedMode == mode,
                    selectedColor: ColorsManager.primary,
                    showCheckmark: false,
                    labelStyle: TextStylesManager.caption.copyWith(
                      color: selectedMode == mode
                          ? ColorsManager.white
                          : ColorsManager.textSecondary,
                      fontWeight: selectedMode == mode
                          ? FontWeight.bold
                          : FontWeight.w500,
                    ),
                    onSelected: (_) => onSelected(mode),
                  ),
                )
                .toList(growable: false),
          ),
        ),
      ),
    ],
  );
}
