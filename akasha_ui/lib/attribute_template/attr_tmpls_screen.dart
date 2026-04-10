import 'dart:math' as math;

import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_client/shared/upsert_type.dart';
import 'package:akasha_ui/access_level/access_level_logic.dart';
import 'package:akasha_ui/attribute_template/attr_tmpl_form.dart';
import 'package:akasha_ui/attribute_template/attr_tmpls_logic.dart';
import 'package:akasha_ui/attribute_template/attr_tmpls_state.dart';
import 'package:akasha_ui/theming/colors.dart';
import 'package:akasha_ui/theming/theme_cubit.dart';
import 'package:akasha_ui/utils/string.dart';
import 'package:akasha_ui/widgets/feedback.dart';
import 'package:akasha_ui/widgets/modal/draggable_modal.dart';
import 'package:akasha_ui/widgets/modal/modal_content.dart';
import 'package:akasha_ui/widgets/top_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttributeTmplsScreen extends StatefulWidget {
  const AttributeTmplsScreen({super.key});

  @override
  State<AttributeTmplsScreen> createState() => _AttributeTmplsScreenState();
}

class _AttributeTmplsScreenState extends State<AttributeTmplsScreen> with _ModalHelpers {
  int? _hoveredRowIndex;
  int _nextModalId = 1;

  @override
  void initState() {
    super.initState();
    context.read<AttributeTmplsLogic>().loadAll();
  }

  @override
  Widget build(BuildContext context) {
    final viewportSize = MediaQuery.sizeOf(context);
    final addButton = IconButton(
      onPressed: () => _openModal(viewportSize: viewportSize),
      icon: const Icon(Icons.add),
      iconSize: 20,
      tooltip: 'Add an attribute template',
    );

    return BlocConsumer<AttributeTmplsLogic, AttributeTemplatesState>(
      listenWhen: (previous, current) => current is AttributeTemplatesStateOpenModalFor || current is AttributeTemplatesLoadErrorState,
      listener: (context, state) async {
        // Note: BlocListener does not rebuild UI. It is meant for side effects such as dialogs, snackbars, and navigation.
        switch (state) {
          case AttributeTemplatesStateOpenModalFor(forItem: final attributeTmpl):
            debugPrint(
              '>>> [_AttributeTmplsScreenState.build] Reacting to AttributeTemplatesStateOpenModalFor item w/ id=${attributeTmpl.id} ...',
            );
            _openModal(item: attributeTmpl, readOnly: true, viewportSize: viewportSize);
            break;

          case AttributeTemplatesLoadErrorState(:final errorMessage):
            debugPrint('>>> [_AttributeTmplsScreenState.build] Reacting to AttributeTemplatesLoadErrorState: $errorMessage');
            showErrorSnackbar(context, errorMessage);
            break;

          default:
            break;
        }
      },
      buildWhen: (previous, current) => current is! AttributeTemplatesStateOpenModalFor,
      builder: (context, state) {
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

                      switch (state) {
                        AttributeTemplatesLoadingState() => const Center(child: CircularProgressIndicator()),

                        AttributeTemplatesLoadedState(:final items) => Center(
                          child: SingleChildScrollView(
                            child: Column(
                              children: items.isEmpty
                                  ? [
                                      const Text('No attribute templates yet.'),
                                      const SizedBox(height: 20),
                                      addButton,
                                    ]
                                  : [
                                      _buildTable(vwSize, isDarkMode, items),
                                      const SizedBox(height: 20),
                                      addButton,
                                    ],
                            ),
                          ),
                        ),

                        AttributeTemplatesLoadErrorState() => Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Failed to load entity templates.'),
                              const SizedBox(height: 16),
                              addButton,
                            ],
                          ),
                        ),

                        _ => const SizedBox.shrink(),
                      },

