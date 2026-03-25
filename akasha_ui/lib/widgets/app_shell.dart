import 'package:akasha_ui/widgets/layout_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutScaffold(
      currentIndex: navigationShell.currentIndex,
      onDestinationSelected: _goBranch,
      child: navigationShell,
    );
  }
}
