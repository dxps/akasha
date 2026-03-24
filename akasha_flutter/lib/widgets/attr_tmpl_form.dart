import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_flutter/main.dart';
import 'package:akasha_flutter/model/attr_value_type.dart';
import 'package:akasha_flutter/widgets/feedback.dart';
import 'package:flutter/material.dart';

class AttributeTemplateForm extends StatefulWidget {
  const AttributeTemplateForm({
    super.key,
    this.item,
    required this.onSave,
  });

  final AttributeTmpl? item;
  final Future<void> Function(AttributeTmpl) onSave;

  @override
  State<AttributeTemplateForm> createState() => _AttributeTemplateFormState();
}

class _AttributeTemplateFormState extends State<AttributeTemplateForm> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  late final TextEditingController defaultValueController;

  late AttributeValueType selectedType;
  late bool isRequired;
  late bool defaultBooleanValue;
  late int? selectedAccessLevelId;

  List<AccessLevel> accessLevels = [];
  bool _isSaving = false;
  bool _isLoadingAccessLevels = true;
  bool get _isEdit => widget.item != null;

  @override
  void initState() {
    super.initState();

    final tmpl = widget.item;

    nameController = TextEditingController(text: tmpl?.name ?? '');
    descriptionController = TextEditingController(text: tmpl?.description ?? '');
    defaultValueController = TextEditingController(
      text: tmpl?.defaultValue.toString() ?? '',
    );

    selectedType = tmpl != null
        ? AttributeValueType.values.firstWhere(
            (t) => t.name == tmpl.valueType,
            orElse: () => AttributeValueType.text,
          )
        : AttributeValueType.text;

    isRequired = tmpl?.required ?? false;
    defaultBooleanValue = tmpl?.valueType == 'boolean' ? tmpl?.defaultValue.toLowerCase() == 'true' : false;
    selectedAccessLevelId = tmpl?.accessLevelId;

    _fetchAccessLevels();
  }

  Future<void> _fetchAccessLevels() async {
    try {
      final items = await client.accessLevel.readAll();
      if (!mounted) return;
      setState(() {
        accessLevels = items;
        _isLoadingAccessLevels = false;
      });
    } catch (e) {
      debugPrint('Error fetching access levels: $e');
      if (!mounted) return;
      setState(() => _isLoadingAccessLevels = false);
      showErrorSnackbar(context, 'Error fetching access levels: $e');
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    defaultValueController.dispose();
    super.dispose();
  }

  Future<void> pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (!mounted) return;

    if (picked != null) {
      defaultValueController.text =
          '${picked.year.toString().padLeft(4, '0')}-'
          '${picked.month.toString().padLeft(2, '0')}-'
          '${picked.day.toString().padLeft(2, '0')}';
    }
  }

  Future<void> pickDateTime() async {
    final now = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (!mounted) return;
    if (pickedDate == null) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(now),
    );

    if (!mounted) return;
    if (pickedTime == null) return;

    final pickedDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    defaultValueController.text = pickedDateTime.toIso8601String();
  }

  Widget buildDefaultValueField() {
    switch (selectedType) {
      case AttributeValueType.boolean:
        return DropdownButtonFormField<bool?>(
          initialValue: defaultBooleanValue,
          decoration: const InputDecoration(
            labelText: 'Default value',
          ),
          items: const [
            DropdownMenuItem<bool?>(
              value: false,
              child: Text('False'),
            ),
            DropdownMenuItem<bool?>(
              value: true,
              child: Text('True'),
            ),
          ],
          onChanged: (value) {
            setState(() {
              defaultBooleanValue = value ?? false;
            });
          },
        );

      case AttributeValueType.number:
        return TextFormField(
          controller: defaultValueController,
          decoration: const InputDecoration(
            labelText: 'Default value',
            hintText: 'e.g. 42',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: (value) {
            final trimmed = value?.trim() ?? '';
            if (trimmed.isEmpty) return null;
            if (double.tryParse(trimmed) == null) {
              return 'Enter a valid number';
            }
            return null;
          },
        );

      case AttributeValueType.date:
        return TextFormField(
          controller: defaultValueController,
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'Default value',
            hintText: 'YYYY-MM-DD',
            suffixIcon: Icon(Icons.calendar_today),
          ),
          onTap: pickDate,
        );

      case AttributeValueType.dateTime:
        return TextFormField(
          controller: defaultValueController,
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'Default value',
            hintText: 'ISO 8601 date-time',
            suffixIcon: Icon(Icons.schedule),
          ),
          onTap: pickDateTime,
        );

      case AttributeValueType.text:
        return TextFormField(
          controller: defaultValueController,
          decoration: const InputDecoration(
            labelText: 'Default value',
          ),
        );
    }
  }

  Future<void> onSave() async {
    if (_isSaving) return;

    if (!formKey.currentState!.validate()) {
      return;
    }

    if (selectedAccessLevelId == null) {
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        const SnackBar(content: Text('Please select an access level')),
      );
      return;
    }

    final defaultValue = switch (selectedType) {
      AttributeValueType.boolean => defaultBooleanValue.toString(),
      _ => defaultValueController.text.trim().isEmpty ? '' : defaultValueController.text.trim(),
    };

    setState(() => _isSaving = true);

    final tmpl = AttributeTmpl(
      id: widget.item?.id,
      name: nameController.text.trim(),
      description: descriptionController.text.trim(),
      valueType: selectedType.name,
      defaultValue: defaultValue,
      required: isRequired,
      accessLevelId: selectedAccessLevelId!,
      accessLevel: null,
    );

    await widget.onSave(tmpl);

    if (mounted) {
      setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name *', hintText: 'Required'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
                onChanged: (_) => formKey.currentState?.validate(),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  DropdownMenuFormField<AttributeValueType>(
                    initialSelection: selectedType,
                    label: const Text('Value type *'),
                    dropdownMenuEntries: AttributeValueType.values.map((type) => DropdownMenuEntry(value: type, label: type.label)).toList(),
                    onSelected: (value) {
                      if (value == null) return;
                      setState(() {
                        selectedType = value;
                        defaultValueController.clear();
                        defaultBooleanValue = false;
                      });
                      formKey.currentState?.validate();
                    },
                    width: 140,
                    menuHeight: 230,
                    menuStyle: const MenuStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.white),
                      padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 6, horizontal: 0)),
                    ),
                    requestFocusOnTap: false,
                    decorationBuilder: (context, controller) {
                      return const InputDecoration(
                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 4),
                        isDense: true,
                        filled: true,
                        fillColor: Colors.white,
                      );
                    },
                  ),
                  const SizedBox(width: 12),
                  _isLoadingAccessLevels
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        )
                      : DropdownMenuFormField<int>(
                          initialSelection: selectedAccessLevelId,
                          label: const Text('Access Level *', overflow: TextOverflow.ellipsis),
                          dropdownMenuEntries: accessLevels.map((level) => DropdownMenuEntry<int>(value: level.id!, label: level.name)).toList(),
                          onSelected: (value) {
                            setState(() {
                              selectedAccessLevelId = value;
                            });
                            formKey.currentState?.validate();
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Access level is required';
                            }
                            return null;
                          },
                          menuHeight: 200,
                          menuStyle: const MenuStyle(
                            backgroundColor: WidgetStatePropertyAll(Colors.white),
                            padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 6, horizontal: 0)),
                          ),
                          width: 154,
                          requestFocusOnTap: false,
                          // make it match your other text fields
                          decorationBuilder: (context, controller) {
                            return const InputDecoration(
                              border: UnderlineInputBorder(),
                              enabledBorder: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 4),
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                            );
                          },
                        ),
                ],
              ),

              const SizedBox(height: 12),
              buildDefaultValueField(),
              const SizedBox(height: 8),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.trailing,
                title: const Text('Is required ?'),
                value: isRequired,
                visualDensity: VisualDensity.compact,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: (value) {
                  setState(() => isRequired = value ?? false);
                },
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: _isSaving ? null : onSave,
                  color: Theme.of(context).primaryColor,
                  icon: _isSaving ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.save),
                  tooltip: _isEdit ? 'Update' : 'Add',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
