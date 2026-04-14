import 'dart:math' as math;

import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_ui/access_level/access_level_logic.dart';
import 'package:akasha_ui/attribute_template/attr_tmpls_logic.dart';
import 'package:akasha_ui/entity/ent_form.dart';
import 'package:akasha_ui/entity/ent_row.dart';
import 'package:akasha_ui/entity/ents_cubit.dart';
import 'package:akasha_ui/entity/ents_state.dart';
import 'package:akasha_ui/entity_template/ent_tmpls_logic.dart';
import 'package:akasha_ui/theming/colors.dart';
import 'package:akasha_ui/theming/theme_cubit.dart';
import 'package:akasha_ui/utils/string.dart';
import 'package:akasha_ui/widgets/feedback.dart';
import 'package:akasha_ui/widgets/modal/draggable_modal.dart';
import 'package:akasha_ui/widgets/modal/modal_content.dart';
import 'package:akasha_ui/widgets/top_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntitiesScreen extends StatefulWidget {
  const EntitiesScreen({super.key});

  @override
  State<EntitiesScreen> createState() => _EntitiesScreenState();
}

class _EntitiesScreenState extends State<EntitiesScreen> with _ModalHelpers {
  int _nextModalId = 1;
  late final EntitiesCubit entitiesCubit;
  late final AccessLevelsLogic accessLevelsLogic;
  late final EntityTmplLogic entityTmplLogic;

  @override
  void initState() {
    super.initState();
    entitiesCubit = context.read<EntitiesCubit>();
    accessLevelsLogic = context.read<AccessLevelsLogic>();
    entityTmplLogic = context.read<EntityTmplLogic>();
    entitiesCubit.fetchAll();
    accessLevelsLogic.loadAll();
    entityTmplLogic.loadAll();
  }

