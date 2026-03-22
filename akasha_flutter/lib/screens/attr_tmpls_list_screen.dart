import 'dart:math' as math;

import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_flutter/main.dart';
import 'package:akasha_flutter/utils/string.dart';
import 'package:akasha_flutter/widgets/attr_tmpl_form.dart';
import 'package:akasha_flutter/widgets/modal/draggable_modal.dart';
import 'package:akasha_flutter/widgets/modal/modal_content.dart';
import 'package:flutter/material.dart';

class AttributeTmplsScreen extends StatefulWidget {
  const AttributeTmplsScreen({super.key});

  @override
  State<AttributeTmplsScreen> createState() => _AttributeTmplsScreenState();
}

class _AttributeTmplsScreenState extends State<AttributeTmplsScreen> {
  List<AttributeTmpl> attributeTmpls = [];
  int? _hoveredRowIndex;
  final List<ModalData> _modals = [];
  int _nextModalId = 1;

  Future<void> _getAttributeTmpls() async {
    final items = await client.attrTmpls.readAll();
    debugPrint("[_AttributeTmplsScreenStat] Got ${items.length} attributeTmpls.");
    setState(() => attributeTmpls = items);
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
    required Widget child,
  }) {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attribute Templates', style: TextStyle(fontSize: 16)),
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              //   onPressed: () => _showAttributeTemplateDialog(context),
              onPressed: () {
                final size = MediaQuery.of(context).size;
                _openModal(viewportSize: size);
              },
              icon: const Icon(Icons.add),
              label: const Text('Add'),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final Size vwSize = Size(constraints.maxWidth, constraints.maxHeight);
          return Stack(
            children: [
              attributeTmpls.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('No attribute templates yet.'),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              final size = MediaQuery.of(context).size;
                              _openModal(viewportSize: size);
                            },
                            child: const Text('Add'),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Header row
                            Container(
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 0.25, color: Colors.grey[300]!)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 2),
                                      child: Text('name', style: TextStyle(color: Colors.grey[500])),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 300,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 2),
                                      child: Text('description', style: TextStyle(color: Colors.grey[500])),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 2),
                                      child: Text('value type', style: TextStyle(color: Colors.grey[500])),
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
                            // Data rows
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
                                    color: isHovered ? Colors.white : Colors.transparent,
                                    border: Border(bottom: BorderSide(width: 0.25, color: Colors.grey[350]!)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
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
                                      SizedBox(
                                        width: 30,
                                        child: Builder(
                                          builder: (context) => IconButton(
                                            icon: Icon(Icons.more_vert, size: 15, color: isHovered ? Colors.grey[800] : Colors.grey[500]),
                                            onPressed: () async {
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

                                              final result = await showMenu<String>(
                                                context: context,

                                                items: [
                                                  PopupMenuItem(value: 'edit', height: 32, child: Text('Edit')),
                                                  PopupMenuItem(value: 'delete', height: 32, child: Text('Delete')),
                                                ],
                                                color: Colors.white,
                                                clipBehavior: Clip.antiAlias,
                                                menuPadding: const EdgeInsets.symmetric(vertical: 0),
                                                position: position,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                              );

                                              if (result == 'edit') {
                                                _openModal(item: tmpl, viewportSize: vwSize);
                                              } else if (result == 'delete') {
                                                _deleteAttributeTmpl(tmpl);
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ), // end-of-Center

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
  }

  Future<void> _openModal({AttributeTmpl? item, Size? viewportSize}) async {
    final id = _nextModalId++;
    final isEdit = item != null;
    debugPrint('Opening modal (id: $id) to ${isEdit ? 'edit' : 'create'} an attribute template ...');

    // Calculate centered position if viewport is provided
    Offset offset = const Offset(24, 80); // fallback position
    const modalSize = Size(340, 460);

    if (viewportSize != null) {
      offset = Offset(
        (viewportSize.width - modalSize.width) / 2,
        (viewportSize.height - modalSize.height) / 2,
      );
    }

    _addModal(
      id: id,
      title: isEdit ? 'Edit Attribute Template' : 'New Attribute Template',
      offset: offset,
      size: modalSize,
      child: AttributeTemplateForm(
        item: item,
        onSave: (tmpl) async {
          debugPrint('>>> Got from form (Attribute Template): $tmpl');

          try {
            if (isEdit) {
              final response = await client.attrTmpls.update(tmpl);

              if (response.success && mounted) {
                debugPrint(
                  '>>> Attribute template has been updated. Closing modal (id: $id) and refreshing attribute templates list...',
                );
                _closeModal(id);
                await _getAttributeTmpls();
              }

              return response;
            }

            final response = await client.attrTmpls.create(tmpl);

            if (response.success && mounted) {
              debugPrint(
                '>>> Attribute template has been created. Closing modal (id: $id) and refreshing attribute templates list...',
              );
              _closeModal(id);
              await _getAttributeTmpls();
            }

            return response;
          } catch (e) {
            debugPrint('>>> Save failed with exception: $e');

            return AttributeTmplApiResponse(
              success: false,
              errorCode: 'ATE-001',
              message: 'Unexpected error while saving attribute template.',
            );
          }
        },
      ),
    );
  }

  Future<void> _deleteAttributeTmpl(AttributeTmpl tmpl) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Attribute Template', style: TextStyle(fontSize: 18)),
        content: Text('Are you sure you want to delete "${tmpl.name}"?'),
        backgroundColor: Colors.white,
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
