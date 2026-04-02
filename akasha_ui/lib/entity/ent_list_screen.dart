import 'package:akasha_ui/theming/theme_cubit.dart';
import 'package:akasha_ui/widgets/top_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntitiesScreen extends StatefulWidget {
  const EntitiesScreen({super.key});

  @override
  State<EntitiesScreen> createState() => _EntitiesScreenState();
}

class _EntitiesScreenState extends State<EntitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<ThemeCubit, ThemeMode, bool>(
      selector: (themeMode) => themeMode == ThemeMode.dark,
      builder: (context, isDarkMode) {
        return Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              // final Size vwSize = Size(constraints.maxWidth, constraints.maxHeight);
              return Stack(
                children: [
                  const TopHeader(),
                  const Center(
                    child: Text('Entities Screen'),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
