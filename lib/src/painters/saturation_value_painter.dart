import 'package:flutter/material.dart';

class SaturationValuePainter extends CustomPainter {
  const SaturationValuePainter(this.hue);
  
  final double hue;

  @override
  void paint(Canvas canvas, Size size) {
    final Shader lightGradientShader = const LinearGradient(
      colors: [Colors.white, Colors.black],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).createShader(Offset.zero & size);

    canvas.drawRect(Offset.zero & size, Paint()..shader = lightGradientShader);
    final Shader saturationGradientShader = LinearGradient(
      colors: [
        HSVColor.fromAHSV(1.0, hue, 0.0, 1.0).toColor(),
        HSVColor.fromAHSV(1.0, hue, 1.0, 1.0).toColor(),
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).createShader(Offset.zero & size);
    canvas.drawRect(
      Offset.zero & size, 
      Paint()
      ..shader = saturationGradientShader
      ..blendMode = BlendMode.modulate
    );
  }

  @override
  bool shouldRepaint(SaturationValuePainter oldDelegate) {
    return hue != oldDelegate.hue;
  }
}