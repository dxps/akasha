import 'package:flutter/material.dart';

class DraggableDialog extends StatefulWidget {
  const DraggableDialog({
    super.key,
    required this.child,
    this.title,
    this.minWidth,
    this.maxWidth = 640,
    this.padding = const EdgeInsets.all(20),
    this.initialOffset,
    this.showCloseButton = true,
    this.borderRadius = 8,
    this.backgroundColor,
    this.elevation,
    this.leadingIcon = Icons.drag_indicator,
    this.leadingIconSize = 18,
  });

  final Widget child;
  final Widget? title;

  /// Optional minimum width for the dialog.
  /// If null, the dialog can shrink to fit the available space.
  final double? minWidth;

  /// Maximum width for the dialog.
  final double maxWidth;

  final EdgeInsetsGeometry padding;
  final Offset? initialOffset;
  final bool showCloseButton;
  final double borderRadius;
  final Color? backgroundColor;
  final double? elevation;

  final IconData leadingIcon;
  final double leadingIconSize;

  @override
  State<DraggableDialog> createState() => _DraggableDialogState();

  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    Widget? title,
    double? minWidth,
    double maxWidth = 640,
    EdgeInsetsGeometry padding = const EdgeInsets.all(20),
    Offset? initialOffset,
    bool barrierDismissible = true,
    bool showCloseButton = true,
    double borderRadius = 10,
    Color? backgroundColor,
    double? elevation,
    IconData leadingIcon = Icons.drag_indicator,
    double leadingIconSize = 18,
  }) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      pageBuilder: (context, _, _) {
        return SafeArea(
          child: DraggableDialog(
            title: title,
            minWidth: minWidth,
            maxWidth: maxWidth,
            padding: padding,
            initialOffset: initialOffset,
            showCloseButton: showCloseButton,
            borderRadius: borderRadius,
            backgroundColor: backgroundColor,
            elevation: elevation,
            leadingIcon: leadingIcon,
            leadingIconSize: leadingIconSize,
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 120),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ),
          child: child,
        );
      },
    );
  }
}

class _DraggableDialogState extends State<DraggableDialog> {
  Offset? _position;
  Size? _dialogSize;
  bool _hasDragged = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const horizontalMargin = 24.0;
        final availableWidth = (constraints.maxWidth - horizontalMargin).clamp(
          0.0,
          constraints.maxWidth,
        );

        final effectiveMaxWidth = widget.maxWidth.clamp(0.0, availableWidth);
        final effectiveMinWidth = widget.minWidth == null ? 0.0 : widget.minWidth!.clamp(0.0, effectiveMaxWidth);

        final initialWidth = effectiveMinWidth > 0 ? effectiveMinWidth : effectiveMaxWidth;

        _dialogSize ??= Size(initialWidth, 0);

        if (_position == null) {
          if (widget.initialOffset != null) {
            _position = _clampOffset(
              widget.initialOffset!,
              constraints.biggest,
              _dialogSize!,
            );
          } else {
            _position = _centerOffset(
              constraints.biggest,
              _dialogSize!,
            );
          }
        } else {
          _position = _clampOffset(
            _position!,
            constraints.biggest,
            _dialogSize!,
          );
        }

        return Stack(
          children: [
            Positioned(
              left: _position!.dx,
              top: _position!.dy,
              child: _MeasureSize(
                onChange: (size) {
                  if (_dialogSize != size) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (!mounted) return;

                      setState(() {
                        final previousSize = _dialogSize;
                        _dialogSize = size;

                        if (!_hasDragged && widget.initialOffset == null) {
                          _position = _centerOffset(
                            constraints.biggest,
                            size,
                          );
                        } else {
                          _position = _clampOffset(
                            _position!,
                            constraints.biggest,
                            size,
                          );
                        }

                        if (previousSize == size) return;
                      });
                    });
                  }
                },
                child: Material(
                  color: Colors.transparent,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: effectiveMinWidth,
                      maxWidth: effectiveMaxWidth,
                    ),
                    child: Dialog(
                      insetPadding: EdgeInsets.zero,
                      backgroundColor: widget.backgroundColor,
                      elevation: widget.elevation,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          widget.borderRadius,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _DialogDragHandle(
                            title: widget.title,
                            borderRadius: widget.borderRadius,
                            showCloseButton: widget.showCloseButton,
                            leadingIcon: widget.leadingIcon,
                            leadingIconSize: widget.leadingIconSize,
                            onDragUpdate: (details) {
                              setState(() {
                                _hasDragged = true;
                                _position = _clampOffset(
                                  _position! + details.delta,
                                  constraints.biggest,
                                  _dialogSize ?? Size(initialWidth, 0),
                                );
                              });
                            },
                          ),
                          Flexible(
                            child: SingleChildScrollView(
                              padding: widget.padding,
                              child: widget.child,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Offset _centerOffset(Size viewport, Size dialog) {
    return _clampOffset(
      Offset(
        (viewport.width - dialog.width) / 2,
        (viewport.height - dialog.height) / 2,
      ),
      viewport,
      dialog,
    );
  }

  Offset _clampOffset(Offset offset, Size viewport, Size dialog) {
    const visibleMargin = 20.0;

    final maxX = viewport.width - visibleMargin;
    final maxY = viewport.height - visibleMargin;
    final minX = -(dialog.width - visibleMargin);
    final minY = 0.0;

    return Offset(
      offset.dx.clamp(minX, maxX),
      offset.dy.clamp(minY, maxY),
    );
  }
}

class _DialogDragHandle extends StatelessWidget {
  const _DialogDragHandle({
    required this.onDragUpdate,
    required this.borderRadius,
    required this.showCloseButton,
    required this.leadingIcon,
    required this.leadingIconSize,
    this.title,
  });

  final GestureDragUpdateCallback onDragUpdate;
  final Widget? title;
  final double borderRadius;
  final bool showCloseButton;
  final IconData leadingIcon;
  final double leadingIconSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      cursor: SystemMouseCursors.grab,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanUpdate: onDragUpdate,
        child: Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(borderRadius),
            ),
          ),
          child: Row(
            children: [
              Icon(leadingIcon, size: leadingIconSize),
              const SizedBox(width: 8),
              Expanded(
                child: DefaultTextStyle(
                  style: theme.textTheme.titleMedium ?? const TextStyle(),
                  child: title ?? const SizedBox.shrink(),
                ),
              ),
              if (showCloseButton)
                IconButton(
                  tooltip: 'Close',
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: const Icon(Icons.close, size: 20),
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MeasureSize extends StatefulWidget {
  const _MeasureSize({
    required this.onChange,
    required this.child,
  });

  final ValueChanged<Size> onChange;
  final Widget child;

  @override
  State<_MeasureSize> createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<_MeasureSize> {
  Size? _oldSize;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final contextSize = context.size;
      if (contextSize != null && _oldSize != contextSize) {
        _oldSize = contextSize;
        widget.onChange(contextSize);
      }
    });

    return widget.child;
  }
}