  Future<void> _forceReloadEntries() async {
    await entitiesCubit.fetchAll(forceRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    final viewportSize = MediaQuery.sizeOf(context);
    final addButton = IconButton(
      icon: const Icon(Icons.add),
      iconSize: 16,
      tooltip: 'Add an entity',
      onPressed: () => _startCreateFlow(viewportSize: viewportSize),
    );

    return BlocSelector<ThemeCubit, ThemeMode, bool>(
      selector: (themeMode) => themeMode == ThemeMode.dark,
      builder: (context, isDarkMode) {
        return Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              final vwSize = Size(constraints.maxWidth, constraints.maxHeight);
              return Stack(
                children: [
                  const TopHeader(),
                  SafeArea(
                    child: BlocBuilder<EntitiesCubit, EntitiesState>(
                      builder: (context, state) {
                        switch (state.status) {
                          case EntitiesStatus.initial:
                          case EntitiesStatus.loading:
                            return const Center(child: CircularProgressIndicator());
                          case EntitiesStatus.failure:
                            return Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text('Failed to load entities'),
                                  const SizedBox(height: 12),
                                  ElevatedButton(
                                    onPressed: () => entitiesCubit.fetchAll(forceRefresh: true),
                                    child: const Text('Retry'),
                                  ),
                                ],
                              ),
                            );
                          case EntitiesStatus.success:
                            if (state.entities.isEmpty) {
                              return Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('There are no entities.'),
                                    const SizedBox(height: 12),
                                    addButton,
                                  ],
                                ),
                              );
                            } else {
                              return Center(
                                child: _buildTable(vwSize, isDarkMode, state.entities, addButton),
                              );
                            }
                        }
                      },
                    ),
                  ),
                  for (final modal in modals)
                    DraggableModal(
                      key: ValueKey(modal.id),
                      data: modal,
                      viewport: vwSize,
                      onTap: () => _bringToFront(modal.id),
                      onClose: () => _closeModal(modal.id),
                      onDrag: (offset) => _updatePosition(modal.id, offset, vwSize),
                      onResize: (size) => _updateSize(modal.id, size, vwSize),
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _startCreateFlow({required Size viewportSize}) async {
    final isDarkMode = context.read<ThemeCubit>().isDarkMode;
    final choice = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Entity'),
        content: const Text('Choose how you want to create the entity.'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.white,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'scratch'),
            child: const Text('From scratch'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'template'),
            child: const Text('From template'),
          ),
        ],
      ),
    );

    if (!mounted || choice == null) return;

    if (choice == 'scratch') {
      _openModal(viewportSize: viewportSize);
      return;
    }

    final selectedTemplate = await _selectTemplate();
    if (!mounted || selectedTemplate == null) return;

    await context.read<AttributeTmplsLogic>().loadAll();
    if (!mounted) return;

    final fullTemplate = await entityTmplLogic.repo.getById(selectedTemplate.id!, full: true);
    if (!mounted) return;
    if (fullTemplate == null) {
      showErrorSnackbar(context, 'Failed to load the selected entity template.');
      return;
    }

    _openModal(viewportSize: viewportSize, initialTemplate: fullTemplate);
  }

  Future<EntityTmpl?> _selectTemplate() async {
    await entityTmplLogic.loadAll();
    if (!mounted) return null;
    final templates = entityTmplLogic.cachedItems;
    if (templates.isEmpty) {
      showErrorSnackbar(context, 'There are no entity templates available.');
      return null;
    }

    final isDarkMode = context.read<ThemeCubit>().isDarkMode;
    return showDialog<EntityTmpl>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Choose Entity Template'),
        backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.white,
        children: [
          for (final template in templates)
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, template),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(template.name),
                  if ((template.description ?? '').isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        template.description!,
                        style: TextStyle(color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700, fontSize: 12),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTable(Size? viewportSize, bool isDarkMode, List<Entity> entities, Widget addButton) {
    final size = viewportSize ?? MediaQuery.sizeOf(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 30,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 0.25, color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade400),
            ),
          ),
          child: Row(
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
                child: addButton,
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
              final item = await entitiesCubit.fetchById(entity.id!);
              if (item == null) {
                if (!mounted) return;
                showErrorSnackbar(context, 'Failed to load entity details.');
                return;
              }
              _openModal(item: item, viewportSize: size, readOnly: true);
            },
            onEdit: () async {
              final item = await entitiesCubit.fetchById(entity.id!);
              if (item == null) {
                if (!mounted) return;
                showErrorSnackbar(context, 'Failed to load entity details for edit.');
                return;
              }
              _openModal(item: item, viewportSize: size);
            },
            onDelete: () => _delete(entity),
          );
        }),
      ],
    );
  }

  Future<void> _openModal({
    Entity? item,
    EntityTmpl? initialTemplate,
    Size? viewportSize,
    bool readOnly = false,
    Offset? initialOffset,
  }) async {
    final id = _nextModalId++;
    final isEdit = item != null;
    final modalSize = readOnly
        ? const Size(500, 450)
        : isEdit
        ? const Size(700, 600)
        : const Size(700, 600);
    final offset =
        initialOffset ??
        (viewportSize != null
            ? Offset((viewportSize.width - modalSize.width) / 2, (viewportSize.height - modalSize.height) / 2)
            : const Offset(24, 80));
    final formController = EntityFormController();

    _addModal(
      id: id,
      type: isEdit ? 'edit' : 'new',
      title: readOnly
          ? 'Entity'
          : isEdit
          ? 'Entity :: Edit'
          : 'Entity :: New',
      offset: offset,
      size: modalSize,
      titleActions: _EntityModalTitleActions(
        controller: formController,
        readOnly: readOnly,
        isEdit: isEdit,
      ),
      child: EntityForm(
        item: item,
        initialTemplate: initialTemplate,
        controller: formController,
        readOnly: readOnly,
        onRequestEdit: () {
          if (readOnly && item != null) {
            final currentModal = modals.firstWhere((m) => m.id == id);
            final currentOffset = currentModal.offset;
            _closeModal(id);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;
              _openModal(item: item, viewportSize: viewportSize, initialOffset: currentOffset);
            });
          }
        },
        onRequestView: () {
          if (!readOnly && item != null) {
            final currentModal = modals.firstWhere((m) => m.id == id);
            final currentOffset = currentModal.offset;
            _closeModal(id);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;
              _openModal(item: item, viewportSize: viewportSize, readOnly: true, initialOffset: currentOffset);
            });
          }
        },
        onSave: (entity) async {
          try {
            final response = await entitiesCubit.upsert(entity);
            if (!mounted) return;
            if (response.success) {
              _closeModal(id);
              await _forceReloadEntries();
            } else {
              showErrorSnackbar(context, response.errorMessage ?? 'Failed to save entity: ${response.errorCode}');
            }
          } catch (e) {
            if (!mounted) return;
            showErrorSnackbar(context, 'Failed to save entity: $e');
          }
        },
      ),
    );
  }

  Future<void> _delete(Entity item) async {
    final isDarkMode = context.read<ThemeCubit>().isDarkMode;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Entity'),
        content: Text('Are you sure you want to delete "${item.listingAttribute.$1}"?'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.white,
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: ButtonStyle(overlayColor: WidgetStateProperty.all(Colors.red[50])),
            child: Text('Delete', style: TextStyle(color: Colors.red[600])),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      final response = await entitiesCubit.delete(item.id!);
      if (!mounted) return;
      if (!response.success) {
        showErrorSnackbar(context, response.errorMessage ?? 'Failed to delete entity: ${response.errorCode}');
      }
    } catch (e) {
      if (!mounted) return;
      showErrorSnackbar(context, 'Error deleting entity: $e');
    }
  }

  @override
  final List<ModalData> modals = [];
}

