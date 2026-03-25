import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const double mobileBreakpoint = 768;

class LayoutScaffold extends StatelessWidget {
  const LayoutScaffold({
    super.key,
    required this.child,
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  final Widget child;
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  bool _isMobile(double width) => width < mobileBreakpoint;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = _isMobile(constraints.maxWidth);

        return Scaffold(
          // Keep the shell responsible for app-level chrome only.
          body: SafeArea(
            bottom: false,
            child: isMobile
                ? child
                : Column(
                    children: [
                      const _TopHeader(),
                      Expanded(child: child),
                    ],
                  ),
          ),
          bottomNavigationBar: isMobile
              ? NavigationBar(
                  selectedIndex: currentIndex,
                  onDestinationSelected: onDestinationSelected,
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.search_outlined),
                      selectedIcon: Icon(Icons.search),
                      label: 'TBD 1',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.settings_outlined),
                      selectedIcon: Icon(Icons.settings),
                      label: 'TBD 2',
                    ),
                  ],
                )
              : null,
        );
      },
    );
  }
}

class _TopHeader extends StatelessWidget {
  const _TopHeader();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      child: SizedBox(
        height: 36,
        child: Row(
          children: [
            const SizedBox(width: 16),
            const Text(
              'Akasha',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                context.go('/');
              },
              style: TextButton.styleFrom(backgroundColor: Colors.transparent, textStyle: const TextStyle(fontSize: 13)),
              child: const Text('Home'),
            ),
            TextButton(
              onPressed: () {
                context.go('/attribute_templates');
              },
              style: TextButton.styleFrom(backgroundColor: Colors.transparent, textStyle: const TextStyle(fontSize: 13)),
              child: const Text('Attribute Templates'),
            ),
            TextButton(
              onPressed: () {
                context.go('/access_levels');
              },
              style: TextButton.styleFrom(backgroundColor: Colors.transparent, textStyle: const TextStyle(fontSize: 13)),
              child: const Text('Access Levels'),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
