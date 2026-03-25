import 'package:flutter/material.dart';

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
