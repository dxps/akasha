import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_client/shared.dart';
import 'package:akasha_ui/main.dart';
import 'package:akasha_ui/theming/colors.dart';
import 'package:akasha_ui/theming/sizes.dart';
import 'package:akasha_ui/theming/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntityTmplForm extends StatefulWidget {
  //
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

  List<EntityTmpl> entityTmpls = [];
  List<EntityTmplLink> includedOutLinks = [];
  EntityTmpl? selectedEntityTmpl;
  UuidValue? selectedLinkId;
  late final TextEditingController linkNameCtrl;
  late final TextEditingController linkDescCtrl;

  bool _isSaving = false;
  bool get _isEdit => widget.item != null;
  bool get _isReadOnly => widget.readOnly;

  // ------------------------
  // attributes related logic

  Future<void> _fetchAttributeTmpls() async {
    try {
      final entries = await client.attrTmpls.readAll();
      setState(() => attributeTmpls = entries);
    } catch (e) {
      debugPrint('>>> Failed to fetch attribute templates: $e');
    }
  }

  List<AttributeTmpl> get availableAttributeTmpls {
    final includedIds = includedAttributeTmpls.map((e) => e.id).whereType<UuidValue>().toSet();
    return attributeTmpls.where((attr) {
      final id = attr.id;
      if (id == null) return true;
      return !includedIds.contains(id);
    }).toList();
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

  void _onReorderAttributes(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }

      final item = includedAttributeTmpls.removeAt(oldIndex);
      includedAttributeTmpls.insert(newIndex, item);
    });
  }

  // -----------------------
  // links related logic

  Future<void> _fetchEntityTmpls() async {
    try {
      final entries = await client.entityTmpl.readAll();
      setState(() => entityTmpls = entries);
    } catch (e) {
      debugPrint('>>> Failed to fetch entity templates: $e');
    }
  }

  void _addSelectedOutLink() {
    final linkId = selectedLinkId;
    if (linkId == null) return;

    final alreadyIncluded = widget.item?.outgoingLinks?.any((e) => e.id == linkId) ?? false;
    if (alreadyIncluded) return;

    setState(() {
      includedOutLinks.add(
        EntityTmplLink(
          id: linkId,
          targetId: linkId,
          name: linkNameCtrl.text.trim(),
          description: linkDescCtrl.text.trim(),
          orderIdx: 0,
          sourceId: widget.item?.id ?? zeroUuid,
        ),
      );
      selectedLinkId = null;
      linkNameCtrl.clear();
      linkDescCtrl.clear();
    });
  }

  void _removeIncludedOutgoingLink(UuidValue linkId) {
    setState(() {
      includedOutLinks.removeWhere((e) => e.id == linkId);
    });
  }

  void _onReorderOutgoingLinks(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = includedOutLinks.removeAt(oldIndex);
      includedOutLinks.insert(newIndex, item);
    });
  }

  // -------------------
  // lifecycle and build

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.item?.name ?? '');
    descriptionController = TextEditingController(text: widget.item?.description ?? '');

    linkNameCtrl = TextEditingController();
    linkDescCtrl = TextEditingController();

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
    _fetchEntityTmpls();
    includedOutLinks = [...?widget.item?.outgoingLinks];
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    linkNameCtrl.dispose();
    linkDescCtrl.dispose();
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
                      _LinksTab(
                        formKey: formKey,
                        readOnly: _isReadOnly,
                        outgoingLinks: includedOutLinks,
                        incomingLinks: widget.item?.incomingLinks ?? [],
                        entityTmpls: entityTmpls,
                        linkNameCtrl: linkNameCtrl,
                        linkDescCtrl: linkDescCtrl,
                        selectedLinkId: selectedLinkId,
                        onSelectedLinkChanged: (linkId) {
                          debugPrint('>>> Selected link changed: linkId=$linkId.');
                          setState(() => selectedLinkId = linkId);
                        },
                        onAddOutLink: _addSelectedOutLink,
                        onRemoveLink: _removeIncludedOutgoingLink,
                        onReorderLinks: _onReorderOutgoingLinks,
                      ),
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

// --------------
// Attributes tab
// --------------

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

// ---------
// Links tab
// ---------

class _LinksTab extends StatelessWidget {
  const _LinksTab({
    required this.formKey,
    required this.readOnly,
    required this.entityTmpls,
    required this.outgoingLinks,
    required this.incomingLinks,
    required this.selectedLinkId,
    required this.linkNameCtrl,
    required this.linkDescCtrl,
    required this.onSelectedLinkChanged,
    required this.onAddOutLink,
    required this.onRemoveLink,
    required this.onReorderLinks,
  });

