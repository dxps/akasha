import 'package:akasha_client/akasha_client.dart';
import 'package:flutter/material.dart';

class AddAccessLevelForm extends StatefulWidget {
  const AddAccessLevelForm({
    super.key,
    this.item,
    required this.onSave,
  });

  final AccessLevel? item;
  final Future<void> Function(AccessLevel) onSave;

  @override
  State<AddAccessLevelForm> createState() => _AddAccessLevelFormState();
}

class _AddAccessLevelFormState extends State<AddAccessLevelForm> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  bool _isSaving = false;

  bool get _isEdit => widget.item != null;

  @override
  void initState() {
    super.initState();

    final accessLevel = widget.item;

    nameController = TextEditingController(text: accessLevel?.name ?? '');
    descriptionController = TextEditingController(text: accessLevel?.description ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> onSave() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSaving = true);

    try {
      final accessLevel = AccessLevel(
        id: widget.item?.id,
        name: nameController.text.trim(),
        description: descriptionController.text.trim().isEmpty ? null : descriptionController.text.trim(),
      );
      await widget.onSave(accessLevel);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
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
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: _isSaving ? null : onSave,
                color: Theme.of(context).primaryColor,
                icon: const Icon(Icons.save),
                tooltip: _isEdit ? 'Update' : 'Add',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
