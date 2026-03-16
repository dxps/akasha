import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_flutter/main.dart';
import 'package:akasha_flutter/model/attr_value_type.dart';
import 'package:akasha_flutter/widgets/draggable_dialog.dart';
import 'package:flutter/material.dart';

class AttributeTmplsScreen extends StatefulWidget {
  const AttributeTmplsScreen({super.key});

  @override
  State<AttributeTmplsScreen> createState() => _AttributeTmplsScreenState();
}

class _AttributeTmplsScreenState extends State<AttributeTmplsScreen> {
  List<AttributeTmpl> attributeTmpls = [];

  Future<void> _getAttributeTmpls() async {
    final items = await client.attrTmpls.readAll();
    debugPrint("[_AttributeTmplsScreenState] Got ${items.length} attributeTmpls.");
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("AttributeTmplsScreen"),
            Text("${attributeTmpls.length} entries"),
            if (attributeTmpls.isEmpty)
              Column(
                children: [
                  const SizedBox(height: 20),
                  ElevatedButton(
                    child: const Text("Add"),
                    onPressed: () => _showAddAttributeTemplateDialog(context),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddAttributeTemplateDialog(BuildContext context) async {
    await DraggableDialog.show(
      context,
      barrierDismissible: false,
      title: const Text('Add attribute template'),
      minWidth: 250,
      maxWidth: 400,
      child: const _AddAttributeTemplateForm(),
    );
  }
}

class _AddAttributeTemplateForm extends StatefulWidget {
  const _AddAttributeTemplateForm();

  @override
  State<_AddAttributeTemplateForm> createState() => _AddAttributeTemplateFormState();
}

class _AddAttributeTemplateFormState extends State<_AddAttributeTemplateForm> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final defaultValueController = TextEditingController();

  AttributeValueType selectedType = AttributeValueType.text;
  bool isRequired = false;
  bool? defaultBooleanValue;

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
    if (pickedDate == null) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(now),
    );
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
              value: null,
              child: Text('None'),
            ),
            DropdownMenuItem<bool?>(
              value: true,
              child: Text('True'),
            ),
            DropdownMenuItem<bool?>(
              value: false,
              child: Text('False'),
            ),
          ],
          onChanged: (value) {
            setState(() {
              defaultBooleanValue = value;
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

  void onAdd() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final defaultValue = switch (selectedType) {
      AttributeValueType.boolean => defaultBooleanValue,
      _ => defaultValueController.text.trim().isEmpty ? null : defaultValueController.text.trim(),
    };

    debugPrint(
      'Adding attribute template: '
      'name=${nameController.text.trim()}, '
      'description=${descriptionController.text.trim()}, '
      'type=${selectedType.label}, '
      'defaultValue=$defaultValue, '
      'isRequired=$isRequired',
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
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
          ),
          const SizedBox(height: 12),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
            ),
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
                defaultBooleanValue = null;
              });
            },
          ),
          const SizedBox(height: 12),
          buildDefaultValueField(),
          const SizedBox(height: 8),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.trailing,
            title: const Text('Is required'),
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
            child: FilledButton(
              onPressed: onAdd,
              child: const Text('Add'),
            ),
          ),
        ],
      ),
    );
  }
}