class _EntityModalTitleActions extends StatelessWidget {
  const _EntityModalTitleActions({
    required this.controller,
    required this.readOnly,
    required this.isEdit,
  });

  final EntityFormController controller;
  final bool readOnly;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.read<ThemeCubit>().isDarkMode;
    final actionColor = isDarkMode ? darkFgFadedColor : lightFgFadedColor;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        if (readOnly) {
          return IconButton(
            onPressed: isEdit ? controller.requestEdit : null,
            color: actionColor,
            disabledColor: actionColor.withAlpha(90),
            icon: const Icon(Icons.edit_outlined, size: 18),
            tooltip: 'Edit',
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            visualDensity: VisualDensity.compact,
            style: IconButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          );
        }

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isEdit)
              IconButton(
                onPressed: controller.isSaving ? null : controller.requestView,
                color: actionColor,
                disabledColor: actionColor.withAlpha(90),
                icon: const Icon(Icons.arrow_back, size: 18),
                tooltip: 'Back to view',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                visualDensity: VisualDensity.compact,
                style: IconButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              ),
            if (isEdit) const SizedBox(width: 8),
            IconButton(
              onPressed: controller.isSaving ? null : controller.save,
              color: actionColor,
              disabledColor: actionColor.withAlpha(90),
              icon: controller.isSaving
                  ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.save, size: 18),
              tooltip: isEdit ? 'Update' : 'Add',
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              visualDensity: VisualDensity.compact,
              style: IconButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
            ),
          ],
        );
      },
    );
  }
}

mixin _ModalHelpers on State<EntitiesScreen> {
  List<ModalData> get modals;

  void _addModal({
    required int id,
    String? type,
    required String title,
    required Offset offset,
    required Size size,
    required EntityForm child,
    Widget? titleActions,
  }) {
    for (final modal in modals) {
      if ((modal.child as EntityForm).item?.id == child.item?.id) {
        return;
      }
    }
    setState(() {
      modals.add(ModalData(id: id, type: type, title: title, offset: offset, size: size, child: child, titleActions: titleActions));
    });
  }

  void _bringToFront(int id) {
    setState(() {
      final index = modals.indexWhere((m) => m.id == id);
      if (index == -1) return;
      final item = modals.removeAt(index);
      modals.add(item);
    });
  }

  void _closeModal(int id) {
    setState(() {
      modals.removeWhere((m) => m.id == id);
    });
  }

  void _updatePosition(int id, Offset nextOffset, Size viewport) {
    setState(() {
      final index = modals.indexWhere((m) => m.id == id);
      if (index == -1) return;

      final modal = modals[index];
      final maxLeft = math.max(0, viewport.width - modal.size.width);
      final maxTop = math.max(0, viewport.height - modal.size.height);

      modals[index] = modal.copyWith(
        offset: Offset(
          nextOffset.dx.clamp(0.0, maxLeft).toDouble(),
          nextOffset.dy.clamp(0.0, maxTop).toDouble(),
        ),
      );
    });
  }

  void _updateSize(int id, Size nextSize, Size viewport) {
    setState(() {
      final index = modals.indexWhere((m) => m.id == id);
      if (index == -1) return;

      final modal = modals[index];
      final maxLeft = math.max(0, viewport.width - nextSize.width);
      final maxTop = math.max(0, viewport.height - nextSize.height);

      modals[index] = modal.copyWith(
        size: nextSize,
        offset: Offset(
          modal.offset.dx.clamp(0.0, maxLeft).toDouble(),
          modal.offset.dy.clamp(0.0, maxTop).toDouble(),
        ),
      );
    });
  }
}
