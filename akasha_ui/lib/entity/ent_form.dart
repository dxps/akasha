import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_client/shared/zero_uuid.dart';
import 'package:akasha_ui/access_level/access_level_logic.dart';
import 'package:akasha_ui/attribute_template/attr_tmpls_logic.dart';
import 'package:akasha_ui/entity/ents_cubit.dart';
import 'package:akasha_ui/entity/ents_state.dart';
import 'package:akasha_ui/theming/colors.dart';
import 'package:akasha_ui/theming/sizes.dart';
import 'package:akasha_ui/theming/theme_cubit.dart';
import 'package:akasha_ui/utils/date_time.dart';
import 'package:akasha_ui/widgets/datetime_pickers.dart';
import 'package:akasha_ui/widgets/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntityForm extends StatefulWidget {
  const EntityForm({
    super.key,
    this.item,
    this.initialTemplate,
    this.onSave,
    this.onRequestEdit,
    this.onRequestView,
    this.readOnly = false,
  });

  final Entity? item;
  final EntityTmpl? initialTemplate;
  final Future<void> Function(Entity item)? onSave;
  final VoidCallback? onRequestEdit;
  final VoidCallback? onRequestView;
  final bool readOnly;

  @override
  State<EntityForm> createState() => _EntityFormState();
}

class _EntityFormState extends State<EntityForm> {
  final formKey = GlobalKey<FormState>();
  final List<_EntityAttributeDraft> attributeDrafts = [];
  final List<EntityLink> outgoingLinkDrafts = [];
  late final TextEditingController linkNameController;
  late final TextEditingController linkDescriptionController;
  int _nextDraftId = 1;
  int? _selectedListingDraftId;
  int _selectedScratchTabIndex = 0;
  UuidValue? _selectedLinkTargetId;
  bool _isSaving = false;

  bool get _isEdit => widget.item != null;
  bool get _isReadOnly => widget.readOnly;
  bool get _isScratchCreation => widget.item == null && widget.initialTemplate == null;

  List<AccessLevel> get accessLevels => context.read<AccessLevelsLogic>().cachedItems;
  List<AttributeTmpl> get attributeTemplates => context.read<AttributeTmplsLogic>().cachedItems;
  List<Entity> get linkTargetEntities => context.read<EntitiesCubit>().cachedItems.where((entity) => entity.id != widget.item?.id).toList();
  List<EntityLink> get initialOutgoingLinks {
    if (widget.item != null) {
      return [...?widget.item!.outgoingLinks];
    }
    return _mapTemplateLinksToEntityLinks(widget.initialTemplate?.outgoingLinks, isOutgoing: true);
  }

  List<EntityLink> get initialIncomingLinks {
    if (widget.item != null) {
      return [...?widget.item!.incomingLinks];
    }
    return _mapTemplateLinksToEntityLinks(widget.initialTemplate?.incomingLinks, isOutgoing: false);
  }

  _EntityAttributeDraft? get _selectedListingDraft {
    if (_selectedListingDraftId == null) return null;
    return attributeDrafts.where((draft) => draft.localId == _selectedListingDraftId).firstOrNull;
  }

  @override
  void initState() {
    super.initState();
    linkNameController = TextEditingController();
    linkDescriptionController = TextEditingController();
    if (_isScratchCreation) {
      context.read<AttributeTmplsLogic>().loadAll();
    }
    if (_isScratchCreation || _isEdit) {
      context.read<EntitiesCubit>().fetchAll();
    }
    attributeDrafts.addAll(_buildInitialDrafts());
    outgoingLinkDrafts.addAll(initialOutgoingLinks);
    if (attributeDrafts.isNotEmpty) {
      _nextDraftId = attributeDrafts.map((draft) => draft.localId).reduce((a, b) => a > b ? a : b) + 1;
    }
    _selectedListingDraftId = _inferInitialListingDraftId();
  }

  List<_EntityAttributeDraft> _buildInitialDrafts() {
    if (widget.item != null) {
      return _buildDraftsFromEntity(widget.item!);
    }
    if (widget.initialTemplate != null) {
      return _buildDraftsFromTemplate(widget.initialTemplate!);
    }
    return [];
  }

  List<_EntityAttributeDraft> _buildDraftsFromEntity(Entity item) {
    final textAttrs = [...item.textAttributes];
    final numberAttrs = [...item.numberAttributes];
    final boolAttrs = [...item.boolAttributes];
    final dateAttrs = [...item.dateAttributes];
    final dateTimeAttrs = [...item.dateTimeAttributes];
    final drafts = <_EntityAttributeDraft>[];

    final orderedTypes = [...item.attributesOrder]..sort((a, b) => a.$1.compareTo(b.$1));
    for (final (_, type) in orderedTypes) {
      switch (type) {
        case 'text':
          if (textAttrs.isNotEmpty) {
            drafts.add(_EntityAttributeDraft.fromText(localId: drafts.length + 1, item: textAttrs.removeAt(0)));
          }
          break;
        case 'number':
          if (numberAttrs.isNotEmpty) {
            drafts.add(_EntityAttributeDraft.fromNumber(localId: drafts.length + 1, item: numberAttrs.removeAt(0)));
          }
          break;
        case 'boolean':
          if (boolAttrs.isNotEmpty) {
            drafts.add(_EntityAttributeDraft.fromBool(localId: drafts.length + 1, item: boolAttrs.removeAt(0)));
          }
          break;
        case 'date':
          if (dateAttrs.isNotEmpty) {
            drafts.add(_EntityAttributeDraft.fromDate(localId: drafts.length + 1, item: dateAttrs.removeAt(0)));
          }
          break;
        case 'dateTime':
          if (dateTimeAttrs.isNotEmpty) {
            drafts.add(_EntityAttributeDraft.fromDateTime(localId: drafts.length + 1, item: dateTimeAttrs.removeAt(0)));
          }
          break;
      }
    }

    for (final attr in textAttrs) {
      drafts.add(_EntityAttributeDraft.fromText(localId: drafts.length + 1, item: attr));
    }
    for (final attr in numberAttrs) {
      drafts.add(_EntityAttributeDraft.fromNumber(localId: drafts.length + 1, item: attr));
    }
    for (final attr in boolAttrs) {
      drafts.add(_EntityAttributeDraft.fromBool(localId: drafts.length + 1, item: attr));
    }
    for (final attr in dateAttrs) {
      drafts.add(_EntityAttributeDraft.fromDate(localId: drafts.length + 1, item: attr));
    }
    for (final attr in dateTimeAttrs) {
      drafts.add(_EntityAttributeDraft.fromDateTime(localId: drafts.length + 1, item: attr));
    }

    return drafts;
  }

