import 'package:akasha_client/akasha_client.dart';
import 'package:akasha_ui/theming/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccessLevelRow extends StatefulWidget {
  const AccessLevelRow({
    super.key,
    required this.level,
    required this.nameText,
    required this.descriptionText,
    this.height = 28,
    this.nameWidth = 200,
    this.descriptionWidth = 300,
    this.menuWidth = 30,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
  });

  final AccessLevel level;
  final String nameText;
  final String descriptionText;
  final double height;
  final double nameWidth;
  final double descriptionWidth;
  final double menuWidth;
  final VoidCallback onView;
  final VoidCallback onEdit;
  final Future<void> Function() onDelete;

  @override
  State<AccessLevelRow> createState() => _AccessLevelRowState();
}

class _AccessLevelRowState extends State<AccessLevelRow> {
  bool _isHovered = false;

  Future<void> _openContextualMenu(BuildContext context) async {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(
          button.size.bottomRight(Offset.zero),
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );

    final isDarkMode = context.read<ThemeCubit>().isDarkMode;
    final result = await showMenu<String>(
      context: context,
      position: position,
      color: isDarkMode ? Colors.grey.shade900 : Colors.white,
      clipBehavior: Clip.antiAlias,
      menuPadding: const EdgeInsets.symmetric(vertical: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      items: [
        PopupMenuItem(
          value: 'edit',
          height: 32,
          child: Text('Edit'),
        ),
        PopupMenuItem(
          value: 'delete',
          height: 32,
          child: Text('Delete'),
        ),
      ],
    );

    if (!mounted || result == null) return;

    switch (result) {
      case 'edit':
        widget.onEdit();
        break;
      case 'delete':
        await widget.onDelete();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ThemeCubit, ThemeMode, bool>(
      selector: (themeMode) => themeMode == ThemeMode.dark,
      builder: (context, isDarkMode) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: Container(
            height: widget.height,
            decoration: BoxDecoration(
              color: _isHovered ? (isDarkMode ? Colors.grey.shade700 : Colors.white) : Colors.transparent,
              border: Border(
                bottom: BorderSide(width: 0.25, color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade200),
              ),
              borderRadius: _isHovered ? BorderRadius.circular(6) : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: widget.onView,
                  child: Row(
                    children: [
                      SizedBox(
                        width: widget.nameWidth,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          child: Text(widget.nameText),
                        ),
                      ),
                      SizedBox(
                        width: widget.descriptionWidth,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          child: Text(widget.descriptionText),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: widget.menuWidth,
                  child: Builder(
                    builder: (context) => IconButton(
                      icon: Icon(
                        Icons.more_vert,
                        size: 15,
                        color: _isHovered ? Colors.grey[800] : Colors.grey[400],
                      ),
                      onPressed: () => _openContextualMenu(context),
                      tooltip: 'Actions',
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
