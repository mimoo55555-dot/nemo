import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';

class MainShellNavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onSelect;

  const MainShellNavigationBarWidget({
    super.key,
    required this.currentIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) => BottomNavigationBar(
    currentIndex: currentIndex.clamp(0, 4),
    type: BottomNavigationBarType.fixed,
    selectedItemColor: ColorsManager.primary,
    unselectedItemColor: ColorsManager.grey,
    selectedFontSize: 11,
    unselectedFontSize: 11,
    onTap: onSelect,
    items: [
      BottomNavigationBarItem(
        icon: const Icon(Icons.air),
        label: appTranslation().get('ventilator'),
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.favorite_border),
        label: appTranslation().get('vitals'),
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.psychology_outlined),
        label: appTranslation().get('weaning'),
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.science_outlined),
        label: appTranslation().get('abg_lab'),
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.grid_view),
        label: appTranslation().get('more'),
      ),
    ],
  );
}