                      for (final modal in modals) // Render the modals.
                        DraggableModal(
                          key: ValueKey(modal.id),
                          data: modal,
                          viewport: viewportSize,
                          onTap: () => bringToFront(modal.id),
                          onClose: () => closeModal(modal.id),
                          onDrag: (offset) => updatePosition(modal.id, offset, viewportSize),
                        ),
                    ],
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTable(Size viewportSize, bool isDarkMode, List<AttributeTmpl> items) {
    final headerTextColor = isDarkMode ? darkFgColor.withAlpha(120) : Colors.grey.shade700;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 30,
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.25, color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13, vertical: 2),
                  child: Text('name', style: TextStyle(color: headerTextColor)),
                ),
              ),
              SizedBox(
                width: 300,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13, vertical: 2),
                  child: Text('description', style: TextStyle(color: headerTextColor)),
                ),
              ),
              SizedBox(
                width: 100,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13, vertical: 2),
                  child: Text('value type', style: TextStyle(color: headerTextColor)),
                ),
              ),
              SizedBox(
                width: 40,
                child: Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2), child: Text('')),
              ),
            ],
          ),
        ),
        ...items.asMap().entries.map((entry) {
          final index = entry.key;
          final tmpl = entry.value;
          final isHovered = _hoveredRowIndex == index;

          return MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) => setState(() => _hoveredRowIndex = index),
            onExit: (_) => setState(() => _hoveredRowIndex = null),
            child: Container(
              height: 28,
              decoration: BoxDecoration(
                color: isHovered ? (isDarkMode ? Colors.grey.shade700 : Colors.white) : Colors.transparent,
                border: Border(bottom: BorderSide(width: 0.25, color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300)),
                borderRadius: isHovered ? BorderRadius.circular(6) : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _openModal(
                      item: tmpl,
                      viewportSize: viewportSize,
                      readOnly: true,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 200,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            child: Text(limitChars(tmpl.name, 32)),
                          ),
                        ),
                        SizedBox(
                          width: 300,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            child: Text(tmpl.description != null ? limitChars(tmpl.description!, 40) : ''),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            child: Text(tmpl.valueType),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30,
                    child: Builder(
                      builder: (context) => IconButton(
                        icon: Icon(Icons.more_vert, size: 15, color: isHovered ? Colors.grey[800] : Colors.grey[500]),
                        onPressed: () => _openContextualMenu(context, tmpl, viewportSize),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Future<void> _openContextualMenu(BuildContext context, AttributeTmpl item, Size? viewportSize) async {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    final isDarkMode = context.read<ThemeCubit>().isDarkMode;
    final logic = context.read<AttributeTmplsLogic>();
    final result = await showMenu<String>(
      context: context,
      items: const [
        PopupMenuItem(value: 'edit', height: 32, child: Text('Edit')),
        PopupMenuItem(value: 'delete', height: 32, child: Text('Delete')),
      ],
      color: isDarkMode ? Colors.grey.shade900 : Colors.white,
      clipBehavior: Clip.antiAlias,
      menuPadding: EdgeInsets.symmetric(vertical: 0),
      position: position,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );

    if (result == 'edit') {
      _openModal(item: item, viewportSize: viewportSize);
    } else if (result == 'delete') {
      _delete(item, logic);
    }
  }

  Future<void> _openModal({
    AttributeTmpl? item,
    Size? viewportSize,
    bool readOnly = false,
    Offset? initialOffset,
  }) async {
    final id = _nextModalId++;
    final isEdit = item != null;
    final logic = context.read<AttributeTmplsLogic>();

    debugPrint(
      '>>> [_AttributeTmplsScreenState._openModal] Opening modal (id: $id) to ${readOnly
          ? 'view'
          : isEdit
          ? 'edit'
          : 'create'} an attribute template ...',
    );

    const modalSize = Size(340, 370);
    final offset =
        initialOffset ??
        (viewportSize != null
            ? Offset((viewportSize.width - modalSize.width) / 2, (viewportSize.height - modalSize.height) / 2)
            : const Offset(24, 80));

    final accessLevelsLogic = context.read<AccessLevelsLogic>();
    await accessLevelsLogic.loadAll();
    final accessLevels = accessLevelsLogic.cachedItems;
    addModal(
      id: id,
      title: readOnly
          ? 'Attribute Template'
          : isEdit
          ? 'Edit Attribute Template'
          : 'New Attribute Template',
      offset: offset,
      size: modalSize,
      child: AttributeTemplateForm(
        item: item,
        readOnly: readOnly,
        accessLevels: accessLevels,
        onRequestEdit: readOnly && item != null
            ? () {
                final currentModal = modals.firstWhere((m) => m.id == id);
                final currentOffset = currentModal.offset;

                closeModal(id);
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (!mounted) return;
                  _openModal(
                    item: item,
                    viewportSize: viewportSize,
                    readOnly: false,
                    initialOffset: currentOffset,
                  );
                });
              }
            : null,
        onSave: (item) async {
          try {
            if (isEdit) {
              final response = await logic.upsert(UpsertType.update, item, emitAll: true);
              if (response.success && mounted) {
                closeModal(id);
              } else if (!response.success) {
                if (!mounted) return;
                showErrorSnackbar(
                  context,
                  response.errorMessage ?? 'Failed to update attribute template: ${response.errorCode}',
                );
              }
              return;
            }

            final response = await logic.upsert(UpsertType.insert, item, emitAll: true);
            if (response.success && mounted) {
              closeModal(id);
            } else if (!response.success) {
              if (!mounted) return;
              showErrorSnackbar(
                context,
                response.errorMessage ?? 'Failed to create attribute template: ${response.errorCode}',
              );
            }
          } catch (e) {
            debugPrint('>>> [_AttributeTmplsScreenState._openModal] Failed to save attribute template: $e');
            if (!mounted) return;
            showErrorSnackbar(context, 'Failed to save attribute template: $e');
          }
        },
      ),
    );
  }

  Future<void> _delete(AttributeTmpl item, AttributeTmplsLogic logic) async {
    final isDarkMode = context.read<ThemeCubit>().isDarkMode;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Attribute Template', style: TextStyle(fontSize: 18)),
        content: Text('Are you sure you want to delete "${item.name}"?'),
        backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: ButtonStyle(overlayColor: WidgetStateProperty.all(Colors.red[50])),
            child: Text('Delete', style: TextStyle(color: Colors.red[600])),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await logic.delete(item.id!, emitAll: true);
      } catch (e) {
        debugPrint('>>> [_AttributeTmplsScreenState._deleteAttributeTmpl] Error deleting attribute template: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting template: $e')),
          );
        }
      }
    }
  }

  @override
  final List<ModalData> modals = []; // Just to satisfy the mixin requirement. The actual state is managed in _ModalHelpers.
}

