import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_flutter/main.dart';
import 'package:akasha_flutter/utils/string.dart';
import 'package:akasha_flutter/widgets/attr_tmpl_form.dart';
import 'package:akasha_flutter/widgets/draggable_dialog.dart';
import 'package:flutter/material.dart';

class AttributeTmplsScreen extends StatefulWidget {
  const AttributeTmplsScreen({super.key});

  @override
  State<AttributeTmplsScreen> createState() => _AttributeTmplsScreenState();
}

class _AttributeTmplsScreenState extends State<AttributeTmplsScreen> {
  List<AttributeTmpl> attributeTmpls = [];
  int? _hoveredRowIndex;

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
              onPressed: () => _showAttributeTemplateDialog(context),
              icon: const Icon(Icons.add),
              label: const Text('Add'),
            ),
          ),
        ],
      ),
      body: attributeTmpls.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No attribute templates yet.'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _showAttributeTemplateDialog(context),
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
                                          position: position,
                                          items: [
                                            PopupMenuItem(value: 'edit', child: Text('Edit')),
                                            PopupMenuItem(value: 'delete', child: Text('Delete')),
                                          ],
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                        );

                                        if (!mounted) return;

                                        if (result == 'edit') {
                                          _showAttributeTemplateDialog(this.context, item: tmpl);
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
              ),
            ),
    );
  }

  Future<void> _showAttributeTemplateDialog(
    BuildContext context, {
    AttributeTmpl? item,
  }) async {
    final isEditing = item != null;
    await DraggableDialog.show(
      context,
      barrierDismissible: false,
      title: Text(isEditing ? 'Edit attribute template' : 'Add attribute template'),
      minWidth: 250,
      maxWidth: 400,
      child: AddAttributeTemplateForm(
        attributeTmpl: isEditing ? item : null,
        onSave: (tmpl) async {
          if (isEditing) {
            await client.attrTmpls.update(tmpl);
          } else {
            await client.attrTmpls.create(tmpl);
          }
          await _getAttributeTmpls();
        },
      ),
    );
  }

  Future<void> _deleteAttributeTmpl(AttributeTmpl tmpl) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Attribute Template'),
        content: Text('Are you sure you want to delete "${tmpl.name}"?'),
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
