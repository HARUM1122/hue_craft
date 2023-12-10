import 'package:flutter/material.dart';
import '../../utils/typedefs.dart';
class VerticalHuePicker extends StatefulWidget {
  final HSVColor hsvColor;
  final ColorCallback onSelected;
  final Border? border;
  final BorderRadiusGeometry? borderRadius;
  final double? selectorWidth;
  final double? selectorHeight;
  final EdgeInsets? selectorPadding;
  final BoxDecoration? selectorDecoration;
  const VerticalHuePicker({
    required this.hsvColor,
    required this.onSelected,
    this.border,
    this.borderRadius,
    this.selectorWidth,
    this.selectorHeight,
    this.selectorPadding,
    this.selectorDecoration,
    super.key
  });
  @override
  State<VerticalHuePicker> createState() => _VerticalHuePickerState();
}
class _VerticalHuePickerState extends State<VerticalHuePicker> {
  void _onDragStart(DragStartDetails details){
    final sliderPercent = _calculatePercentage(details.localPosition);
    widget.onSelected(widget.hsvColor.withHue(sliderPercent*360));
  }
  void _onDragUpdate(DragUpdateDetails details){
    final sliderPercent = _calculatePercentage(details.localPosition);
    widget.onSelected(widget.hsvColor.withHue(sliderPercent*360));
  }
  double _calculatePercentage(Offset localPosition){
    final RenderBox box = context.findRenderObject() as RenderBox;
    return((localPosition.dy-4)/(box.size.height-8)).clamp(0.0,1.0);
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart:_onDragStart,
      onPanUpdate:_onDragUpdate,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration:BoxDecoration(
              border: widget.border,
              borderRadius: widget.borderRadius,
              gradient: LinearGradient(
                colors:[
                  const HSVColor.fromAHSV(1.0, 0.0, 1.0, 1.0).toColor(),
                  const HSVColor.fromAHSV(1.0, 51, 1.0, 1.0).toColor(),
                  const HSVColor.fromAHSV(1.0, 102, 1.0, 1.0).toColor(),
                  const HSVColor.fromAHSV(1.0, 153, 1.0, 1.0).toColor(),
                  const HSVColor.fromAHSV(1.0, 204, 1.0, 1.0).toColor(),
                  const HSVColor.fromAHSV(1.0, 255, 1.0, 1.0).toColor(),
                  const HSVColor.fromAHSV(1.0, 306, 1.0, 1.0).toColor(),
                  const HSVColor.fromAHSV(1.0, 360, 1.0, 1.0).toColor(),
                ],
                begin:Alignment.topCenter,
                end:Alignment.bottomCenter,
              )
            ),
          ),
          Padding(
            padding: widget.selectorPadding??EdgeInsets.zero,
            child: _buildSelector(),
          )
        ],
      ),
    );
  }
  Widget _buildSelector(){
    final huePercent = widget.hsvColor.hue/360;
    return Align(
      alignment: Alignment(0.0,2*huePercent-1.0),
      child:Container(
        decoration: widget.selectorDecoration,
        width: widget.selectorWidth??double.infinity,
        height:widget.selectorHeight??5,
        color:widget.selectorDecoration!=null?null:Colors.white
      )
    );
  }
}