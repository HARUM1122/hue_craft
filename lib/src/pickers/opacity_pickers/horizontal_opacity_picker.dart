import 'package:flutter/material.dart';

import '../../painters/thumb_painter.dart';

class HorizontalOpacityPicker extends StatelessWidget {
  const HorizontalOpacityPicker({
    required this.hsvColor,
    this.borderRadius,
    this.customThumbPainter,
    required this.onColorChanged,
    super.key
  });

  final HSVColor hsvColor;
  final double? borderRadius;
  final CustomPainter? customThumbPainter;
  final ValueChanged<HSVColor> onColorChanged;

  void _onDrag(BuildContext context, Offset localPosition) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final double thumbPercent = (localPosition.dx / box.size.width).clamp(0.0, 1.0);
    onColorChanged(hsvColor.withAlpha(thumbPercent));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) => _onDrag(context, details.localPosition),
      onPanUpdate: (details) => _onDrag(context, details.localPosition),
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    hsvColor.toColor().withOpacity(0),
                    hsvColor.toColor().withOpacity(1),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight
                ),
                borderRadius: BorderRadius.circular(borderRadius ?? 0)
              )
            )
          ),
          _buildThumb(),
        ],
      ),
    );
  }

  Widget _buildThumb() {
    return Align(
      alignment: Alignment((2 * hsvColor.alpha) - 1.0, 0.0),
      child: CustomPaint(
        painter: customThumbPainter
        ?? ThumbPainter(
          color: hsvColor.toColor(),
          radius: 12,
          strokeWidth: 3
        )
      )
    );
  }
}