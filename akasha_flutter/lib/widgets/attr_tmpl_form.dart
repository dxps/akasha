import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_flutter/main.dart';
import 'package:akasha_flutter/model/attr_value_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AttributeTemplateForm extends StatefulWidget {
  const AttributeTemplateForm({
    super.key,
    this.item,
    required this.onSave,
  });

  final AttributeTmpl? item;
  final Future<AttributeTmplApiResponse> Function(AttributeTmpl) onSave;

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

      setState(() {
        _isLoadingAccessLevels = false;
      });

      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        SnackBar(content: Text('Error fetching access levels: $e')),
      );
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

    setState(() {
      _isSaving = true;
    });

    try {
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

      final response = await widget.onSave(tmpl);

      if (!mounted) return;

      if (!response.success) {
        setState(() {
          _isSaving = false;
        });
        final errorMsg = response.message ?? 'Could not save attribute template.';
        ScaffoldMessenger.maybeOf(context)?.showSnackBar(
          SnackBar(
            backgroundColor: Colors.red.shade100,
            duration: const Duration(seconds: 4),
            showCloseIcon: true,
            closeIconColor: Colors.red.shade500,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            content: Row(
              children: [
                Expanded(
                  child: SelectableText(
                    errorMsg,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red.shade900),
                  ),
                ),
                IconButton(
                  tooltip: 'Copy',
                  icon: Icon(
                    Icons.copy,
                    color: Colors.red.shade700,
                    size: 18,
                  ),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: errorMsg));
                  },
                ),
              ],
            ),
          ),
        );
        return;
      }

      // Success path:
      // Parent handles closing the modal and refreshing the list.
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    } catch (e) {
      debugPrint('AttributeTemplateForm.onSave error: $e');

      if (!mounted) return;

      setState(() {
        _isSaving = false;
      });

      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        const SnackBar(
          content: Text('Unexpected error while saving attribute template.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name *',
                hintText: 'Required',
              ),
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
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
            const SizedBox(height: 12),
            _isLoadingAccessLevels
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : DropdownButtonFormField<int>(
                    initialValue: selectedAccessLevelId,
                    decoration: const InputDecoration(
                      labelText: 'Access Level *',
                    ),
                    items: accessLevels
                        .map(
                          (level) => DropdownMenuItem(
                            value: level.id,
                            child: Text(level.name),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
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
                  ),
            const SizedBox(height: 12),
            DropdownButtonFormField<AttributeValueType>(
              initialValue: selectedType,
              decoration: const InputDecoration(
                labelText: 'Value type *',
              ),
              items: AttributeValueType.values
                  .map(
                    (type) => DropdownMenuItem(
                      value: type,
                      child: Text(type.label),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  selectedType = value;
                  defaultValueController.clear();
                  defaultBooleanValue = false;
                });
              },
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
                setState(() {
                  isRequired = value ?? false;
                });
              },
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: _isSaving ? null : onSave,
                color: Theme.of(context).primaryColor,
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
    );
  }
}
