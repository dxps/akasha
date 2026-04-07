import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_client/shared/zero_uuid.dart';
import 'package:akasha_ui/attribute_template/attr_tmpls_logic.dart';
import 'package:akasha_ui/entity_template/ent_tmpls_logic.dart';
import 'package:akasha_ui/theming/colors.dart';
import 'package:akasha_ui/theming/sizes.dart';
import 'package:akasha_ui/theming/theme_cubit.dart';
import 'package:akasha_ui/widgets/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ent_tmpl_form_attrs_tab.dart';
part 'ent_tmpl_form_links_tab.dart';

class EntityTmplForm extends StatefulWidget {
  //
  final EntityTmpl? item;
  final Future<void> Function(EntityTmpl)? onSave;
  final void Function(Map<String, Object?> options)? onRequestEdit;
  final bool readOnly;
  final Map<String, Object?> options;
  final List<EntityTmpl> entityTmpls;

  const EntityTmplForm({
    super.key,
    this.item,
    this.onSave,
    this.onRequestEdit,
    this.readOnly = false,
    required this.entityTmpls,
    this.options = const {},
  });

  @override
  State<EntityTmplForm> createState() => _EntityTmplFormState();
}

class _EntityTmplFormState extends State<EntityTmplForm> {
  final formKey = GlobalKey<FormState>();
  final nameFieldKey = GlobalKey<FormFieldState<String>>();
  late final TextEditingController nameCtrl;
  late final TextEditingController descriptionController;

  List<AttributeTmpl> includedAttributeTmpls = [];
  AttributeTmpl? selectedAttributeTmpl;

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

  //   Future<void> _fetchAttributeTmpls() async {
  // try {
  //   final entries = await client.attrTmpls.readAll();
  //   setState(() => attributeTmpls = entries);
  // } catch (e) {
  //   debugPrint('>>> Failed to fetch attribute templates: $e');
  // }
  //   }

  List<AttributeTmpl> get availableAttributeTmpls {
    final includedIds = includedAttributeTmpls.map((e) => e.id).whereType<UuidValue>().toSet();
    final attrTmpls = context.read<AttributeTmplsLogic>().cachedItems;
    return attrTmpls.where((attr) {
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

  // --------------------------------------
  // lifecycle (init and dispose) and build
  // --------------------------------------

  @override
  void initState() {
    super.initState();
    final attrTmplsLogic = context.read<AttributeTmplsLogic>();
    attrTmplsLogic.loadAll();

    nameCtrl = TextEditingController(text: widget.item?.name ?? '');
    descriptionController = TextEditingController(text: widget.item?.description ?? '');

    linkNameCtrl = TextEditingController();
    linkDescCtrl = TextEditingController();

    includedAttributeTmpls = [...?widget.item?.attributes?.map((link) => link.attributeTmpl)].whereType<AttributeTmpl>().toList();
    final attrTmpls = attrTmplsLogic.cachedItems;
    if (widget.item?.attributes != null) {
      widget.item?.attributes?.forEach((entTmplAttr) {
        for (var attr in attrTmpls) {
          if (attr.id == entTmplAttr.attributeTmplId) {
            includedAttributeTmpls.add(attr);
          }
        }
      });
    }
    includedOutLinks = [...?widget.item?.outgoingLinks];
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    descriptionController.dispose();
    linkNameCtrl.dispose();
    linkDescCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.read<ThemeCubit>().isDarkMode;

    return DefaultTabController(
      length: 2,
      initialIndex: (widget.options['activeTabIdx'] as int?) ?? 0,
      child: Form(
        key: formKey,
        child: Builder(
          builder: (tabContext) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      key: nameFieldKey,
                      controller: nameCtrl,
                      readOnly: _isReadOnly,
                      decoration: InputDecoration(
                        labelText: _isReadOnly ? 'Name' : 'Name *',
                        hintText: _isReadOnly ? null : 'Required',
                      ),
                      validator: _isReadOnly ? null : (value) => (value == null || value.trim().isEmpty) ? 'Name is required' : null,
                      onChanged: _isReadOnly ? null : (_) => nameFieldKey.currentState?.validate(),
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

                    SizedBox(
                      height: 330,
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
                            readOnly: _isReadOnly,
                            outgoingLinks: includedOutLinks,
                            incomingLinks: widget.item?.incomingLinks ?? [],
                            entityTmpls: widget.entityTmpls,
                            linkNameCtrl: linkNameCtrl,
                            linkDescCtrl: linkDescCtrl,
                            selectedLinkId: selectedLinkId,
                            onSelectedLinkChanged: (linkId) => setState(() => selectedLinkId = linkId),
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
                              onPressed: _isEdit
                                  ? () {
                                      final activeTabIndex = DefaultTabController.of(tabContext).index;
                                      widget.onRequestEdit?.call({"activeTabIdx": activeTabIndex});
                                    }
                                  : null,
                              color: isDarkMode ? darkFgFadedColor : lightFgFadedColor,
                              icon: const Icon(Icons.edit, size: 22),
                              tooltip: 'Edit',
                            )
                          : IconButton(
                              onPressed: _isSaving ? null : onSave,
                              color: isDarkMode ? darkFgColor : lightFgColor,
                              icon: _isSaving
                                  ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                                  : const Icon(Icons.save, size: 22),
                              tooltip: _isEdit ? 'Update' : 'Add',
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> onSave() async {
    if (_isReadOnly || widget.onSave == null) {
      return;
    }

    // Note: We don't do the whole form validation, since in the Links tab, the name is empty most of the time.
    // if (!formKey.currentState!.validate()) { return; }

    if (nameCtrl.text.trim().isEmpty) {
      nameFieldKey.currentState?.validate();
      return;
    }
    if (includedAttributeTmpls.isEmpty) {
      showErrorSnackbar(context, 'An entity template must have at least one attribute template.');
      return;
    }

    setState(() => _isSaving = true);

    try {
      int orderIdx = -1;
      final entityTmpl = EntityTmpl(
        id: widget.item?.id,
        name: nameCtrl.text.trim(),
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
        outgoingLinks: includedOutLinks
            .map(
              (link) => EntityTmplLink(
                id: link.id,
                sourceId: widget.item?.id ?? zeroUuid,
                targetId: link.targetId,
                name: link.name,
                description: link.description,
                orderIdx: includedOutLinks.indexOf(link),
              ),
            )
            .toList(),
      );
      debugPrint('>>> [_EntityTmplForm.onSave] Prepared entity template for saving: $entityTmpl');
      await widget.onSave!(entityTmpl);
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }
}