  final GlobalKey<FormState> formKey;
  final bool readOnly;
  final List<EntityTmpl> entityTmpls;
  final List<EntityTmplLink> outgoingLinks;
  final List<EntityTmplLink> incomingLinks;
  final UuidValue? selectedLinkId;
  final TextEditingController linkNameCtrl;
  final TextEditingController linkDescCtrl;
  final ValueChanged<UuidValue?> onSelectedLinkChanged;
  final VoidCallback onAddOutLink;
  final ValueChanged<UuidValue> onRemoveLink;
  final void Function(int oldIndex, int newIndex) onReorderLinks;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.read<ThemeCubit>().isDarkMode;
    return Column(
      children: [
        Expanded(
          child: outgoingLinks.isEmpty && incomingLinks.isEmpty
              ? Center(
                  child: Text(
                    'No links',
                    style: TextStyle(fontStyle: FontStyle.italic, color: isDarkMode ? darkFgFadedColor : lightFgFadedColor),
                  ),
                )
              : readOnly
              ? ListView(
                  children: [
                    if (outgoingLinks.isNotEmpty) ...[
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Text('Outgoing Links', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      ...outgoingLinks.map(
                        (link) {
                          debugPrint('>>> out link: $link');
                          final title = link.name;
                          return ListTile(
                            title: Text(title),
                            subtitle: Text(
                              link.description ?? '',
                              style: TextStyle(fontStyle: FontStyle.italic, color: isDarkMode ? darkFgFadedColor : lightFgFadedColor),
                            ),
                          );
                        },
                      ),
                    ],
                    if (incomingLinks.isNotEmpty) ...[
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Text('Incoming Links', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      ...incomingLinks.map(
                        (link) {
                          final title = '${link.source?.name ?? 'Unknown'} -> ${link.name}';
                          return ListTile(
                            title: Text(title),
                            subtitle: Text(
                              link.description ?? '',
                              style: TextStyle(fontStyle: FontStyle.italic, color: isDarkMode ? darkFgFadedColor : lightFgFadedColor),
                            ),
                          );
                        },
                      ),
                    ],
                  ],
                )
              : ReorderableListView.builder(
                  buildDefaultDragHandles: false,
                  itemCount: outgoingLinks.length,
                  onReorder: onReorderLinks,
                  itemBuilder: (context, index) {
                    final link = outgoingLinks[index];
                    final linkLabel =
                        '${link.name} -> ${entityTmpls.firstWhere((ent) => ent.id == link.targetId, orElse: () => EntityTmpl(name: 'Unknown')).name}';
                    return ReorderableDragStartListener(
                      key: ValueKey(link.id), // must be stable and unique
                      index: index,
                      child: ListTile(
                        mouseCursor: SystemMouseCursors.resizeUpDown,
                        title: Text(linkLabel),
                        subtitle: Text(
                          link.description ?? '',
                          style: TextStyle(fontStyle: FontStyle.italic, color: isDarkMode ? darkFgFadedColor : lightFgFadedColor),
                        ),
                        trailing: IconButton(
                          onPressed: () => onRemoveLink(link.id ?? zeroUuid),
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
          TextFormField(
            controller: linkNameCtrl,
            readOnly: readOnly,
            decoration: InputDecoration(
              labelText: readOnly ? 'Name' : 'Name *',
              hintText: readOnly ? null : 'Required',
            ),
            validator: readOnly
                ? null
                : (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
            onChanged: readOnly ? null : (_) => linkNameCtrl.text.trim().isEmpty,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: linkDescCtrl,
            readOnly: readOnly,
            decoration: const InputDecoration(labelText: 'Description'),
            maxLines: 1,
            minLines: 1,
          ),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<UuidValue>(
                  initialValue: selectedLinkId,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Add target',
                    hintText: 'Pick an entity template',
                  ),
                  items: entityTmpls.map(
                    (ent) {
                      debugPrint('>>> Mapping entity tmpl w/ id=${ent.id} name=${ent.name} to dropdown item.');
                      return DropdownMenuItem<UuidValue>(
                        value: ent.id ?? zeroUuid,
                        child: Text(ent.name),
                      );
                    },
                  ).toList(),
                  onChanged: entityTmpls.isEmpty
                      ? null
                      : (targetId) {
                          if (targetId == null) return;
                          debugPrint('>>> Selected link changed: targetId=$targetId.');
                          onSelectedLinkChanged(targetId);
                        },
                ),
              ),
              IconButton(
                onPressed: selectedLinkId == null ? null : onAddOutLink,
                icon: const Icon(Icons.add, size: 16),
                tooltip: 'Add link',
              ),
            ],
          ),

          const SizedBox(height: 12),
        ],
      ],
    );
  }
}
