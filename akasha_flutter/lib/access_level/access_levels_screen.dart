import 'dart:math' as math;

import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_flutter/access_level/access_level_form.dart';
import 'package:akasha_flutter/access_level/access_level_row.dart';
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
                        child: _buildTable(vwSize),
                      ),
                    ),

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

  Widget _buildTable(Size? viewportSize) {
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
                color: Colors.grey[300]!,
              ),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13, vertical: 2),
                  child: Text(
                    'name',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(
                width: 300,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13, vertical: 2),
                  child: Text(
                    'description',
                    style: TextStyle(color: Colors.grey),
                  ),
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
        ...accessLevels.map((level) {
          return AccessLevelRow(
            level: level,
            nameText: limitChars(level.name, 32),
            descriptionText: level.description != null ? limitChars(level.description!, 40) : '',
            onView: () => _openModal(
              item: level,
              viewportSize: size,
              readOnly: true,
            ),
            onEdit: () => _openModal(
              item: level,
              viewportSize: size,
            ),
            onDelete: () => _deleteAccessLevel(level),
          );
        }),
      ],
    );
  }

  Future<void> _openModal({
    AccessLevel? item,
    Size? viewportSize,
    bool readOnly = false,
  }) async {
    final id = _nextModalId++;
    final isEdit = item != null;

    debugPrint(
      'Opening modal (id: $id) to ${readOnly
          ? 'view'
          : isEdit
          ? 'edit'
          : 'create'} an access level ...',
    );

    Offset offset = const Offset(24, 80);
    const modalSize = Size(340, 226);

    if (viewportSize != null) {
      offset = Offset(
        (viewportSize.width - modalSize.width) / 2,
        (viewportSize.height - modalSize.height) / 2,
      );
    }

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
                _closeModal(id);

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (!mounted) return;
                  _openModal(
                    item: item,
                    viewportSize: viewportSize,
                    readOnly: false,
                  );
                });
              }
            : null,
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
                showErrorSnackbar(
                  context,
                  response.errorMessage ?? 'Failed to save access level: ${response.errorCode}',
                );
              }
              return;
            }

            final response = await client.accessLevel.create(item);

            if (response.success && mounted) {
              _closeModal(id);
              await _getAccessLevels();
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
