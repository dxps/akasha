import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void showErrorSnackbar(BuildContext context, String errorMsg) {
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
}
