import 'package:flutter/material.dart';

class ThumbPainter extends CustomPainter {
  const ThumbPainter({
    required this.color,
    this.strokeColor,
    required this.radius,
    this.strokeWidth
  });

  final Color color;
  final Color? strokeColor;
  final double radius;
  final double? strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    assert((strokeWidth ?? 0) < radius, " radius must be greater than strokeWidth");
    assert (radius > 0, 'radius must not be smaller than 0');
    assert ((strokeWidth ?? 0) > 0, 'strokeWidth must not be smaller than 0');

    if (strokeWidth != null && strokeWidth != 0) {
      canvas.drawCircle(
        Offset.zero,
        radius,
        Paint()
        ..color = strokeColor ?? const Color(0xFFFFFFFF)
        ..style = PaintingStyle.fill
      );
    }
    canvas.drawCircle(
      Offset.zero,
      radius - (strokeWidth ?? 0),
      Paint()
      ..color = color
      ..style = PaintingStyle.fill
    );
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
