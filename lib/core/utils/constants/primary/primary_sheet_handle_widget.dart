import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';

class PrimarySheetHandleWidget extends StatelessWidget {
  const PrimarySheetHandleWidget({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.only(top: 12, bottom: 8),
    child: Center(
      child: Container(
        width: 36,
        height: 4,
        decoration: BoxDecoration(
          color: ColorsManager.border,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}
