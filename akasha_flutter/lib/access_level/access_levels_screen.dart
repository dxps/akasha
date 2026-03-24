import 'dart:math' as math;

import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_flutter/access_level/access_level_form.dart';
import 'package:akasha_flutter/main.dart';
import 'package:akasha_flutter/utils/string.dart';
import 'package:akasha_flutter/widgets/feedback.dart';
import 'package:akasha_flutter/widgets/modal/draggable_modal.dart';
import 'package:akasha_flutter/widgets/modal/modal_content.dart';
import 'package:flutter/material.dart';

class AccessLevelsScreen extends StatefulWidget {
  const AccessLevelsScreen({super.key});

  @override
  State<AccessLevelsScreen> createState() => _AccessLevelsScreenState();
}

class _AccessLevelsScreenState extends State<AccessLevelsScreen> {
  bool isFetchingData = false;
  List<AccessLevel> accessLevels = [];
  int? _hoveredRowIndex;
  final List<ModalData> _modals = [];
  int _nextModalId = 1;

  Future<void> _getAccessLevels() async {
    setState(() => isFetchingData = true);
    final items = await client.accessLevel.readAll();
    debugPrint("[_AccessLevelsScreenState] Got ${items.length} access levels.");
    setState(() {
      accessLevels = items;
      isFetchingData = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getAccessLevels();
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
        title: const Text('Access Levels', style: TextStyle(fontSize: 16)),
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                final size = MediaQuery.of(context).size;
                _openModal(viewportSize: size);
              },
              icon: const Icon(Icons.add),
              label: const Text("Add"),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final Size vwSize = Size(constraints.maxWidth, constraints.maxHeight);
          return Stack(
            children: [
              isFetchingData
                  ? const Center(child: CircularProgressIndicator())
                  : accessLevels.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('No access levels yet.'),
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
                        scrollDirection: Axis.horizontal,
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
                            ...accessLevels.asMap().entries.map((entry) {
                              final index = entry.key;
                              final level = entry.value;
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
                                          child: Text(limitChars(level.name, 32)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 300,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          child: Text(level.description != null ? limitChars(level.description!, 40) : ''),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                        child: Builder(
                                          builder: (context) => IconButton(
                                            icon: Icon(Icons.more_vert, size: 15, color: isHovered ? Colors.grey[800] : Colors.grey[400]),
                                            onPressed: () async {
                                              final RenderBox button = context.findRenderObject() as RenderBox;
                                              final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;
                                              final RelativeRect position = RelativeRect.fromRect(
                                                Rect.fromPoints(
                                                  button.localToGlobal(Offset.zero, ancestor: overlay),
                                                  button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
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
                                                _openModal(item: level, viewportSize: vwSize);
                                              } else if (result == 'delete') {
                                                _deleteAccessLevel(level);
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

              for (final modal in _modals)
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

  Future<void> _openModal({AccessLevel? item, Size? viewportSize}) async {
    final id = _nextModalId++;
    final isEdit = item != null;
    debugPrint('Opening modal (id: $id) to ${isEdit ? 'edit' : 'create'} an access level ...');

    // Calculate centered position if viewport is provided
    Offset offset = const Offset(24, 80); // fallback position
    const modalSize = Size(340, 226);

    if (viewportSize != null) {
      offset = Offset(
        (viewportSize.width - modalSize.width) / 2,
        (viewportSize.height - modalSize.height) / 2,
      );
    }

    _addModal(
      id: id,
      title: isEdit ? 'Edit Access Level' : 'New Access Level',
      offset: offset,
      size: modalSize,
      child: AddAccessLevelForm(
        item: item,
        onSave: (item) async {
          debugPrint('>>> Got from form the item (AccessLevel): $item');

          try {
            if (isEdit) {
              final response = await client.accessLevel.update(item);

              if (response.success && mounted) {
                _closeModal(id);
                await _getAccessLevels();
              } else if (!response.success) {
                if (!mounted) return;
                showErrorSnackbar(context, response.errorMessage ?? 'Failed to save access level: ${response.errorCode}');
              }
              return;
            }

            final response = await client.accessLevel.create(item);

            if (response.success && mounted) {
              _closeModal(id);
              await _getAccessLevels();
            } else if (!response.success) {
              if (!mounted) return;
              showErrorSnackbar(context, response.errorMessage ?? 'Failed to create access level: ${response.errorCode}');
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

  Future<void> _deleteAccessLevel(AccessLevel level) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Access Level'),
        content: Text('Are you sure you want to delete "${level.name}"?'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(fontSize: 18),
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
        await client.accessLevel.delete(level.id!);
        await _getAccessLevels();
      } catch (e) {
        debugPrint('Error deleting access level: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting access level: $e')),
          );
        }
      }
    }
  }
}
