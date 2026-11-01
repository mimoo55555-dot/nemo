import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) => NavigationBar(
    selectedIndex: currentIndex.clamp(0, 3),
    onDestinationSelected: onSelect,
    destinations: [
      NavigationDestination(
        icon: const Icon(Icons.air_outlined),
        selectedIcon: const Icon(Icons.air),
        label: appTranslation().get('ventilator'),
      ),
      NavigationDestination(
        icon: const Icon(Icons.favorite_border),
        selectedIcon: const Icon(Icons.favorite),
        label: appTranslation().get('vitals'),
      ),
      NavigationDestination(
        icon: const Icon(Icons.psychology_outlined),
        selectedIcon: const Icon(Icons.psychology),
        label: appTranslation().get('weaning'),
      ),
      NavigationDestination(
        icon: const Icon(Icons.science_outlined),
        selectedIcon: const Icon(Icons.science),
        label: appTranslation().get('abg_lab'),
      ),
      NavigationDestination(
        icon: const Icon(Icons.grid_view_outlined),
        selectedIcon: const Icon(Icons.grid_view_rounded),
        label: appTranslation().get('more'),
      ),
    ],
  );
}