  List<_EntityAttributeDraft> _buildDraftsFromTemplate(EntityTmpl template) {
    final items = [...?template.attributes]..sort((a, b) => a.orderIdx.compareTo(b.orderIdx));
    return [
      for (var i = 0; i < items.length; i++)
        _EntityAttributeDraft.fromTemplate(
          localId: i + 1,
          item: items[i].attributeTmpl,
          fallbackAccessLevelId: accessLevels.firstOrNull?.id,
        ),
    ].whereType<_EntityAttributeDraft>().toList();
  }

  int? _inferInitialListingDraftId() {
    if (attributeDrafts.isEmpty) return null;
    if (widget.item != null) {
      final listingName = widget.item!.listingAttribute.$1;
      final listingValue = widget.item!.listingAttribute.$2;
      final exact = attributeDrafts
          .where((draft) => draft.nameController.text.trim() == listingName && _displayValueFor(draft) == listingValue)
          .firstOrNull;
      if (exact != null) return exact.localId;
      final byName = attributeDrafts.where((draft) => draft.nameController.text.trim() == listingName).firstOrNull;
      if (byName != null) return byName.localId;
    }
    return attributeDrafts.first.localId;
  }

  @override
  void dispose() {
    for (final draft in attributeDrafts) {
      draft.dispose();
    }
    linkNameController.dispose();
    linkDescriptionController.dispose();
    super.dispose();
  }

  void _addAttribute() {
    setState(() {
      final draft = _EntityAttributeDraft.empty(
        localId: _nextDraftId++,
        accessLevelId: accessLevels.firstOrNull?.id,
      );
      attributeDrafts.add(draft);
      _selectedListingDraftId ??= draft.localId;
    });
  }

