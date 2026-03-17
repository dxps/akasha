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
                  child: DataTable(
                    dataRowMinHeight: 30,
                    dataRowMaxHeight: 30,
                    dividerThickness: 0.25,
                    headingRowHeight: 30,
                    columns: const [
                      DataColumn(label: Text('name')),
                      DataColumn(label: Text('description')),
                      DataColumn(label: Text('value type')),
                      DataColumn(label: Text('')),
                    ],
                    rows: attributeTmpls.asMap().entries.map((entry) {
                      final index = entry.key;
                      final tmpl = entry.value;
                      final isHovered = _hoveredRowIndex == index;

                      return DataRow(
                        color: WidgetStateProperty.all(
                          isHovered ? Colors.white : null,
                        ),
                        cells: [
                          DataCell(
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              onEnter: (_) => setState(() => _hoveredRowIndex = index),
                              onExit: (_) => setState(() => _hoveredRowIndex = null),
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                alignment: Alignment.centerLeft,
                                child: Text(limitChars(tmpl.name, 48)),
                              ),
                            ),
                          ),
                          DataCell(
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              onEnter: (_) => setState(() => _hoveredRowIndex = index),
                              onExit: (_) => setState(() => _hoveredRowIndex = null),
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                alignment: Alignment.centerLeft,
                                child: Text(tmpl.description != null ? limitChars(tmpl.description!, 50) : ''),
                              ),
                            ),
                          ),
                          DataCell(
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              onEnter: (_) => setState(() => _hoveredRowIndex = index),
                              onExit: (_) => setState(() => _hoveredRowIndex = null),
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                alignment: Alignment.centerLeft,
                                child: Text(tmpl.valueType),
                              ),
                            ),
                          ),
                          DataCell(
                            MouseRegion(
                              onEnter: (_) => setState(() => _hoveredRowIndex = index),
                              onExit: (_) => setState(() => _hoveredRowIndex = null),
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                alignment: Alignment.center,
                                child: PopupMenuButton<String>(
                                  onSelected: (value) {
                                    if (value == 'edit') {
                                      _showAttributeTemplateDialog(context, item: tmpl);
                                    } else if (value == 'delete') {
                                      _deleteAttributeTmpl(tmpl);
                                    }
                                  },
                                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                    const PopupMenuItem<String>(
                                      value: 'edit',
                                      child: Text('Edit'),
                                    ),
                                    const PopupMenuItem<String>(
                                      value: 'delete',
                                      child: Text('Delete'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
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
