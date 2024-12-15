import 'package:flutter/material.dart';

import '../painters/thumb_painter.dart';
import '../painters/saturation_value_painter.dart';

class SaturationValuePicker extends StatelessWidget {
  const SaturationValuePicker({
    required this.hsvColor,
    this.borderRadius,
    this.customThumbPainter,
    required this.onColorChanged,
    super.key
  });
  
  final HSVColor hsvColor;
  final BorderRadius? borderRadius;
  final CustomPainter? customThumbPainter;
  final ValueChanged<HSVColor> onColorChanged;

  void _onDrag(BuildContext context, Offset localPosition) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset percentOffset = Offset(
      (localPosition.dx / box.size.width).clamp(0.0, 1.0),
      (1.0 - (localPosition.dy / box.size.height)).clamp(0.0, 1.0)
    );
    onColorChanged(_hsvColorFromPercentOffset(percentOffset));
  }

  HSVColor _hsvColorFromPercentOffset(Offset percentOffset) {
    return HSVColor.fromAHSV(
      hsvColor.alpha,
      hsvColor.hue,
      percentOffset.dx,
      percentOffset.dy,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) => _onDrag(context, details.localPosition),
      onPanUpdate: (details) => _onDrag(context, details.localPosition),
      child: LayoutBuilder(
        builder: (_, constraints) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: borderRadius ?? BorderRadius.zero,
                child: CustomPaint(
                  painter: SaturationValuePainter(hsvColor.hue),
                  size: Size.infinite,
                ),
              ),
              _buildThumb(
                Size(
                  constraints.maxWidth,
                  constraints.maxHeight
                )
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildThumb(Size size) {
    final double saturationPercent = hsvColor.saturation;
    final double darknessPercent = 1.0 - hsvColor.value;
    return Positioned(
      left: size.width * saturationPercent,
      top: size.height * darknessPercent,
      child: CustomPaint(
        painter: customThumbPainter 
        ?? ThumbPainter(
          color: HSVColor.fromAHSV(1.0, hsvColor.hue, hsvColor.saturation, hsvColor.value).toColor(),
          radius: 6,
          strokeWidth: 2,
          strokeColor: darknessPercent > 0.5 
          ? const Color(0xFFFFFFFF)
          : const Color(0xFF000000)
        ),
      ),
    );
  }
}