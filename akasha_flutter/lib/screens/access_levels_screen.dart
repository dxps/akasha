import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_flutter/main.dart';
import 'package:akasha_flutter/utils/string.dart';
import 'package:akasha_flutter/widgets/access_level_form.dart';
import 'package:akasha_flutter/widgets/draggable_dialog.dart';
import 'package:flutter/material.dart';

class AccessLevelsScreen extends StatefulWidget {
  const AccessLevelsScreen({super.key});

  @override
  State<AccessLevelsScreen> createState() => _AccessLevelsScreenState();
}

class _AccessLevelsScreenState extends State<AccessLevelsScreen> {
  List<AccessLevel> accessLevels = [];
  int? _hoveredRowIndex;

  Future<void> _getAccessLevels() async {
    final items = await client.accessLevel.readAll();
    debugPrint("[_AccessLevelsScreenState] Got ${items.length} access levels.");
    setState(() => accessLevels = items);
  }

  @override
  void initState() {
    super.initState();
    _getAccessLevels();
  }

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
              onPressed: () => _showAccessLevelDialog(context),
              icon: const Icon(Icons.add),
              label: const Text('Add'),
            ),
          ),
        ],
      ),
      body: accessLevels.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No access levels yet.'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _showAccessLevelDialog(context),
                    child: const Text('Add'),
                  ),
                ],
              ),
            )
          : Center(
              child: SingleChildScrollView(
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
                              color: isHovered ? Colors.grey[100] : Colors.transparent,
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
                                          position: position,
                                          items: [
                                            PopupMenuItem(value: 'edit', child: Text('Edit')),
                                            PopupMenuItem(value: 'delete', child: Text('Delete')),
                                          ],
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                        );

                                        if (!mounted) return;

                                        if (result == 'edit') {
                                          _showAccessLevelDialog(this.context, item: level);
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
              ),
            ),
    );
  }

  Future<void> _showAccessLevelDialog(
    BuildContext context, {
    AccessLevel? item,
  }) async {
    final isEditing = item != null;
    await DraggableDialog.show(
      context,
      barrierDismissible: false,
      title: Text(isEditing ? 'Edit access level' : 'Add access level'),
      minWidth: 250,
      maxWidth: 400,
      child: AddAccessLevelForm(
        accessLevel: isEditing ? item : null,
        onSave: (level) async {
          if (isEditing) {
            await client.accessLevel.update(level);
          } else {
            await client.accessLevel.create(level);
          }
          await _getAccessLevels();
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
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
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