mixin _ModalHelpers on State<AttributeTmplsScreen> {
  List<ModalData> get modals;

  void addModal({
    required int id,
    String? type,
    required String title,
    required Offset offset,
    required Size size,
    required AttributeTemplateForm child,
  }) {
    for (final modal in modals) {
      if ((modal.child as AttributeTemplateForm).item == child.item) {
        debugPrint('>>> [_ModalHelpers.addModal] That (attribute template) modal is already open.');
        return;
      }
    }
    setState(() {
      modals.add(ModalData(id: id, type: type, title: title, offset: offset, size: size, child: child));
    });
  }

  void bringToFront(int id) {
    setState(() {
      final int index = modals.indexWhere((m) => m.id == id);
      if (index == -1) return;
      final ModalData item = modals.removeAt(index);
      modals.add(item);
    });
  }

  void closeModal(int id) {
    setState(() {
      modals.removeWhere((m) => m.id == id);
    });
  }

  void updatePosition(int id, Offset nextOffset, Size viewport) {
    setState(() {
      final int index = modals.indexWhere((m) => m.id == id);
      if (index == -1) return;

      final ModalData modal = modals[index];
      final double maxLeft = math.max(0, viewport.width - modal.size.width);
      final double maxTop = math.max(0, viewport.height - modal.size.height);

      modals[index] = modal.copyWith(offset: Offset(nextOffset.dx.clamp(0.0, maxLeft), nextOffset.dy.clamp(0.0, maxTop)));
    });
  }
}
