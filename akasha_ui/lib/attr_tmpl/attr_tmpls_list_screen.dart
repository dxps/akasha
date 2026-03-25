import 'dart:math' as math;

import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_ui/attr_tmpl/attr_tmpl_form.dart';
import 'package:akasha_ui/main.dart';
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

class _AttributeTmplsScreenState extends State<AttributeTmplsScreen> {
  bool isFetchingData = false;
  List<AttributeTmpl> attributeTmpls = [];
  int? _hoveredRowIndex;
  final List<ModalData> _modals = [];
  int _nextModalId = 1;

  Future<void> _getAttributeTmpls() async {
    setState(() => isFetchingData = true);
    final items = await client.attrTmpls.readAll();
    debugPrint("Got ${items.length} attribute templates.");
    setState(() {
      attributeTmpls = items;
      isFetchingData = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getAttributeTmpls();
  }

  // -----------------------
  // Modals related methods.

  void _addModal({
    required int id,
    String? type,
    required String title,
    required Offset offset,
    required Size size,
    required AttributeTemplateForm child,
  }) {
    for (final modal in _modals) {
      if ((modal.child as AttributeTemplateForm).item == child.item) {
        debugPrint('That (attribute template) modal is already open.');
        return;
      }
    }
    setState(() {
      _modals.add(ModalData(id: id, type: type, title: title, offset: offset, size: size, child: child));
    });
  }

  void _bringToFront(int id) {
    setState(() {
      final int index = _modals.indexWhere((m) => m.id == id);
      if (index == -1) return;
      final ModalData item = _modals.removeAt(index);
      _modals.add(item);
    });
  }

  void _closeModal(int id) {
    setState(() {
      _modals.removeWhere((m) => m.id == id);
    });
  }

  void _updatePosition(int id, Offset nextOffset, Size viewport) {
    setState(() {
      final int index = _modals.indexWhere((m) => m.id == id);
      if (index == -1) return;

      final ModalData modal = _modals[index];
      final double maxLeft = math.max(0, viewport.width - modal.size.width);
      final double maxTop = math.max(0, viewport.height - modal.size.height);

      _modals[index] = modal.copyWith(offset: Offset(nextOffset.dx.clamp(0.0, maxLeft), nextOffset.dy.clamp(0.0, maxTop)));
    });
  }

  // ----------------------

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ThemeCubit, ThemeMode, bool>(
      selector: (themeMode) => themeMode == ThemeMode.dark,
      builder: (context, isDarkMode) {
        return Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              final Size vwSize = Size(constraints.maxWidth, constraints.maxHeight);
              final addButton = IconButton(
                onPressed: () {
                  final size = MediaQuery.of(context).size;
                  _openModal(viewportSize: size);
                },
                icon: const Icon(Icons.add),
                tooltip: 'Add Attribute Template',
              );
              return Stack(
                children: [
                  const TopHeader(),
                  isFetchingData
                      ? const Center(child: CircularProgressIndicator())
                      : attributeTmpls.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('No attribute templates yet.'),
                              const SizedBox(height: 20),
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

                  for (final modal in _modals) // Render the modals.
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
    final headerTextColor = isDarkMode ? primaryDarkFgColor.withAlpha(120) : Colors.grey.shade700;

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
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text(''),
                ),
              ),
            ],
          ),
        ),
        ...attributeTmpls.asMap().entries.map((entry) {
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
                border: Border(
                  bottom: BorderSide(width: 0.25, color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade200),
                ),
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
                            child: Text(
                              tmpl.description != null ? limitChars(tmpl.description!, 40) : '',
                            ),
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
                        icon: Icon(
                          Icons.more_vert,
                          size: 15,
                          color: isHovered ? Colors.grey[800] : Colors.grey[500],
                        ),
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

  Future<void> _openContextualMenu(BuildContext context, AttributeTmpl tmpl, Size? viewportSize) async {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(
          button.size.bottomRight(Offset.zero),
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );

    final isDarkMode = context.read<ThemeCubit>().isDarkMode;
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
      _openModal(item: tmpl, viewportSize: viewportSize);
    } else if (result == 'delete') {
      _deleteAttributeTmpl(tmpl);
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

    debugPrint(
      'Opening modal (id: $id) to ${readOnly
          ? 'view'
          : isEdit
          ? 'edit'
          : 'create'} an attribute template ...',
    );

    const modalSize = Size(340, 400);

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
          ? 'Attribute Template'
          : isEdit
          ? 'Edit Attribute Template'
          : 'New Attribute Template',
      offset: offset,
      size: modalSize,
      child: AttributeTemplateForm(
        item: item,
        readOnly: readOnly,
        onRequestEdit: readOnly && item != null
            ? () {
                final currentModal = _modals.firstWhere((m) => m.id == id);
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
          try {
            if (isEdit) {
              final response = await client.attrTmpls.update(item);

              if (response.success && mounted) {
                _closeModal(id);
                await _getAttributeTmpls();
              } else if (!response.success) {
                if (!mounted) return;
                showErrorSnackbar(
                  context,
                  response.errorMessage ?? 'Failed to update attribute template: ${response.errorCode}',
                );
              }
              return;
            }

            final response = await client.attrTmpls.create(item);

            if (response.success && mounted) {
              _closeModal(id);
              await _getAttributeTmpls();
            } else if (!response.success) {
              if (!mounted) return;
              showErrorSnackbar(
                context,
                response.errorMessage ?? 'Failed to create attribute template: ${response.errorCode}',
              );
            }
          } catch (e) {
            debugPrint('>>> Failed to save attribute template: $e');
            if (!mounted) return;
            showErrorSnackbar(context, 'Failed to save attribute template: $e');
          }
        },
      ),
    );
  }

  Future<void> _deleteAttributeTmpl(AttributeTmpl tmpl) async {
    final isDarkMode = context.read<ThemeCubit>().isDarkMode;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Attribute Template', style: TextStyle(fontSize: 18)),
        content: Text('Are you sure you want to delete "${tmpl.name}"?'),
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
        await client.attrTmpls.delete(tmpl.id!);
        await _getAttributeTmpls();
      } catch (e) {
        debugPrint('Error deleting attribute template: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting template: $e')),
          );
        }
      }
    }
  }
}