  Future<void> _addAttributeWithChoice() async {
    final isDarkMode = context.read<ThemeCubit>().isDarkMode;
    final choice = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Attribute'),
        content: const Text('Choose how you want to add the attribute.'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.white,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'scratch'),
            child: const Text('From scratch'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'template'),
            child: const Text('Use template'),
          ),
        ],
      ),
    );

    if (!mounted || choice == null) return;
    if (choice == 'scratch') {
      _addAttribute();
      return;
    }

    final template = await _selectAttributeTemplate();
    if (!mounted || template == null) return;
    _addAttributeFromTemplate(template);
  }

  Future<AttributeTmpl?> _selectAttributeTemplate() async {
    await context.read<AttributeTmplsLogic>().loadAll();
    if (!mounted) return null;

    final templates = attributeTemplates;
    if (templates.isEmpty) {
      showErrorSnackbar(context, 'There are no attribute templates available.');
      return null;
    }

    final isDarkMode = context.read<ThemeCubit>().isDarkMode;
    return showDialog<AttributeTmpl>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Choose Attribute Template'),
        backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.white,
        children: [
          for (final template in templates)
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, template),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(template.name),
                  Text(
                    '${ValueType.fromJson(template.valueType).label} · ${template.accessLevel?.name ?? 'Access level ${template.accessLevelId}'}',
                    style: TextStyle(
                      color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                      fontSize: 12,
                    ),
                  ),
                  if ((template.description ?? '').isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        template.description!,
                        style: TextStyle(
                          color: isDarkMode ? Colors.grey.shade500 : Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void _addAttributeFromTemplate(AttributeTmpl template) {
    setState(() {
      final draft = _EntityAttributeDraft.fromTemplate(
        localId: _nextDraftId++,
        item: template,
        fallbackAccessLevelId: accessLevels.firstOrNull?.id,
      );
      attributeDrafts.add(draft);
      _selectedListingDraftId ??= draft.localId;
    });
  }

  void _removeAttribute(int localId) {
    setState(() {
      final index = attributeDrafts.indexWhere((draft) => draft.localId == localId);
      if (index == -1) return;
      final draft = attributeDrafts.removeAt(index);
      draft.dispose();
      if (_selectedListingDraftId == localId) {
        _selectedListingDraftId = attributeDrafts.firstOrNull?.localId;
      }
    });
  }

  void _onReorderAttributes(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final draft = attributeDrafts.removeAt(oldIndex);
      attributeDrafts.insert(newIndex, draft);
    });
  }

  void _addSelectedOutgoingLink() {
    final targetId = _selectedLinkTargetId;
    if (targetId == null) return;

    final name = linkNameController.text.trim();
    if (name.isEmpty) {
      showErrorSnackbar(context, 'Link name is required.');
      return;
    }

    setState(() {
      outgoingLinkDrafts.add(
        EntityLink(
          name: name,
          description: linkDescriptionController.text.trim().isEmpty ? null : linkDescriptionController.text.trim(),
          orderIdx: outgoingLinkDrafts.length,
          sourceId: widget.item?.id ?? zeroUuid,
          targetId: targetId,
        ),
      );
      _selectedLinkTargetId = null;
      linkNameController.clear();
      linkDescriptionController.clear();
    });
  }

  void _removeOutgoingLinkAt(int index) {
    setState(() {
      outgoingLinkDrafts.removeAt(index);
    });
  }

  void _onReorderOutgoingLinks(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = outgoingLinkDrafts.removeAt(oldIndex);
      outgoingLinkDrafts.insert(newIndex, item);
    });
  }

  Future<void> _pickDate(_EntityAttributeDraft draft) async {
    if (_isReadOnly) return;
    final picked = await DateTimePickers.pickDate(context);
    if (!mounted || picked == null) return;
    setState(() {
      draft.valueController.text = formatDateYmd(picked);
    });
  }

  Future<void> _pickDateTime(_EntityAttributeDraft draft) async {
    if (_isReadOnly) return;
    final picked = await DateTimePickers.pickDateTime(context);
    if (!mounted || picked == null) return;
    setState(() {
      draft.valueController.text = picked.toIso8601String();
    });
  }

  String _displayValueFor(_EntityAttributeDraft draft) {
    return switch (draft.valueType) {
      ValueType.boolean => draft.boolValue.toString(),
      ValueType.date => draft.valueController.text.trim(),
      ValueType.datetime => draft.valueController.text.trim(),
      ValueType.number => draft.valueController.text.trim(),
      ValueType.text => draft.valueController.text,
    };
  }

  List<EntityLink> _mapTemplateLinksToEntityLinks(
    List<EntityTmplLink>? links, {
    required bool isOutgoing,
  }) {
    return [
      for (final link in links ?? <EntityTmplLink>[])
        EntityLink(
          id: link.id,
          name: link.name,
          description: link.description,
          orderIdx: link.orderIdx,
          sourceId: isOutgoing ? zeroUuid : link.sourceId,
          source: null,
          targetId: isOutgoing ? link.targetId : zeroUuid,
          target: null,
        ),
    ];
  }

  String? _validateDraft(_EntityAttributeDraft draft) {
    if (draft.nameController.text.trim().isEmpty) {
      return 'Each attribute needs a name.';
    }
    if (draft.accessLevelId == null) {
      return 'Each attribute needs an access level.';
    }

    final rawValue = draft.valueController.text.trim();
    switch (draft.valueType) {
      case ValueType.text:
        return null;
      case ValueType.number:
        return double.tryParse(rawValue) == null ? 'Number attributes need a valid number value.' : null;
      case ValueType.boolean:
        return null;
      case ValueType.date:
        return DateTime.tryParse(rawValue) == null ? 'Date attributes need a valid date.' : null;
      case ValueType.datetime:
        return DateTime.tryParse(rawValue) == null ? 'DateTime attributes need a valid ISO date-time.' : null;
    }
  }

  Future<void> onSave() async {
    if (_isReadOnly || widget.onSave == null) return;
    if (!(formKey.currentState?.validate() ?? false)) return;

    if (attributeDrafts.isEmpty) {
      showErrorSnackbar(context, 'An entity must have at least one attribute.');
      return;
    }

    final listingDraft = _selectedListingDraft;
    if (listingDraft == null) {
      showErrorSnackbar(context, 'Select which included attribute should be used for the listing.');
      return;
    }

    for (final draft in attributeDrafts) {
      final error = _validateDraft(draft);
      if (error != null) {
        showErrorSnackbar(context, error);
        return;
      }
    }

    setState(() => _isSaving = true);

    try {
      final textAttributes = <TextAttribute>[];
      final numberAttributes = <NumberAttribute>[];
      final boolAttributes = <BoolAttribute>[];
      final dateAttributes = <DateAttribute>[];
      final dateTimeAttributes = <DateTimeAttribute>[];

      for (final draft in attributeDrafts) {
        final accessLevel = accessLevels.where((item) => item.id == draft.accessLevelId).firstOrNull;

        switch (draft.valueType) {
          case ValueType.text:
            textAttributes.add(
              TextAttribute(
                id: draft.id,
                name: draft.nameController.text.trim(),
                description: null,
                valueType: ValueType.text,
                value: draft.valueController.text,
                accessLevelId: draft.accessLevelId!,
                accessLevel: accessLevel,
              ),
            );
            break;
          case ValueType.number:
            numberAttributes.add(
              NumberAttribute(
                id: draft.id,
                name: draft.nameController.text.trim(),
                description: null,
                valueType: ValueType.number,
                value: double.parse(draft.valueController.text.trim()),
                accessLevelId: draft.accessLevelId!,
                accessLevel: accessLevel,
              ),
            );
            break;
          case ValueType.boolean:
            boolAttributes.add(
              BoolAttribute(
                id: draft.id,
                name: draft.nameController.text.trim(),
                description: null,
                valueType: ValueType.boolean,
                value: draft.boolValue,
                accessLevelId: draft.accessLevelId!,
                accessLevel: accessLevel,
              ),
            );
            break;
          case ValueType.date:
            dateAttributes.add(
              DateAttribute(
                id: draft.id,
                name: draft.nameController.text.trim(),
                description: null,
                valueType: ValueType.date,
                value: DateTime.parse(draft.valueController.text.trim()),
                accessLevelId: draft.accessLevelId!,
                accessLevel: accessLevel,
              ),
            );
            break;
          case ValueType.datetime:
            dateTimeAttributes.add(
              DateTimeAttribute(
                id: draft.id,
                name: draft.nameController.text.trim(),
                description: null,
                valueType: ValueType.datetime,
                value: DateTime.parse(draft.valueController.text.trim()),
                accessLevelId: draft.accessLevelId!,
                accessLevel: accessLevel,
              ),
            );
            break;
        }
      }

      final entity = Entity(
        id: widget.item?.id,
        listingAttribute: (
          listingDraft.nameController.text.trim(),
          _displayValueFor(listingDraft),
        ),
        attributesOrder: [
          for (var i = 0; i < attributeDrafts.length; i++) (i, attributeDrafts[i].valueType.type),
        ],
        textAttributes: textAttributes,
        numberAttributes: numberAttributes,
        boolAttributes: boolAttributes,
        dateAttributes: dateAttributes,
        dateTimeAttributes: dateTimeAttributes,
        outgoingLinks: outgoingLinkDrafts
            .map(
              (link) => EntityLink(
                id: link.id,
                name: link.name,
                description: link.description,
                orderIdx: outgoingLinkDrafts.indexOf(link),
                sourceId: widget.item?.id ?? zeroUuid,
                targetId: link.targetId,
                target: link.target,
              ),
            )
            .toList(),
        incomingLinks: initialIncomingLinks,
      );

      await widget.onSave!(entity);
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Widget _buildValueField(_EntityAttributeDraft draft) {
    switch (draft.valueType) {
      case ValueType.boolean:
        return DropdownButtonFormField<bool>(
          key: ValueKey('attr-${draft.localId}-value-bool'),
          initialValue: draft.boolValue,
          decoration: const InputDecoration(labelText: 'Value'),
          items: const [
            DropdownMenuItem(value: false, child: Text('False')),
            DropdownMenuItem(value: true, child: Text('True')),
          ],
          onChanged: _isReadOnly ? null : (value) => setState(() => draft.boolValue = value ?? false),
        );
      case ValueType.date:
        return TextFormField(
          key: ValueKey('attr-${draft.localId}-value-date'),
          controller: draft.valueController,
          readOnly: true,
          decoration: InputDecoration(
            labelText: 'Value',
            suffixIcon: _isReadOnly
                ? null
                : IconButton(
                    tooltip: 'Pick date',
                    onPressed: () => _pickDate(draft),
                    icon: const Icon(Icons.calendar_month_outlined),
                  ),
          ),
        );
      case ValueType.datetime:
        return TextFormField(
          key: ValueKey('attr-${draft.localId}-value-datetime'),
          controller: draft.valueController,
          readOnly: true,
          decoration: InputDecoration(
            labelText: 'Value',
            suffixIcon: _isReadOnly
                ? null
                : IconButton(
                    tooltip: 'Pick date and time',
                    onPressed: () => _pickDateTime(draft),
                    icon: const Icon(Icons.schedule),
                  ),
          ),
        );
      case ValueType.number:
        return TextFormField(
          key: ValueKey('attr-${draft.localId}-value-number'),
          controller: draft.valueController,
          readOnly: _isReadOnly,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'Value'),
        );
      case ValueType.text:
        return TextFormField(
          key: ValueKey('attr-${draft.localId}-value-text'),
          controller: draft.valueController,
          readOnly: _isReadOnly,
          decoration: const InputDecoration(labelText: 'Value'),
        );
    }
  }

  Widget _buildAttributeCard(_EntityAttributeDraft draft, int index) {
    return Padding(
      key: ValueKey(draft.localId),
      padding: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: TextFormField(
                key: ValueKey('attr-${draft.localId}-name'),
                controller: draft.nameController,
                readOnly: _isReadOnly,
                decoration: InputDecoration(labelText: _isReadOnly ? 'Name' : 'Name *'),
                onChanged: _isReadOnly ? null : (_) => setState(() {}),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 5,
              child: _buildValueField(draft),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 88,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildValueTypeSelector(draft),
                  const SizedBox(height: 4),
                  _buildAccessLevelSelector(draft),
                ],
              ),
            ),
            if (!_isReadOnly) ...[
              const SizedBox(width: 4),
              SizedBox(
                width: 18,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 18,
                      height: 18,
                      child: _HoverActionIcon(
                        icon: Icons.remove,
                        tooltip: 'Remove attribute',
                        onPressed: () => _removeAttribute(draft.localId),
                        size: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    ReorderableDragStartListener(
                      index: index,
                      child: const _HoverActionIcon(
                        icon: Icons.drag_indicator,
                        tooltip: 'Drag to reorder',
                        size: 16,
                        cursor: SystemMouseCursors.resizeUpDown,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildValueTypeSelector(_EntityAttributeDraft draft) {
    return _CompactSelector<ValueType>(
      width: 88,
      tooltip: 'Value type',
      valueLabel: draft.valueType.label,
      enabled: !_isReadOnly,
      options: [
        for (final type in ValueType.values) _CompactSelectOption(value: type, label: type.label),
      ],
      onSelected: (value) {
        setState(() {
          draft.valueType = value;
          draft.valueController.clear();
          draft.boolValue = false;
        });
      },
    );
  }

  Widget _buildAccessLevelSelector(_EntityAttributeDraft draft) {
    final selectedAccessLevel = accessLevels.where((level) => level.id == draft.accessLevelId).firstOrNull;

    return _CompactSelector<int>(
      width: 88,
      tooltip: 'Access level',
      valueLabel: selectedAccessLevel?.name ?? 'Access *',
      enabled: !_isReadOnly && accessLevels.isNotEmpty,
      options: [
        for (final level in accessLevels)
          if (level.id != null) _CompactSelectOption(value: level.id!, label: level.name),
      ],
      onSelected: (value) => setState(() => draft.accessLevelId = value),
    );
  }

  Widget _buildAttributeCardsList(bool isDarkMode, {required bool shrinkWrap}) {
    return ReorderableListView.builder(
      shrinkWrap: shrinkWrap,
      primary: false,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      buildDefaultDragHandles: false,
      itemCount: attributeDrafts.length,
      onReorder: _onReorderAttributes,
      itemBuilder: (context, index) => _buildAttributeCard(attributeDrafts[index], index),
      proxyDecorator: (child, index, animation) => _buildAttributeDragProxy(attributeDrafts[index], isDarkMode),
    );
  }

  Widget _buildAttributeDragProxy(_EntityAttributeDraft draft, bool isDarkMode) {
    final fgColor = isDarkMode ? darkFgColor : lightFgColor;
    final fadedColor = isDarkMode ? darkFgFadedColor : lightFgFadedColor;
    final name = draft.nameController.text.trim();
    final value = _displayValueFor(draft).trim();
    final accessLevelName = accessLevels.where((level) => level.id == draft.accessLevelId).firstOrNull?.name;

    return Material(
      elevation: 6,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6, 6, 6, 16),
        child: Row(
          children: [
            Icon(Icons.drag_indicator, size: 18, color: fadedColor),
            const SizedBox(width: 8),
            Expanded(
              flex: 4,
              child: Text(
                name.isEmpty ? 'Unnamed attribute' : name,
                style: TextStyle(color: fgColor, fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 5,
              child: Text(
                value.isEmpty ? 'No value' : value,
                style: TextStyle(color: fadedColor),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 90,
              child: Text(
                draft.valueType.label,
                style: TextStyle(color: fadedColor),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 120,
              child: Text(
                accessLevelName ?? 'No access level',
                style: TextStyle(color: fadedColor),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttributeListTile(_EntityAttributeDraft draft) {
    final name = draft.nameController.text.trim();
    final value = _displayValueFor(draft).trim();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 22, child: Text('•')),
          SizedBox(
            width: 220,
            child: Text(
              name.isEmpty ? 'Unnamed attribute' : name,
              style: const TextStyle(fontSize: 15),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value.isEmpty ? 'No value' : value,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateLinksSection(bool isDarkMode) {
    final outgoingLinks = initialOutgoingLinks;
    final incomingLinks = initialIncomingLinks;

    if (outgoingLinks.isEmpty && incomingLinks.isEmpty) {
      return const SizedBox.shrink();
    }

    final faded = isDarkMode ? darkFgFadedColor : lightFgFadedColor;

    Widget buildLinkTile(String prefix, EntityLink link) {
      return Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          '$prefix ${link.name}${(link.description ?? '').isNotEmpty ? ' · ${link.description}' : ''}',
          style: TextStyle(color: faded),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 16),
        const Text(
          'Template Links',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        Text(
          'Links from the chosen entity template are carried into the created entity payload.',
          style: TextStyle(color: faded),
        ),
        if (outgoingLinks.isNotEmpty) ...[
          const SizedBox(height: 10),
          Text(
            'Outgoing',
            style: TextStyle(color: faded, fontStyle: FontStyle.italic),
          ),
          for (final link in outgoingLinks) buildLinkTile('->', link),
        ],
        if (incomingLinks.isNotEmpty) ...[
          const SizedBox(height: 10),
          Text(
            'Incoming',
            style: TextStyle(color: faded, fontStyle: FontStyle.italic),
          ),
          for (final link in incomingLinks) buildLinkTile('<-', link),
        ],
      ],
    );
  }

  String _entityLabel(Entity entity) {
    final name = entity.listingAttribute.$1.trim();
    final value = entity.listingAttribute.$2.trim();
    if (name.isEmpty) return value.isEmpty ? 'Untitled entity' : value;
    if (value.isEmpty) return name;
    return '$name: $value';
  }

  String _entityLabelById(List<Entity> entities, UuidValue entityId) {
    final entity = entities.where((item) => item.id == entityId).firstOrNull;
    return entity == null ? 'Unknown entity' : _entityLabel(entity);
  }

  Widget _buildAttributesSection(bool isDarkMode, {bool expandAttributeList = false}) {
    final listingDraft = _selectedListingDraft;

    if (_isReadOnly) {
      final children = [
        if (attributeDrafts.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'No attributes.',
              style: TextStyle(color: isDarkMode ? darkFgFadedColor : lightFgFadedColor),
              textAlign: TextAlign.center,
            ),
          )
        else
          for (final draft in attributeDrafts) _buildAttributeListTile(draft),
      ];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      );
    }

    final listContent = attributeDrafts.isEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              _isReadOnly ? 'No attributes.' : 'No attributes yet. Add one or start from a template.',
              style: TextStyle(color: isDarkMode ? darkFgFadedColor : lightFgFadedColor),
              textAlign: TextAlign.center,
            ),
          )
        : _buildAttributeCardsList(isDarkMode, shrinkWrap: !expandAttributeList);

    final children = [
      DropdownButtonFormField<int>(
        initialValue: _selectedListingDraftId,
        decoration: const InputDecoration(labelText: 'Listing attribute *'),
        items: attributeDrafts
            .map(
              (draft) => DropdownMenuItem<int>(
                value: draft.localId,
                child: Text(
                  draft.nameController.text.trim().isEmpty ? 'Unnamed attribute' : draft.nameController.text.trim(),
                ),
              ),
            )
            .toList(),
        onChanged: _isReadOnly ? null : (value) => setState(() => _selectedListingDraftId = value),
        validator: (_) => attributeDrafts.isEmpty
            ? 'Add at least one attribute first.'
            : (_selectedListingDraftId == null ? 'Listing attribute is required' : null),
      ),
      const SizedBox(height: 8),
      Text(
        listingDraft == null ? 'Listing value will be inferred from the selected attribute.' : 'Listing value: ${_displayValueFor(listingDraft)}',
        style: TextStyle(color: isDarkMode ? darkFgFadedColor : lightFgFadedColor),
      ),
      const SizedBox(height: 20),
      Row(
        children: [
          const Expanded(
            child: Text(
              'Attributes',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
          if (!_isReadOnly)
            IconButton(
              tooltip: 'Add attribute',
              onPressed: _isScratchCreation ? _addAttributeWithChoice : _addAttribute,
              icon: const Icon(Icons.add),
            ),
        ],
      ),
    ];

    if (expandAttributeList) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...children,
          Expanded(child: listContent),
          if (widget.initialTemplate != null) _buildTemplateLinksSection(isDarkMode),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...children,
        listContent,
        if (widget.initialTemplate != null) _buildTemplateLinksSection(isDarkMode),
      ],
    );
  }

  Widget _buildLinksSection(bool isDarkMode) {
    return BlocBuilder<EntitiesCubit, EntitiesState>(
      builder: (context, state) => _buildLinksSectionContent(isDarkMode, state.entities),
    );
  }

  Widget _buildLinksSectionContent(bool isDarkMode, List<Entity> targetEntities) {
    final faded = isDarkMode ? darkFgFadedColor : lightFgFadedColor;
    final entities = targetEntities.where((entity) => entity.id != widget.item?.id).toList();
    final incomingLinks = initialIncomingLinks;

    if (_isReadOnly) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (outgoingLinkDrafts.isEmpty && incomingLinks.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'No links',
                style: TextStyle(fontStyle: FontStyle.italic, color: faded),
                textAlign: TextAlign.center,
              ),
            ),
          if (outgoingLinkDrafts.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 6),
              child: Text(
                'Outgoing Links',
                style: TextStyle(fontStyle: FontStyle.italic, color: faded, fontSize: 13),
              ),
            ),
            for (final link in outgoingLinkDrafts)
              ListTile(
                leading: const Text('•'),
                title: Text('--  ${link.name} --> ${_entityLabelById(entities, link.targetId)}', style: const TextStyle(fontSize: 15)),
                subtitle: (link.description ?? '').isNotEmpty ? Text(link.description!, style: const TextStyle(fontSize: 12)) : null,
                minVerticalPadding: 6,
              ),
          ],
          if (incomingLinks.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.only(top: 18, bottom: 6),
              child: Text(
                'Incoming Links',
                style: TextStyle(fontStyle: FontStyle.italic, color: faded, fontSize: 13),
              ),
            ),
            for (final link in incomingLinks)
              ListTile(
                leading: const Text('•'),
                title: Text('<-- ${link.name} -- ${_entityLabelById(targetEntities, link.sourceId)}', style: const TextStyle(fontSize: 15)),
                subtitle: (link.description ?? '').isNotEmpty ? Text(link.description!, style: const TextStyle(fontSize: 12)) : null,
                minVerticalPadding: 6,
              ),
          ],
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: outgoingLinkDrafts.isEmpty && incomingLinks.isEmpty
              ? Center(
                  child: Text(
                    'No links',
                    style: TextStyle(fontStyle: FontStyle.italic, color: faded),
                  ),
                )
              : _isReadOnly
              ? ListView(
                  children: [
                    if (outgoingLinkDrafts.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 6),
                        child: Text(
                          'Outgoing Links',
                          style: TextStyle(fontStyle: FontStyle.italic, color: faded, fontSize: 13),
                        ),
                      ),
                      for (final link in outgoingLinkDrafts)
                        ListTile(
                          leading: const Text('•'),
                          title: Text('--  ${link.name} --> ${_entityLabelById(entities, link.targetId)}', style: const TextStyle(fontSize: 15)),
                          subtitle: (link.description ?? '').isNotEmpty ? Text(link.description!, style: const TextStyle(fontSize: 12)) : null,
                          minVerticalPadding: 6,
                        ),
                    ],
                    if (incomingLinks.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.only(top: 18, bottom: 6),
                        child: Text(
                          'Incoming Links',
                          style: TextStyle(fontStyle: FontStyle.italic, color: faded, fontSize: 13),
                        ),
                      ),
                      for (final link in incomingLinks)
                        ListTile(
                          leading: const Text('•'),
                          title: Text('<-- ${link.name} -- ${_entityLabelById(targetEntities, link.sourceId)}', style: const TextStyle(fontSize: 15)),
                          subtitle: (link.description ?? '').isNotEmpty ? Text(link.description!, style: const TextStyle(fontSize: 12)) : null,
                          minVerticalPadding: 6,
                        ),
                    ],
                  ],
                )
              : ReorderableListView.builder(
                  primary: false,
                  buildDefaultDragHandles: false,
                  itemCount: outgoingLinkDrafts.length,
                  onReorder: _onReorderOutgoingLinks,
                  header: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 6),
                    child: Text(
                      'Outgoing Links',
                      style: TextStyle(fontStyle: FontStyle.italic, color: faded, fontSize: 13),
                    ),
                  ),
                  footer: incomingLinks.isEmpty
                      ? null
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 18, bottom: 6),
                              child: Text(
                                'Incoming Links',
                                style: TextStyle(fontStyle: FontStyle.italic, color: faded, fontSize: 13),
                              ),
                            ),
                            for (final link in incomingLinks)
                              ListTile(
                                leading: const Text('•'),
                                title: Text(
                                  '<-- ${link.name} -- ${_entityLabelById(targetEntities, link.sourceId)}',
                                  style: const TextStyle(fontSize: 15),
                                ),
                                subtitle: (link.description ?? '').isNotEmpty ? Text(link.description!, style: const TextStyle(fontSize: 12)) : null,
                                minVerticalPadding: 6,
                              ),
                          ],
                        ),
                  itemBuilder: (context, index) {
                    final link = outgoingLinkDrafts[index];
                    return ReorderableDragStartListener(
                      key: ValueKey('${link.id ?? link.targetId}-$index-${link.name}'),
                      index: index,
                      child: ListTile(
                        mouseCursor: SystemMouseCursors.resizeUpDown,
                        leading: const Text('•'),
                        title: Text('--  ${link.name} --> ${_entityLabelById(entities, link.targetId)}', style: const TextStyle(fontSize: 15)),
                        subtitle: (link.description ?? '').isNotEmpty ? Text(link.description!, style: const TextStyle(fontSize: 12)) : null,
                        trailing: IconButton(
                          onPressed: () => _removeOutgoingLinkAt(index),
                          icon: const Icon(Icons.remove, size: 14),
                          visualDensity: VisualDensity.compact,
                          tooltip: 'Remove',
                        ),
                      ),
                    );
                  },
                  proxyDecorator: (child, index, animation) => Material(
                    elevation: 6,
                    color: isDarkMode ? darkBgColor : lightBgColor,
                    child: child,
                  ),
                ),
        ),
        if (!_isReadOnly) ...[
          TextFormField(
            controller: linkNameController,
            decoration: const InputDecoration(
              labelText: 'Name *',
              hintText: 'Required',
            ),
          ),
          const SizedBox(height: 2),
          TextFormField(
            controller: linkDescriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
            maxLines: 1,
            minLines: 1,
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<UuidValue>(
                  initialValue: _selectedLinkTargetId,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Target',
                    hintText: 'Pick an entity',
                  ),
                  items: entities
                      .where((entity) => entity.id != null)
                      .map(
                        (entity) => DropdownMenuItem<UuidValue>(
                          value: entity.id!,
                          child: Text(_entityLabel(entity), overflow: TextOverflow.ellipsis),
                        ),
                      )
                      .toList(),
                  onChanged: entities.isEmpty ? null : (targetId) => setState(() => _selectedLinkTargetId = targetId),
                ),
              ),
              IconButton(
                onPressed: _selectedLinkTargetId == null ? null : _addSelectedOutgoingLink,
                icon: const Icon(Icons.add, size: 18),
                tooltip: 'Add link',
              ),
            ],
          ),
          if (entities.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                'Create another entity first to link to it.',
                style: TextStyle(color: faded),
              ),
            ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }

  Widget _buildScratchTabs(bool isDarkMode) {
    final tabsHeight = _isReadOnly ? 300.0 : 400.0;
    final readOnlyTabs = [
      _buildAttributesSection(isDarkMode, expandAttributeList: true),
      _buildLinksSection(isDarkMode),
    ];

    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TabBar(
            onTap: _isReadOnly ? (index) => setState(() => _selectedScratchTabIndex = index) : null,
            tabs: const [
              Tab(text: 'Attributes', height: tabHeight),
              Tab(text: 'Links', height: tabHeight),
            ],
          ),
          const SizedBox(height: 12),
          if (_isReadOnly)
            readOnlyTabs[_selectedScratchTabIndex]
          else
            SizedBox(
              height: tabsHeight,
              child: TabBarView(
                children: [
                  _buildAttributesSection(isDarkMode, expandAttributeList: true),
                  _buildLinksSection(isDarkMode),
                ],
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.read<ThemeCubit>().isDarkMode;

    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.initialTemplate != null && widget.item == null) ...[
                Text(
                  'Template: ${widget.initialTemplate!.name}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                if ((widget.initialTemplate!.description ?? '').isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      widget.initialTemplate!.description!,
                      style: TextStyle(color: isDarkMode ? darkFgFadedColor : lightFgFadedColor),
                    ),
                  ),
                const SizedBox(height: 16),
              ],
              if (_isScratchCreation || _isEdit) _buildScratchTabs(isDarkMode) else _buildAttributesSection(isDarkMode),
              Align(
                alignment: Alignment.centerRight,
                child: _isReadOnly
                    ? IconButton(
                        onPressed: _isEdit ? widget.onRequestEdit : null,
                        color: isDarkMode ? darkFgFadedColor : lightFgFadedColor,
                        icon: const Icon(Icons.edit, size: 22),
                        tooltip: 'Edit',
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_isEdit)
                            IconButton(
                              onPressed: _isSaving ? null : widget.onRequestView,
                              color: isDarkMode ? darkFgFadedColor : lightFgFadedColor,
                              icon: const Icon(Icons.arrow_back, size: 22),
                              tooltip: 'Back to view',
                            ),
                          IconButton(
                            onPressed: _isSaving ? null : onSave,
                            color: isDarkMode ? darkFgColor : lightFgColor,
                            icon: _isSaving
                                ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                                : const Icon(Icons.save, size: 22),
                            tooltip: _isEdit ? 'Update' : 'Add',
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompactSelectOption<T> {
  const _CompactSelectOption({
    required this.value,
    required this.label,
  });

  final T value;
  final String label;
}

class _CompactSelector<T> extends StatelessWidget {
  const _CompactSelector({
    required this.width,
    required this.tooltip,
    required this.valueLabel,
    required this.enabled,
    required this.options,
    required this.onSelected,
  });

  final double width;
  final String tooltip;
  final String valueLabel;
  final bool enabled;
  final List<_CompactSelectOption<T>> options;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.read<ThemeCubit>().isDarkMode;
    final fgColor = enabled ? (isDarkMode ? darkFgColor : lightFgColor) : (isDarkMode ? darkFgFadedColor : lightFgFadedColor);

    final child = Container(
      width: width,
      height: 24,
      padding: const EdgeInsets.only(left: 2, right: 0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              valueLabel,
              style: TextStyle(color: fgColor, fontSize: 11),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (enabled)
            Icon(
              Icons.arrow_drop_down,
              size: 14,
              color: fgColor,
            ),
        ],
      ),
    );

    if (!enabled) {
      return Tooltip(message: tooltip, child: child);
    }

    return PopupMenuButton<T>(
      tooltip: tooltip,
      enabled: enabled,
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(minWidth: width),
      onSelected: onSelected,
      itemBuilder: (context) => [
        for (final option in options)
          PopupMenuItem<T>(
            value: option.value,
            height: 28,
            child: Text(
              option.label,
              style: const TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
      child: child,
    );
  }
}

class _HoverActionIcon extends StatefulWidget {
  const _HoverActionIcon({
    required this.icon,
    required this.tooltip,
    required this.size,
    this.onPressed,
    this.cursor = SystemMouseCursors.click,
  });

  final IconData icon;
  final String tooltip;
  final double size;
  final VoidCallback? onPressed;
  final MouseCursor cursor;

  @override
  State<_HoverActionIcon> createState() => _HoverActionIconState();
}

class _HoverActionIconState extends State<_HoverActionIcon> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.read<ThemeCubit>().isDarkMode;
    final color = isHovered ? (isDarkMode ? darkFgColor : lightFgColor) : (isDarkMode ? darkFgFadedColor : lightFgFadedColor);

    final icon = Icon(widget.icon, size: widget.size, color: color);

    return MouseRegion(
      cursor: widget.cursor,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Tooltip(
        message: widget.tooltip,
        child: widget.onPressed == null
            ? Center(child: icon)
            : IconButton(
                onPressed: widget.onPressed,
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                constraints: BoxConstraints.tightFor(width: widget.size + 4, height: widget.size + 4),
                icon: icon,
              ),
      ),
    );
  }
}

class _EntityAttributeDraft {
  _EntityAttributeDraft({
    required this.localId,
    this.id,
    required this.nameController,
    required this.descriptionController,
    required this.valueController,
    required this.valueType,
    required this.accessLevelId,
    required this.boolValue,
  });

  factory _EntityAttributeDraft.empty({
    required int localId,
    int? accessLevelId,
  }) {
    return _EntityAttributeDraft(
      localId: localId,
      nameController: TextEditingController(),
      descriptionController: TextEditingController(),
      valueController: TextEditingController(),
      valueType: ValueType.text,
      accessLevelId: accessLevelId,
      boolValue: false,
    );
  }

  factory _EntityAttributeDraft.fromTemplate({
    required int localId,
    required AttributeTmpl? item,
    required int? fallbackAccessLevelId,
  }) {
    if (item == null) return _EntityAttributeDraft.empty(localId: localId, accessLevelId: fallbackAccessLevelId);
    final valueType = ValueType.fromJson(item.valueType);
    final defaultValue = item.defaultValue;
    return _EntityAttributeDraft(
      localId: localId,
      nameController: TextEditingController(text: item.name),
      descriptionController: TextEditingController(text: item.description ?? ''),
      valueController: TextEditingController(
        text: switch (valueType) {
          ValueType.boolean => '',
          _ => defaultValue,
        },
      ),
      valueType: valueType,
      accessLevelId: item.accessLevelId,
      boolValue: defaultValue.toLowerCase() == 'true',
    );
  }

  factory _EntityAttributeDraft.fromText({
    required int localId,
    required TextAttribute item,
  }) {
    return _EntityAttributeDraft(
      localId: localId,
      id: item.id,
      nameController: TextEditingController(text: item.name),
      descriptionController: TextEditingController(text: item.description ?? ''),
      valueController: TextEditingController(text: item.value),
      valueType: ValueType.text,
      accessLevelId: item.accessLevelId,
      boolValue: false,
    );
  }

  factory _EntityAttributeDraft.fromNumber({
    required int localId,
    required NumberAttribute item,
  }) {
    return _EntityAttributeDraft(
      localId: localId,
      id: item.id,
      nameController: TextEditingController(text: item.name),
      descriptionController: TextEditingController(text: item.description ?? ''),
      valueController: TextEditingController(text: item.value.toString()),
      valueType: ValueType.number,
      accessLevelId: item.accessLevelId,
      boolValue: false,
    );
  }

  factory _EntityAttributeDraft.fromBool({
    required int localId,
    required BoolAttribute item,
  }) {
    return _EntityAttributeDraft(
      localId: localId,
      id: item.id,
      nameController: TextEditingController(text: item.name),
      descriptionController: TextEditingController(text: item.description ?? ''),
      valueController: TextEditingController(),
      valueType: ValueType.boolean,
      accessLevelId: item.accessLevelId,
      boolValue: item.value,
    );
  }

  factory _EntityAttributeDraft.fromDate({
    required int localId,
    required DateAttribute item,
  }) {
    return _EntityAttributeDraft(
      localId: localId,
      id: item.id,
      nameController: TextEditingController(text: item.name),
      descriptionController: TextEditingController(text: item.description ?? ''),
      valueController: TextEditingController(text: formatDateYmd(item.value)),
      valueType: ValueType.date,
      accessLevelId: item.accessLevelId,
      boolValue: false,
    );
  }

  factory _EntityAttributeDraft.fromDateTime({
    required int localId,
    required DateTimeAttribute item,
  }) {
    return _EntityAttributeDraft(
      localId: localId,
      id: item.id,
      nameController: TextEditingController(text: item.name),
      descriptionController: TextEditingController(text: item.description ?? ''),
      valueController: TextEditingController(text: item.value.toIso8601String()),
      valueType: ValueType.datetime,
      accessLevelId: item.accessLevelId,
      boolValue: false,
    );
  }

  final int localId;
  final UuidValue? id;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController valueController;
  ValueType valueType;
  int? accessLevelId;
  bool boolValue;

  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    valueController.dispose();
  }
}
