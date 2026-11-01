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
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _modes
              .map(
                (mode) => Padding(
                  padding: const EdgeInsetsDirectional.only(end: 6),
                  child: ChoiceChip(
                    label: Text(mode),
                    selected: selectedMode == mode,
                    selectedColor: ColorsManager.primary,
                    labelStyle: TextStylesManager.caption.copyWith(
                      color: selectedMode == mode
                          ? ColorsManager.white
                          : ColorsManager.textSecondary,
                    ),
                    onSelected: (_) => onSelected(mode),
                  ),
                ),
              )
              .toList(growable: false),
        ),
      ),
    ],
  );
}
