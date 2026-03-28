import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_client/shared.dart';
import 'package:akasha_ui/main.dart';
import 'package:akasha_ui/theming/colors.dart';
import 'package:akasha_ui/theming/sizes.dart';
import 'package:akasha_ui/theming/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntityTmplForm extends StatefulWidget {
  final EntityTmpl? item;
  final Future<void> Function(EntityTmpl)? onSave;
  final VoidCallback? onRequestEdit;
  final bool readOnly;

  const EntityTmplForm({super.key, this.item, this.onSave, this.onRequestEdit, this.readOnly = false});

  @override
  State<EntityTmplForm> createState() => _EntityTmplFormState();
}

class _EntityTmplFormState extends State<EntityTmplForm> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;

  List<AttributeTmpl> attributeTmpls = [];
  List<AttributeTmpl> includedAttributeTmpls = [];
  AttributeTmpl? selectedAttributeTmpl;

  bool _isSaving = false;
  bool get _isEdit => widget.item != null;
  bool get _isReadOnly => widget.readOnly;

  List<AttributeTmpl> get availableAttributeTmpls {
    final includedIds = includedAttributeTmpls.map((e) => e.id).whereType<UuidValue>().toSet();
    return attributeTmpls.where((attr) {
      final id = attr.id;
      if (id == null) return true;
      return !includedIds.contains(id);
    }).toList();
  }

  Future<void> _fetchAttributeTmpls() async {
    try {
      final entries = await client.attrTmpls.readAll();
      setState(() => attributeTmpls = entries);
    } catch (e) {
      debugPrint('Failed to fetch attribute templates: $e');
    }
  }

  void _onReorderAttributes(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }

      final item = includedAttributeTmpls.removeAt(oldIndex);
      includedAttributeTmpls.insert(newIndex, item);
    });
  }

  void _addSelectedAttributeTmpl() {
    final attr = selectedAttributeTmpl;
    if (attr == null) return;

    final alreadyIncluded = includedAttributeTmpls.any((e) => e.id == attr.id);
    if (alreadyIncluded) return;

    setState(() {
      includedAttributeTmpls.add(attr);
      selectedAttributeTmpl = null;
    });
  }

  void _removeIncludedAttributeTmpl(AttributeTmpl attr) {
    setState(() {
      includedAttributeTmpls.removeWhere((e) => e.id == attr.id);
    });
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.item?.name ?? '');
    descriptionController = TextEditingController(text: widget.item?.description ?? '');
    includedAttributeTmpls = [...?widget.item?.attributes?.map((link) => link.attributeTmpl)].whereType<AttributeTmpl>().toList();
    _fetchAttributeTmpls().then(
      (_) {
        if (widget.item?.attributes != null) {
          widget.item?.attributes?.forEach((entTmplAttr) {
            for (var attr in attributeTmpls) {
              if (attr.id == entTmplAttr.attributeTmplId) {
                includedAttributeTmpls.add(attr);
              }
            }
          });
        }
      },
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> onSave() async {
    if (_isReadOnly || widget.onSave == null) {
      return;
    }

    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSaving = true);

    try {
      int orderIdx = -1;
      final entityTmpl = EntityTmpl(
        id: widget.item?.id,
        name: nameController.text.trim(),
        description: descriptionController.text.trim().isEmpty ? null : descriptionController.text.trim(),
        attributes: includedAttributeTmpls
            .map(
              (attr) => EntityTmplAttribute(
                entityTmplId: widget.item?.id ?? zeroUuid,
                attributeTmplId: attr.id ?? zeroUuid,
                orderIdx: ++orderIdx,
              ),
            )
            .toList(),
      );

      await widget.onSave!(entityTmpl);
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.read<ThemeCubit>().isDarkMode;

    return DefaultTabController(
      length: 2,
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: nameController,
                  readOnly: _isReadOnly,
                  decoration: InputDecoration(
                    labelText: _isReadOnly ? 'Name' : 'Name *',
                    hintText: _isReadOnly ? null : 'Required',
                  ),
                  validator: _isReadOnly
                      ? null
                      : (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                  onChanged: _isReadOnly ? null : (_) => formKey.currentState?.validate(),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: descriptionController,
                  readOnly: _isReadOnly,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 1,
                  minLines: 1,
                ),
                const SizedBox(height: 20),

                const TabBar(
                  tabs: [
                    Tab(text: 'Attributes', height: tabHeight),
                    Tab(text: 'Links', height: tabHeight),
                  ],
                ),
                const SizedBox(height: 12),

                // Important: TabBarView needs bounded height here.
                SizedBox(
                  height: 250,
                  child: TabBarView(
                    children: [
                      _AttributesTab(
                        readOnly: _isReadOnly,
                        availableAttributeTmpls: availableAttributeTmpls,
                        includedAttributeTmpls: includedAttributeTmpls,
                        selectedAttributeTmpl: selectedAttributeTmpl,
                        onSelectedAttributeChanged: (value) => setState(() => selectedAttributeTmpl = value),
                        onAddAttribute: _addSelectedAttributeTmpl,
                        onRemoveAttribute: _removeIncludedAttributeTmpl,
                        onReorderAttributes: _onReorderAttributes,
                      ),
                      const _LinksTab(),
                    ],
                  ),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: _isReadOnly
                      ? IconButton(
                          onPressed: _isEdit ? widget.onRequestEdit : null,
                          color: isDarkMode ? darkFgColor : Theme.of(context).primaryColor,
                          icon: const Icon(Icons.edit),
                          tooltip: 'Edit',
                        )
                      : IconButton(
                          onPressed: _isSaving ? null : onSave,
                          color: isDarkMode ? darkFgColor : Theme.of(context).primaryColor,
                          icon: _isSaving
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Icon(Icons.save),
                          tooltip: _isEdit ? 'Update' : 'Add',
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AttributesTab extends StatelessWidget {
  const _AttributesTab({
    required this.readOnly,
    required this.availableAttributeTmpls,
    required this.includedAttributeTmpls,
    required this.selectedAttributeTmpl,
    required this.onSelectedAttributeChanged,
    required this.onAddAttribute,
    required this.onRemoveAttribute,
    required this.onReorderAttributes,
  });

  final bool readOnly;
  final List<AttributeTmpl> availableAttributeTmpls;
  final List<AttributeTmpl> includedAttributeTmpls;
  final AttributeTmpl? selectedAttributeTmpl;
  final ValueChanged<AttributeTmpl?> onSelectedAttributeChanged;
  final VoidCallback onAddAttribute;
  final ValueChanged<AttributeTmpl> onRemoveAttribute;
  final void Function(int oldIndex, int newIndex) onReorderAttributes;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.read<ThemeCubit>().isDarkMode;
    return Column(
      children: [
        Expanded(
          child: includedAttributeTmpls.isEmpty
              ? Center(
                  child: Text(
                    'No attribute templates included',
                    style: TextStyle(fontStyle: FontStyle.italic, color: isDarkMode ? darkFgFadedColor : lightFgFadedColor),
                  ),
                )
              : readOnly
              ? ListView.separated(
                  itemCount: includedAttributeTmpls.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 0),
                  itemBuilder: (context, index) {
                    final attr = includedAttributeTmpls[index];
                    return ListTile(
                      key: ValueKey(attr.id),
                      dense: true,
                      minTileHeight: 40,
                      minVerticalPadding: 4,
                      visualDensity: VisualDensity.compact,
                      contentPadding: EdgeInsets.zero,
                      title: Text(attr.name),
                      subtitle: Text(
                        attr.description == null || attr.description!.isEmpty ? '-' : attr.description!,
                        style: TextStyle(color: isDarkMode ? darkFgFadedColor : lightFgFadedColor),
                      ),
                    );
                  },
                )
              : ReorderableListView.builder(
                  buildDefaultDragHandles: false,
                  itemCount: includedAttributeTmpls.length,
                  onReorder: onReorderAttributes,
                  itemBuilder: (context, index) {
                    final attr = includedAttributeTmpls[index];
                    return ReorderableDragStartListener(
                      key: ValueKey(attr.id), // must be stable and unique
                      index: index,
                      child: ListTile(
                        mouseCursor: SystemMouseCursors.resizeUpDown,
                        dense: true,
                        minTileHeight: 40,
                        minVerticalPadding: 4,
                        visualDensity: VisualDensity.compact,
                        contentPadding: EdgeInsets.zero,
                        title: Text(attr.name),
                        subtitle: Text(
                          attr.description == null || attr.description!.isEmpty ? '-' : attr.description!,
                          style: TextStyle(color: isDarkMode ? darkFgFadedColor : lightFgFadedColor),
                        ),
                        trailing: IconButton(
                          onPressed: () => onRemoveAttribute(attr),
                          icon: const Icon(Icons.remove, size: 14),
                          visualDensity: VisualDensity.compact,
                          tooltip: 'Remove',
                        ),
                      ),
                    );
                  },
                ),
        ),
        if (!readOnly) ...[
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<AttributeTmpl>(
                  initialValue: selectedAttributeTmpl,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Add attribute template',
                    hintText: 'Pick one',
                  ),
                  items: availableAttributeTmpls
                      .map(
                        (attr) => DropdownMenuItem<AttributeTmpl>(
                          value: attr,
                          child: Text(attr.name),
                        ),
                      )
                      .toList(),
                  onChanged: availableAttributeTmpls.isEmpty ? null : onSelectedAttributeChanged,
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: selectedAttributeTmpl == null ? null : onAddAttribute,
                icon: const Icon(Icons.add),
                tooltip: 'Add attribute template',
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _LinksTab extends StatelessWidget {
  const _LinksTab();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Links tab content'),
    );
  }
}
