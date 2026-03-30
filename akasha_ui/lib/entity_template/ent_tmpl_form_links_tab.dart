part of 'ent_tmpl_form.dart';

// ---------
// Links tab
// ---------

class _LinksTab extends StatelessWidget {
  const _LinksTab({
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
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 6),
                        child: Text(
                          'Outgoing Links',
                          style: TextStyle(fontStyle: FontStyle.italic, color: isDarkMode ? darkFgFadedColor : lightFgFadedColor, fontSize: 13),
                        ),
                      ),
                      ...outgoingLinks.map(
                        (link) {
                          final targetName = entityTmpls.firstWhere((ent) => ent.id == link.targetId, orElse: () => EntityTmpl(name: 'Unknown')).name;
                          final title = '${link.name}  --  $targetName';
                          return ListTile(
                            leading: Text('•'),
                            title: Text(title),
                            subtitle: link.description != null ? Text(link.description!) : null,
                            minVerticalPadding: 6,
                          );
                        },
                      ),
                    ],
                    if (incomingLinks.isNotEmpty) ...[
                      Padding(
                        padding: EdgeInsets.only(top: 18, bottom: 6),
                        child: Text(
                          'Incoming Links',
                          style: TextStyle(fontStyle: FontStyle.italic, color: isDarkMode ? darkFgFadedColor : lightFgFadedColor, fontSize: 13),
                        ),
                      ),
                      ...incomingLinks.map(
                        (link) {
                          final sourceName = entityTmpls.firstWhere((ent) => ent.id == link.sourceId, orElse: () => EntityTmpl(name: 'Unknown')).name;
                          final title = '$sourceName  --  ${link.name}';
                          return ListTile(
                            minVerticalPadding: 5,
                            leading: Text('•'),
                            title: Text(title),
                            subtitle: link.description != null ? Text(link.description!) : null,
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
                  header: Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 6),
                    child: Text(
                      'Outgoing Links',
                      style: TextStyle(fontStyle: FontStyle.italic, color: isDarkMode ? darkFgFadedColor : lightFgFadedColor, fontSize: 13),
                    ),
                  ),
                  itemBuilder: (context, index) {
                    final link = outgoingLinks[index];
                    final linkLabel =
                        '${link.name} -> ${entityTmpls.firstWhere((ent) => ent.id == link.targetId, orElse: () => EntityTmpl(name: 'Unknown')).name}';
                    return ReorderableDragStartListener(
                      key: ValueKey(link.id),
                      index: index,
                      child: ListTile(
                        mouseCursor: SystemMouseCursors.resizeUpDown,
                        leading: Text('•'),
                        title: Text(linkLabel),
                        subtitle: link.description != null && link.description!.isNotEmpty ? Text(link.description!) : null,
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
          const SizedBox(height: 2),
          TextFormField(
            controller: linkDescCtrl,
            readOnly: readOnly,
            decoration: const InputDecoration(labelText: 'Description'),
            maxLines: 1,
            minLines: 1,
          ),
          const SizedBox(height: 6),
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
                  items: entityTmpls
                      .map(
                        (ent) => DropdownMenuItem<UuidValue>(value: ent.id ?? zeroUuid, child: Text(ent.name)),
                      )
                      .toList(),
                  onChanged: entityTmpls.isEmpty
                      ? null
                      : (targetId) {
                          if (targetId == null) return;
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
