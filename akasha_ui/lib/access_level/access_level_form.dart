import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_ui/theming/colors.dart';
import 'package:akasha_ui/theming/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccessLevelForm extends StatefulWidget {
  const AccessLevelForm({
    super.key,
    this.item,
    this.onSave,
    this.onRequestEdit,
    this.readOnly = false,
  });

  final AccessLevel? item;
  final Future<void> Function(AccessLevel)? onSave;
  final VoidCallback? onRequestEdit;
  final bool readOnly;

  @override
  State<AccessLevelForm> createState() => _AccessLevelFormState();
}

class _AccessLevelFormState extends State<AccessLevelForm> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  bool _isSaving = false;

  bool get _isEdit => widget.item != null;
  bool get _isReadOnly => widget.readOnly;

  @override
  void initState() {
    super.initState();

    final accessLevel = widget.item;
    nameController = TextEditingController(text: accessLevel?.name ?? '');
    descriptionController = TextEditingController(
      text: accessLevel?.description ?? '',
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> onSave() async {
    if (_isReadOnly || widget.onSave == null) {
      return;
    }

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

      await widget.onSave!(accessLevel);
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
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
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
                onChanged: _isReadOnly ? null : (_) => formKey.currentState?.validate(),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: descriptionController,
                readOnly: _isReadOnly,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: 1,
                minLines: 1,
              ),
              const SizedBox(height: 20),
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
