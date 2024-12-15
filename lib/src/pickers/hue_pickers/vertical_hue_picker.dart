import 'package:flutter/material.dart';

import '../../painters/thumb_painter.dart';

class VerticalHuePicker extends StatelessWidget {
  const VerticalHuePicker({
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
    final double thumbPercent = (localPosition.dy / box.size.height).clamp(0.0, 1.0);
    onColorChanged(hsvColor.withHue(thumbPercent * 360));
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
                    const HSVColor.fromAHSV(1.0, 0.0, 1.0, 1.0).toColor(),
                    const HSVColor.fromAHSV(1.0, 51, 1.0, 1.0).toColor(),
                    const HSVColor.fromAHSV(1.0, 102, 1.0, 1.0).toColor(),
                    const HSVColor.fromAHSV(1.0, 153, 1.0, 1.0).toColor(),
                    const HSVColor.fromAHSV(1.0, 204, 1.0, 1.0).toColor(),
                    const HSVColor.fromAHSV(1.0, 255, 1.0, 1.0).toColor(),
                    const HSVColor.fromAHSV(1.0, 306, 1.0, 1.0).toColor(),
                    const HSVColor.fromAHSV(1.0, 360, 1.0, 1.0).toColor(),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                ),
                borderRadius: BorderRadius.circular(borderRadius ?? 0)
              )
            )
          ),
          _buildThumb()
        ],
      ),
    );
  }

  Widget _buildThumb() {
    final double huePercent = hsvColor.hue / 360;
    return Align(
      alignment: Alignment(0.0, (2 * huePercent) - 1.0),
      child: CustomPaint(
        painter: customThumbPainter
        ?? ThumbPainter(
          color: HSVColor.fromAHSV(1.0, hsvColor.hue, 1.0, 1.0).toColor(),
          radius: 12,
          strokeWidth: 3
        )
      )
    );
  }
}