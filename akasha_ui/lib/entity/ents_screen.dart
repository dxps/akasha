import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_ui/entity/ent_row.dart';
import 'package:akasha_ui/entity/ents_cubit.dart';
import 'package:akasha_ui/entity/ents_state.dart';
import 'package:akasha_ui/theming/theme_cubit.dart';
import 'package:akasha_ui/utils/string.dart';
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
  void initState() {
    super.initState();
    context.read<EntitiesCubit>().fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ThemeCubit, ThemeMode, bool>(
      selector: (themeMode) => themeMode == ThemeMode.dark,
      builder: (context, isDarkMode) {
        return Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              final Size vwSize = Size(constraints.maxWidth, constraints.maxHeight);
              return Stack(
                children: [
                  const TopHeader(),
                  SafeArea(
                    child: BlocBuilder<EntitiesCubit, EntitiesState>(
                      builder: (context, state) {
                        switch (state.status) {
                          case EntitiesStatus.initial:
                          case EntitiesStatus.loading:
                            return const Center(
                              child: CircularProgressIndicator(),
                            );

                          case EntitiesStatus.failure:
                            return Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text('Failed to load entities'),
                                  const SizedBox(height: 12),
                                  ElevatedButton(
                                    onPressed: () {
                                      context.read<EntitiesCubit>().fetchAll();
                                    },
                                    child: const Text('Retry'),
                                  ),
                                ],
                              ),
                            );

                          case EntitiesStatus.success:
                            if (state.entities.isEmpty) {
                              return const Center(
                                child: Text('There are no entities.'),
                              );
                            }

                            return _buildTable(vwSize, isDarkMode, state.entities);
                        }
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildTable(Size? viewportSize, bool isDarkMode, List<Entity> entities) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 30,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 0.25,
                color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade400,
              ),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text('name', style: TextStyle(color: Colors.grey)),
                ),
              ),
              SizedBox(
                width: 300,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text('description', style: TextStyle(color: Colors.grey)),
                ),
              ),
              SizedBox(
                width: 30,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text(''),
                ),
              ),
            ],
          ),
        ),
        ...entities.map((entity) {
          return EntityRow(
            item: entity,
            nameText: limitChars(entity.listingAttribute.$1, 32),
            descriptionText: limitChars(entity.listingAttribute.$2, 40),
            onView: () async {
              // final item = await client.entity.read(entity.id!);
              //   final item = await context.read<EntitiesCubit>().fetchById(entity.id!);
              //   if (item != null) {
              // debugPrint('>>> Got entity template for view: $item');
              // _openModal(item: item, viewportSize: size, readOnly: true);
              //   } else {
              // debugPrint('Failed to load entity template with id ${entity.id} for view.');
              // if (!mounted) return;
              // showErrorSnackbar(context, 'Failed to load entity template details.');
              //   }
            },
            // onEdit: () async {
            //   debugPrint('>>> Got entity template for edit: $entity');
            //   final item = await client.entityTmpl.read(entity.id!);
            //   if (item != null) {
            //     debugPrint('>>> Got entity template for edit: $item');
            //     _openModal(item: item, viewportSize: size);
            //   } else {
            //     debugPrint('Failed to load entity template with id ${entity.id} for edit.');
            //     if (!mounted) return;
            //     showErrorSnackbar(context, 'Failed to load entity template details for edit.');
            //   }
            // },
            // onDelete: () => _deleteEntityTemplate(template),
            onEdit: () async {},
            onDelete: () async {},
          );
        }),
      ],
    );
  }
}
