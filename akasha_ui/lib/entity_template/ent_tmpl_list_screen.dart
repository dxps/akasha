import 'dart:math' as math;

import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_ui/entity_template/ent_tmpl_form.dart';
import 'package:akasha_ui/entity_template/ent_tmpl_row.dart';
import 'package:akasha_ui/main.dart';
import 'package:akasha_ui/theming/theme_cubit.dart';
import 'package:akasha_ui/utils/string.dart';
import 'package:akasha_ui/widgets/feedback.dart';
import 'package:akasha_ui/widgets/modal/draggable_modal.dart';
import 'package:akasha_ui/widgets/modal/modal_content.dart';
import 'package:akasha_ui/widgets/top_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntityTemplatesScreen extends StatefulWidget {
  const EntityTemplatesScreen({super.key});

  @override
  State<EntityTemplatesScreen> createState() => _EntityTemplatesScreenState();
}

class _EntityTemplatesScreenState extends State<EntityTemplatesScreen> with _ModalHelpers {
  bool isFetchingData = false;
  List<dynamic> entityTemplates = [];
  int _nextModalId = 1;

  Future<void> _getEntries() async {
    setState(() => isFetchingData = true);
    final items = await client.entityTmpl.readAll();
    debugPrint("[_EntityTemplatesScreenState] Got ${items.length} entity templates.");
    setState(() {
      entityTemplates = items;
      isFetchingData = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getEntries();
  }

  @override
  Widget build(BuildContext context) {
    final addButton = IconButton(
      icon: const Icon(Icons.add),
      iconSize: 20,
      tooltip: 'Add Entity Template',
      onPressed: () {
        final size = MediaQuery.of(context).size;
        _openModal(viewportSize: size);
      },
    );
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
                  isFetchingData
                      ? const Center(child: CircularProgressIndicator())
                      : entityTemplates.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('No entity templates yet.'),
                              const SizedBox(height: 16),
                              addButton,
                            ],
                          ),
                        )
                      : Center(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                _buildTable(vwSize, isDarkMode),
                                const SizedBox(height: 20),
                                addButton,
                              ],
                            ),
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
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildTable(Size? viewportSize, bool isDarkMode) {
    final size = viewportSize ?? MediaQuery.sizeOf(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 30,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 0.25,
                color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade200,
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
        ...entityTemplates.map((template) {
          return EntityTmplRow(
            item: template,
            nameText: limitChars(template.name, 32),
            descriptionText: template.description != null ? limitChars(template.description!, 40) : '',
            onView: () async {
              final item = await client.entityTmpl.read(template.id!);
              if (item != null) {
                debugPrint('>>> Got entity template for view: $item');
                _openModal(item: item, viewportSize: size, readOnly: true);
              } else {
                debugPrint('Failed to load entity template with id ${template.id} for view.');
                if (!mounted) return;
                showErrorSnackbar(context, 'Failed to load entity template details.');
              }
            },
            onEdit: () async {
              debugPrint('>>> Got entity template for edit: $template');
              final item = await client.entityTmpl.read(template.id!);
              if (item != null) {
                debugPrint('>>> Got entity template for edit: $item');
                _openModal(item: item, viewportSize: size);
              } else {
                debugPrint('Failed to load entity template with id ${template.id} for edit.');
                if (!mounted) return;
                showErrorSnackbar(context, 'Failed to load entity template details for edit.');
              }
            },
            onDelete: () => _deleteEntityTemplate(template),
          );
        }),
      ],
    );
  }

  Future<void> _openModal({
    EntityTmpl? item,
    Size? viewportSize,
    bool readOnly = false,
    Offset? initialOffset,
  }) async {
    final id = _nextModalId++;
    final isEdit = item != null;

    const modalSize = Size(380, 600);
    final offset =
        initialOffset ??
        (viewportSize != null
            ? Offset((viewportSize.width - modalSize.width) / 2, (viewportSize.height - modalSize.height) / 2)
            : const Offset(24, 80));

    _addModal(
      id: id,
      type: isEdit ? 'edit' : 'new',
      title: readOnly
          ? 'Entity Template'
          : isEdit
          ? 'Entity Template :: Edit'
          : 'Entity Template :: New',
      offset: offset,
      size: modalSize,
      child: EntityTmplForm(
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
          debugPrint('>>> Got from form the item (EntityTmpl): $item');

          try {
            if (isEdit) {
              final response = await client.entityTmpl.update(item);

              if (response.success && mounted) {
                _closeModal(id);
                await _getEntries();
              } else if (!response.success) {
                if (!mounted) return;
                showErrorSnackbar(context, response.errorMessage ?? 'Failed to save entity template: ${response.errorCode}');
              }
              return;
            }

            final response = await client.entityTmpl.create(item);

            if (response.success && mounted) {
              _closeModal(id);
              await _getEntries();
            } else if (!response.success) {
              if (!mounted) return;
              showErrorSnackbar(context, response.errorMessage ?? 'Failed to create entity template: ${response.errorCode}');
            }
          } catch (e) {
            debugPrint('Failed to save entity template: $e.');
            if (!mounted) return;
            showErrorSnackbar(context, 'Failed to save entity template: $e');
          }
        },
      ),
    );
  }

  Future<void> _deleteEntityTemplate(EntityTmpl template) async {
    final isDarkMode = context.read<ThemeCubit>().isDarkMode;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Entity Template'),
        content: Text('Are you sure you want to delete "${template.name}"?'),
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
        await client.entityTmpl.delete(template.id!);
        await _getEntries();
      } catch (e) {
        debugPrint('Error deleting entity template: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting entity template: $e')),
          );
        }
      }
    }
  }

  @override
  final List<ModalData> modals = []; // Just to satisfy the mixin requirement, actual state is managed in _ModalHelpers.
}

mixin _ModalHelpers on State<EntityTemplatesScreen> {
  List<ModalData> get modals;

  void _addModal({
    required int id,
    String? type,
    required String title,
    required Offset offset,
    required Size size,
    required EntityTmplForm child,
  }) {
    for (final modal in modals) {
      if ((modal.child as EntityTmplForm).item == child.item) {
        debugPrint('That (entity template) modal is already open.');
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
