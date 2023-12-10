import 'package:flutter/material.dart';
typedef ColorCallback = void Function(HSVColor newColor);
class SvPicker extends StatefulWidget {
  final HSVColor hsvColor;
  final ColorCallback onSelected;
  final BorderRadius? borderRadius;
  final double? selectorWidth;
  final double? selectorHeight;
  final BoxDecoration? decoration;
  const SvPicker({
    required this.hsvColor,
    required this.onSelected,
    this.borderRadius,
    this.selectorWidth,
    this.selectorHeight,
    this.decoration,
    super.key
  });
  @override
  State<SvPicker> createState() => _SvPickerState();
}

class _SvPickerState extends State<SvPicker> {
  void _onDragStart(DragStartDetails details){
    final percentOffset = _calculatePercentOffset(details.localPosition);
    widget.onSelected(_hsvColorFromPercentOffset(percentOffset));
  }
  void _onDragUpdate(DragUpdateDetails details){
    final percentOffset = _calculatePercentOffset(details.localPosition);
    widget.onSelected(_hsvColorFromPercentOffset(percentOffset));
  }
  Offset _calculatePercentOffset(Offset localPos){
    final RenderBox box = context.findRenderObject() as RenderBox;
    return Offset(
      (localPos.dx/box.size.width).clamp(0.0,1.0),
      (1.0-(localPos.dy/box.size.height)).clamp(0.0,1.0)
    );
  }
  HSVColor _hsvColorFromPercentOffset(Offset percentOffset){
    return HSVColor.fromAHSV(widget.hsvColor.alpha,widget.hsvColor.hue, percentOffset.dx, percentOffset.dy);
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart:_onDragStart,
      onPanUpdate: _onDragUpdate,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: widget.borderRadius??BorderRadius.zero,
                child: CustomPaint(
                  painter:ColorPickerPainter(
                    hue:widget.hsvColor.hue
                  ),
                  size:Size.infinite
                ),
              ),
              _buildSelector(Size(constraints.maxWidth,constraints.maxHeight))
            ],
          );
        }
      ),
    );
  }
  Widget _buildSelector(Size size){
    final double saturationPercent = widget.hsvColor.saturation;
    final double darknessPercent = 1.0-widget.hsvColor.value;
    return Positioned(
      left:size.width*saturationPercent,
      top:size.height*darknessPercent,
      child:FractionalTranslation(
        translation: const Offset(-0.5,-0.5),
        child: Container(
          width:widget.selectorWidth??10,
          height:widget.selectorHeight??10,
          decoration: widget.decoration??BoxDecoration(
            shape:BoxShape.circle,
            border:Border.all(
              color:Colors.black,
              width:2
            )
          ),
        ),
      )
    );
  }
}
// COLOR PICKER PAINTER
class ColorPickerPainter extends CustomPainter{
  double hue;
  ColorPickerPainter({
    required this.hue
  });
  @override
  void paint(Canvas canvas, Size size) {
    final Shader lightGradientShader = const LinearGradient(
      colors:[Colors.white,Colors.black],
      begin:Alignment.topCenter,
      end:Alignment.bottomCenter
    ).createShader(Offset.zero & size);
    final lightPaint = Paint()..shader = lightGradientShader;
    canvas.drawRect(Offset.zero & size, lightPaint);
    final Shader saturationGradientShader = LinearGradient(
      colors:[
        HSVColor.fromAHSV(1.0, hue, 0.0, 1.0).toColor(),
        HSVColor.fromAHSV(1.0, hue, 1.0, 1.0).toColor()
      ],
      begin:Alignment.centerLeft,
      end:Alignment.centerRight
    ).createShader(Offset.zero & size);
    final saturationPaint = Paint()..shader = saturationGradientShader..blendMode = BlendMode.modulate;
    canvas.drawRect(Offset.zero & size, saturationPaint);
  }
  @override
  bool shouldRepaint(ColorPickerPainter oldDelegate) {
    return hue!=oldDelegate.hue;
  }
}
