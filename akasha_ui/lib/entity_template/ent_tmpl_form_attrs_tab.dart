part of 'ent_tmpl_form.dart';

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
                      dense: false,
                      minVerticalPadding: 6,
                      leading: Text('•'),
                      title: Text(attr.name, style: TextStyle(fontSize: 15)),
                      subtitle: attr.description != null && attr.description!.isNotEmpty
                          ? Text(attr.description!, style: TextStyle(fontSize: 12))
                          : null,
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
                        minVerticalPadding: 6,
                        leading: Text('•'),
                        title: Text(attr.name, style: TextStyle(fontSize: 15)),
                        subtitle: attr.description != null && attr.description!.isNotEmpty
                            ? Text(attr.description!, style: TextStyle(fontSize: 12))
                            : null,
                        trailing: IconButton(
                          onPressed: () => onRemoveAttribute(attr),
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
                icon: const Icon(Icons.add, size: 18),
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
