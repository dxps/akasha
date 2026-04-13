import 'dart:math' as math;

import 'package:akasha_ui/theming/colors.dart';
import 'package:flutter/material.dart';

import 'modal_content.dart';

class DraggableModal extends StatefulWidget {
  const DraggableModal({
    super.key,
    required this.data,
    required this.viewport,
    required this.onTap,
    required this.onClose,
    required this.onDrag,
    this.onResize,
    this.minSize = const Size(300, 220),
  });

  final ModalData data;
  final Size viewport;
  final VoidCallback onTap;
  final VoidCallback onClose;
  final ValueChanged<Offset> onDrag;
  final ValueChanged<Size>? onResize;
  final Size minSize;

  @override
  State<DraggableModal> createState() => _DraggableModalState();
}

class _DraggableModalState extends State<DraggableModal> {
  Offset? _dragStartPointerGlobal;
  Offset? _dragStartOffset;

  Offset? _resizeStartPointerGlobal;
  Size? _resizeStartSize;

  bool _isDragging = false;
  bool _isResizing = false;

  void _startDrag(DragStartDetails details) {
    _dragStartPointerGlobal = details.globalPosition;
    _dragStartOffset = widget.data.offset;
    setState(() => _isDragging = true);
    widget.onTap();
  }

  void _updateDrag(DragUpdateDetails details) {
    if (_dragStartPointerGlobal == null || _dragStartOffset == null) {
      return;
    }

    final Offset delta = details.globalPosition - _dragStartPointerGlobal!;
    widget.onDrag(_dragStartOffset! + delta);
  }

  void _endDrag() {
    _dragStartPointerGlobal = null;
    _dragStartOffset = null;
    if (_isDragging) {
      setState(() => _isDragging = false);
    }
  }

  void _startResize(DragStartDetails details) {
    _resizeStartPointerGlobal = details.globalPosition;
    _resizeStartSize = widget.data.size;
    setState(() => _isResizing = true);
    widget.onTap();
  }

  void _updateResize(DragUpdateDetails details) {
    if (_resizeStartPointerGlobal == null || _resizeStartSize == null) {
      return;
    }

    final Offset delta = details.globalPosition - _resizeStartPointerGlobal!;

    final nextSize = _clampSize(
      Size(_resizeStartSize!.width + delta.dx, _resizeStartSize!.height + delta.dy),
    );

    widget.onResize?.call(nextSize);
  }

  void _endResize() {
    _resizeStartPointerGlobal = null;
    _resizeStartSize = null;
    if (_isResizing) {
      setState(() => _isResizing = false);
    }
  }

  Size _clampSize(Size size) {
    final availableWidth = math.max(0.0, widget.viewport.width - widget.data.offset.dx);
    final availableHeight = math.max(0.0, widget.viewport.height - widget.data.offset.dy);
    final minWidth = math.min(widget.minSize.width, availableWidth);
    final minHeight = math.min(widget.minSize.height, availableHeight);

    return Size(
      size.width.clamp(minWidth, availableWidth).toDouble(),
      size.height.clamp(minHeight, availableHeight).toDouble(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Positioned(
      left: widget.data.offset.dx,
      top: widget.data.offset.dy,
      width: widget.data.size.width,
      height: widget.data.size.height,
      child: Material(
        color: Colors.transparent,
        child: MouseRegion(
          cursor: _isDragging ? SystemMouseCursors.grabbing : SystemMouseCursors.grab,
          child: GestureDetector(
            behavior: HitTestBehavior.deferToChild,
            onTap: widget.onTap,
            onPanStart: _startDrag,
            onPanUpdate: _updateDrag,
            onPanEnd: (_) => _endDrag(),
            onPanCancel: _endDrag,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: isDarkMode ? modalDarkBgColor : Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [BoxShadow(blurRadius: 22, offset: Offset(0, 0), color: Colors.black54)],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: [
                    Container(
                      height: 36,
                      padding: const EdgeInsets.all(0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 14),
                          ),
                          Expanded(
                            child: Text(
                              widget.data.title,
                              style: TextStyle(fontWeight: FontWeight.w400, color: isDarkMode ? darkFgColor : Colors.black87),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: IconButton(
                              tooltip: 'Close',
                              onPressed: widget.onClose,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                              visualDensity: VisualDensity.compact,
                              style: IconButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                              icon: Icon(Icons.close, size: 18, color: isDarkMode ? darkFgFadedColor : lightFgFadedColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Padding(padding: const EdgeInsets.all(12), child: widget.data.child),
                          ),
                          if (widget.onResize != null)
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: MouseRegion(
                                cursor: _isResizing ? SystemMouseCursors.resizeUpLeftDownRight : SystemMouseCursors.resizeUpLeftDownRight,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: widget.onTap,
                                  onPanStart: _startResize,
                                  onPanUpdate: _updateResize,
                                  onPanEnd: (_) => _endResize(),
                                  onPanCancel: _endResize,
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CustomPaint(
                                      painter: _ResizeGripPainter(
                                        color: theme.colorScheme.onSurfaceVariant.withAlpha(_isResizing ? 120 : 55),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ResizeGripPainter extends CustomPainter {
  const _ResizeGripPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < 3; i++) {
      final inset = 5.0 + i * 5.0;
      canvas.drawLine(
        Offset(size.width - inset, size.height - 3),
        Offset(size.width - 3, size.height - inset),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ResizeGripPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
