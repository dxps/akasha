import 'package:akasha_ui/routing.dart';
import 'package:akasha_ui/theming/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TopHeader extends StatelessWidget {
  const TopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ThemeCubit, ThemeMode, bool>(
      selector: (themeMode) => themeMode == ThemeMode.dark,
      builder: (context, isDarkMode) {
        return Material(
          color: Theme.of(context).scaffoldBackgroundColor,
          surfaceTintColor: Colors.transparent,
          child: SizedBox(
            height: 36,
            child: Row(
              children: [
                const SizedBox(width: 2),
                InkWell(
                  hoverColor: Colors.transparent,
                  onTap: () => context.go(Routes.home.path),
                  child: Image.asset('images/logo_o_light_grey.png', width: 34, height: 34),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    context.go(Routes.home.path);
                  },
                  style: TextButton.styleFrom(backgroundColor: Colors.transparent, textStyle: const TextStyle(fontSize: 13)),
                  child: const Text('Home'),
                ),
                TextButton(
                  onPressed: () {
                    context.go(Routes.entities.path);
                  },
                  style: TextButton.styleFrom(backgroundColor: Colors.transparent, textStyle: const TextStyle(fontSize: 13)),
                  child: const Text('Entities'),
                ),
                TextButton(
                  onPressed: () {
                    context.go(Routes.entityTemplates.path);
                  },
                  style: TextButton.styleFrom(backgroundColor: Colors.transparent, textStyle: const TextStyle(fontSize: 13)),
                  child: const Text('Entity Templates'),
                ),
                TextButton(
                  onPressed: () {
                    context.go(Routes.attributeTemplates.path);
                  },
                  style: TextButton.styleFrom(backgroundColor: Colors.transparent, textStyle: const TextStyle(fontSize: 13)),
                  child: const Text('Attribute Templates'),
                ),
                TextButton(
                  onPressed: () {
                    context.go(Routes.accessLevels.path);
                  },
                  style: TextButton.styleFrom(backgroundColor: Colors.transparent, textStyle: const TextStyle(fontSize: 13)),
                  child: const Text('Access Levels'),
                ),
                const SizedBox(width: 16),
                IconButton(
                  tooltip: isDarkMode ? 'Switch to light mode' : 'Switch to dark mode',
                  onPressed: () => context.read<ThemeCubit>().toggleTheme(),
                  icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
                  iconSize: 16,
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
