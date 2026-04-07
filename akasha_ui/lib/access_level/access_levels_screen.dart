import 'dart:math' as math;

import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_client/shared/upsert_type.dart';
import 'package:akasha_ui/access_level/access_level_form.dart';
import 'package:akasha_ui/access_level/access_level_logic.dart';
import 'package:akasha_ui/access_level/access_level_row.dart';
import 'package:akasha_ui/access_level/access_level_state.dart';
import 'package:akasha_ui/theming/theme_cubit.dart';
import 'package:akasha_ui/utils/string.dart';
import 'package:akasha_ui/widgets/feedback.dart';
import 'package:akasha_ui/widgets/modal/draggable_modal.dart';
import 'package:akasha_ui/widgets/modal/modal_content.dart';
import 'package:akasha_ui/widgets/top_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccessLevelsScreen extends StatefulWidget {
  const AccessLevelsScreen({super.key});

  @override
  State<AccessLevelsScreen> createState() => _AccessLevelsScreenState();
}

class _AccessLevelsScreenState extends State<AccessLevelsScreen> with _ModalHelpers {
  bool isFetchingData = false;
  int _nextModalId = 1;

  @override
  void initState() {
    super.initState();
    context.read<AccessLevelsLogic>().loadAll();
  }

  @override
  Widget build(BuildContext context) {
    final viewportSize = MediaQuery.sizeOf(context);
    final addButton = IconButton(
      onPressed: () => _openModal(viewportSize: viewportSize),
      icon: const Icon(Icons.add),
      tooltip: 'Add an access level',
    );

    return BlocConsumer<AccessLevelsLogic, AccessLevelsState>(
      listenWhen: (previous, current) => current is AccessLevelsStateOpenModalFor || current is AccessLevelLoadErrorState,
      listener: (context, state) {
        // Note: BlocListener does not rebuild UI. It is meant for side effects such as dialogs, snackbars, and navigation.
        switch (state) {
          case AccessLevelsStateOpenModalFor(forItem: final accessLevel):
            debugPrint('>>> [_AccessLevelsScreenState.build] Reacting to AccessLevelsStateOpenModalFor access level w/ id=${accessLevel.id} ...');
            _openModal(item: accessLevel, readOnly: true, viewportSize: viewportSize);
            break;

          case AccessLevelLoadErrorState(:final errorMessage):
            debugPrint('>>> [_AccessLevelsScreenState.build] Reacting to AccessLevelLoadErrorState: $errorMessage');
            showErrorSnackbar(context, errorMessage);
            break;

          default:
            break;
        }
      },
      builder: (context, state) {
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

                      switch (state) {
                        AccessLevelLoadingState() => const Center(child: CircularProgressIndicator()),
                        AccessLevelLoadErrorState(:final errorMessage) => Center(child: Text('Error loading access levels: $errorMessage')),
                        AccessLevelLoadedState(items: final items) =>
                          items.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('No access levels yet.'),
                                      const SizedBox(height: 20),
                                      addButton,
                                    ],
                                  ),
                                )
                              : Center(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        _buildTable(vwSize, isDarkMode, items),
                                        const SizedBox(height: 20),
                                        addButton,
                                      ],
                                    ),
                                  ),
                                ),
                        _ => const SizedBox.shrink(),
                      },

                      for (final modal in modals)
                        DraggableModal(
                          key: ValueKey(modal.id),
                          data: modal,
                          viewport: vwSize,
                          onTap: () => _bringToFront(modal.id),
                          onClose: () => _closeModal(modal.id),
                          onDrag: (offset) => _updatePosition(modal.id, offset, vwSize),
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

  Widget _buildTable(Size viewportSize, bool isDarkMode, List<AccessLevel> items) {
    final logic = context.read<AccessLevelsLogic>();
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
        ...items.map((level) {
          return AccessLevelRow(
            level: level,
            nameText: limitChars(level.name, 32),
            descriptionText: level.description != null ? limitChars(level.description!, 40) : '',
            onView: () => _openModal(item: level, viewportSize: viewportSize, readOnly: true),
            onEdit: () => _openModal(item: level, viewportSize: viewportSize),
            onDelete: () => _delete(level, logic),
          );
        }),
      ],
    );
  }

  Future<void> _openModal({
    AccessLevel? item,
    Size? viewportSize,
    bool readOnly = false,
    Offset? initialOffset,
  }) async {
    final id = _nextModalId++;
    final isEdit = item != null;
    final logic = context.read<AccessLevelsLogic>();

    const modalSize = Size(340, 226);
    final offset =
        initialOffset ??
        (viewportSize != null
            ? Offset(
                (viewportSize.width - modalSize.width) / 2,
                (viewportSize.height - modalSize.height) / 2,
              )
            : const Offset(24, 80));

    _addModal(
      id: id,
      title: readOnly
          ? 'Access Level'
          : isEdit
          ? 'Edit Access Level'
          : 'New Access Level',
      offset: offset,
      size: modalSize,
      child: AccessLevelForm(
        item: item,
        readOnly: readOnly,
        onRequestEdit: readOnly && item != null
            ? () {
                final currentModal = modals.firstWhere((m) => m.id == id);
                final currentOffset = currentModal.offset;

                _closeModal(id);

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
          debugPrint('>>> [_AccessLevelsScreenState._openModal] Got from the form: $item');

          try {
            if (isEdit) {
              final response = await logic.upsert(UpsertType.update, item, emitAll: true);
              if (response.success && mounted) {
                _closeModal(id);
              } else if (!response.success) {
                if (!mounted) return;
                showErrorSnackbar(
                  context,
                  response.errorMessage ?? 'Failed to save access level: ${response.errorCode}',
                );
              }
              return;
            }

            final response = await logic.upsert(UpsertType.insert, item, emitAll: true);

            if (response.success && mounted) {
              _closeModal(id);
            } else if (!response.success) {
              if (!mounted) return;
              showErrorSnackbar(
                context,
                response.errorMessage ?? 'Failed to create access level: ${response.errorCode}',
              );
            }
          } catch (e) {
            debugPrint('Failed to save access level: $e.');
            if (!mounted) return;
            showErrorSnackbar(context, 'Failed to save access level: $e');
          }
        },
      ),
    );
  }

  Future<void> _delete(AccessLevel level, AccessLevelsLogic logic) async {
    final isDarkMode = context.read<ThemeCubit>().isDarkMode;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Access Level'),
        content: Text('Are you sure you want to delete "${level.name}"?'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.white,
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
        await logic.delete(level.id!, emitAll: true);
      } catch (e) {
        debugPrint('>>> [_AccessLevelsScreenState._delete] Error deleting access level: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error deleting access level: $e')));
        }
      }
    }
  }

  @override
  final List<ModalData> modals = []; // Just to satisfy the mixin requirement. The actual state is managed in _ModalHelpers.
}

mixin _ModalHelpers on State<AccessLevelsScreen> {
  List<ModalData> get modals;

  void _addModal({
    required int id,
    String? type,
    required String title,
    required Offset offset,
    required Size size,
    required AccessLevelForm child,
  }) {
    for (final modal in modals) {
      if ((modal.child as AccessLevelForm).item == child.item) {
        debugPrint('That (access level) modal is already open.');
        return;
      }
    }
    setState(() {
      modals.add(ModalData(id: id, type: type, title: title, offset: offset, size: size, child: child));
    });
  }

  void _bringToFront(int id) {
    setState(() {
      final int index = modals.indexWhere((m) => m.id == id);
      if (index == -1) return;
      final ModalData item = modals.removeAt(index);
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
      final int index = modals.indexWhere((m) => m.id == id);
      if (index == -1) return;

      final ModalData modal = modals[index];
      final double maxLeft = math.max(0, viewport.width - modal.size.width);
      final double maxTop = math.max(0, viewport.height - modal.size.height);

      modals[index] = modal.copyWith(offset: Offset(nextOffset.dx.clamp(0.0, maxLeft), nextOffset.dy.clamp(0.0, maxTop)));
    });
  }
}
