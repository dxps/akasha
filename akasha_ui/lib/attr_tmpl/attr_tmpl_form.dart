import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_ui/main.dart';
import 'package:akasha_ui/model/attr_value_type.dart';
import 'package:akasha_ui/theming/colors.dart';
import 'package:akasha_ui/theming/theme_cubit.dart';
import 'package:akasha_ui/utils/date_time.dart';
import 'package:akasha_ui/widgets/datetime_pickers.dart';
import 'package:akasha_ui/widgets/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttributeTemplateForm extends StatefulWidget {
  const AttributeTemplateForm({
    super.key,
    this.item,
    this.onSave,
    this.onRequestEdit,
    this.readOnly = false,
  });

  final AttributeTmpl? item;
  final Future<void> Function(AttributeTmpl)? onSave;
  final VoidCallback? onRequestEdit;
  final bool readOnly;

  @override
  State<AttributeTemplateForm> createState() => _AttributeTemplateFormState();
}

class _AttributeTemplateFormState extends State<AttributeTemplateForm> {
  final formKey = GlobalKey<FormState>();
  final nameFieldKey = GlobalKey<FormFieldState<String>>();
  final accessLevelFieldKey = GlobalKey<FormFieldState<int>>();

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
  bool get _isReadOnly => widget.readOnly;

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
    if (_isReadOnly) return;
    final picked = await DateTimePickers.pickDate(context);
    if (!mounted || picked == null) return;
    defaultValueController.text = formatDateYmd(picked);
  }

  Future<void> pickDateTime() async {
    if (_isReadOnly) return;
    final picked = await DateTimePickers.pickDateTime(context);
    if (!mounted || picked == null) return;
    defaultValueController.text = picked.toIso8601String();
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
          onChanged: _isReadOnly
              ? null
              : (value) {
                  setState(() {
                    defaultBooleanValue = value ?? false;
                  });
                },
        );

      case AttributeValueType.number:
        return TextFormField(
          controller: defaultValueController,
          readOnly: _isReadOnly,
          decoration: const InputDecoration(
            labelText: 'Default value',
            hintText: 'e.g. 42 or 3.14',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: _isReadOnly
              ? null
              : (value) {
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
          readOnly: _isReadOnly,
          selectAllOnFocus: false,
          decoration: const InputDecoration(
            labelText: 'Default value',
            hintText: 'YYYY-MM-DD',
            suffixIcon: Icon(Icons.calendar_today),
          ),
          onTap: _isReadOnly ? null : pickDate,
        );

      case AttributeValueType.dateTime:
        return TextFormField(
          controller: defaultValueController,
          readOnly: _isReadOnly,
          selectAllOnFocus: false,
          decoration: const InputDecoration(
            labelText: 'Default value',
            hintText: 'ISO 8601 date-time',
            suffixIcon: Icon(Icons.schedule),
          ),
          onTap: _isReadOnly ? null : pickDateTime,
        );

      case AttributeValueType.text:
        return TextFormField(
          controller: defaultValueController,
          readOnly: _isReadOnly,
          decoration: const InputDecoration(
            labelText: 'Default value',
          ),
        );
    }
  }

  Future<void> onSave() async {
    if (_isSaving || _isReadOnly || widget.onSave == null) return;

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

      await widget.onSave!(tmpl);
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.read<ThemeCubit>().isDarkMode;

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
                key: nameFieldKey,
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
                onChanged: _isReadOnly ? null : (_) => nameFieldKey.currentState?.validate(),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: descriptionController,
                readOnly: _isReadOnly,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                ),
                maxLines: _isReadOnly ? 1 : null,
                minLines: 1,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  SizedBox(
                    width: 140,
                    child: DropdownMenuFormField<AttributeValueType>(
                      initialSelection: selectedType,
                      label: const Text('Value type *', overflow: TextOverflow.ellipsis),
                      dropdownMenuEntries: AttributeValueType.values
                          .map((type) => DropdownMenuEntry<AttributeValueType>(value: type, label: type.label))
                          .toList(),
                      onSelected: _isReadOnly
                          ? null
                          : (value) {
                              setState(() {
                                selectedType = value ?? AttributeValueType.text;
                                defaultValueController.clear();
                                defaultBooleanValue = false;
                              });
                              formKey.currentState?.validate();
                            },
                      validator: (value) {
                        if (value == null) {
                          return 'Value type is required';
                        }
                        return null;
                      },
                      menuHeight: 220,
                      requestFocusOnTap: false,
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 154,
                    child: _isLoadingAccessLevels
                        ? const Padding(
                            padding: EdgeInsets.all(8),
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
                            width: 170,
                            requestFocusOnTap: false,
                          ),
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
                onChanged: _isReadOnly
                    ? null
                    : (value) {
                        setState(() => isRequired = value ?? false);
                      },
              ),
              const SizedBox(height: 12),
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
    );
  }
}

InputDecoration _dropdownDecoration(String label) {
  return InputDecoration(
    labelText: label,
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
    border: const UnderlineInputBorder(),
    enabledBorder: const UnderlineInputBorder(),
    disabledBorder: const UnderlineInputBorder(),
    focusedBorder: const UnderlineInputBorder(),
  );
}
