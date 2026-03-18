import 'package:akasha_client/akasha_client.dart';
import 'package:flutter/material.dart';

class AddAccessLevelForm extends StatefulWidget {
  const AddAccessLevelForm({
    super.key,
    this.accessLevel,
    required this.onSave,
  });

  final AccessLevel? accessLevel;
  final Future<void> Function(AccessLevel) onSave;

  @override
  State<AddAccessLevelForm> createState() => _AddAccessLevelFormState();
}

class _AddAccessLevelFormState extends State<AddAccessLevelForm> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  bool _isSaving = false;

  bool get _isEditing => widget.accessLevel != null;

  @override
  void initState() {
    super.initState();

    final accessLevel = widget.accessLevel;

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
        id: widget.accessLevel?.id,
        name: nameController.text.trim(),
        description: descriptionController.text.trim().isEmpty ? null : descriptionController.text.trim(),
      );

      await widget.onSave(accessLevel);

      // dxps: Removed
      //if (!mounted) return;
      //Navigator.of(context).pop();
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
    final buttonLabel = _isEditing ? 'Update' : 'Add';

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
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: _isSaving ? null : onSave,
              icon: const Icon(Icons.check),
              label: Text(buttonLabel),
            ),
          ),
        ],
      ),
    );
  }
}
