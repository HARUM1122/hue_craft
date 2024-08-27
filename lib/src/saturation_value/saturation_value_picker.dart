import 'package:flutter/material.dart';
import '../utils/typedefs.dart';

class SaturationValuePicker extends StatefulWidget {
  final HSVColor hsvColor;
  final ColorCallback onSelected;
  final BorderRadius? borderRadius;
  final double? selectorWidth;
  final double? selectorHeight;
  final BoxDecoration? selectorDecoration;

  const SaturationValuePicker({
    required this.hsvColor,
    required this.onSelected,
    this.borderRadius,
    this.selectorWidth,
    this.selectorHeight,
    this.selectorDecoration,
    super.key
  });

  @override
  State<SaturationValuePicker> createState() => _SaturationValuePickerState();
}

class _SaturationValuePickerState extends State<SaturationValuePicker> {
  void _onDrag(Offset localPosition) {
    final Offset percentOffset = _calculatePercentOffset(localPosition);
    widget.onSelected(_hsvColorFromPercentOffset(percentOffset));
  }

  Offset _calculatePercentOffset(Offset localPos) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    return Offset(
      (localPos.dx / box.size.width).clamp(0.0, 1.0),
      (1.0 - (localPos.dy / box.size.height)).clamp(0.0, 1.0),
    );
  }
  HSVColor _hsvColorFromPercentOffset(Offset percentOffset) {
    return HSVColor.fromAHSV(
      widget.hsvColor.alpha,
      widget.hsvColor.hue,
      percentOffset.dx,
      percentOffset.dy,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) => _onDrag(details.localPosition),
      onPanUpdate: (details) => _onDrag(details.localPosition),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: widget.borderRadius ?? BorderRadius.zero,
                child: CustomPaint(
                  painter: ColorPickerPainter(hue: widget.hsvColor.hue),
                  size: Size.infinite,
                ),
              ),
              _buildSelector(Size(constraints.maxWidth, constraints.maxHeight)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSelector(Size size) {
    final double saturationPercent = widget.hsvColor.saturation;
    final double darknessPercent = 1.0 - widget.hsvColor.value;
    return Positioned(
      left: size.width * saturationPercent,
      top: size.height * darknessPercent,
      child: FractionalTranslation(
        translation: const Offset(-0.5, -0.5),
        child: Container(
          width: widget.selectorWidth ?? 10,
          height: widget.selectorHeight ?? 10,
          decoration: widget.selectorDecoration ?? BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}

class ColorPickerPainter extends CustomPainter {
  final double hue;
  const ColorPickerPainter({
    required this.hue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Shader lightGradientShader = const LinearGradient(
      colors: [Colors.white, Colors.black],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).createShader(Offset.zero & size);

    final lightPaint = Paint()..shader = lightGradientShader;
    canvas.drawRect(Offset.zero & size, lightPaint);

    final Shader saturationGradientShader = LinearGradient(
      colors: [
        HSVColor.fromAHSV(1.0, hue, 0.0, 1.0).toColor(),
        HSVColor.fromAHSV(1.0, hue, 1.0, 1.0).toColor(),
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).createShader(Offset.zero & size);

    final saturationPaint = Paint()
      ..shader = saturationGradientShader
      ..blendMode = BlendMode.modulate;

    canvas.drawRect(Offset.zero & size, saturationPaint);
  }

  @override
  bool shouldRepaint(ColorPickerPainter oldDelegate) {
    return hue != oldDelegate.hue;
  }
}
