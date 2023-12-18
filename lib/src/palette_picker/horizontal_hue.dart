import 'package:flutter/material.dart';
import '../utils/typedefs.dart';
class HorizontalHuePicker extends StatefulWidget {
  final HSVColor hsvColor;
  final ColorCallback onSelected;
  final Border? border;
  final BorderRadiusGeometry? borderRadius;
  final double? selectorWidth;
  final double? selectorHeight;
  final EdgeInsets? selectorPadding; 
  final BoxDecoration? selectorDecoration;
  const HorizontalHuePicker({
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
  State<HorizontalHuePicker> createState() => _HorizontalHuePickerState();
}
class _HorizontalHuePickerState extends State<HorizontalHuePicker> {
  void _onDrag(Offset localPosition){
    final sliderPercent = _calculatePercentage(localPosition);
    widget.onSelected(widget.hsvColor.withHue(sliderPercent*360));
  }
  double _calculatePercentage(Offset localPosition){
    final RenderBox box = context.findRenderObject() as RenderBox;
    return((localPosition.dx-4)/(box.size.width-8)).clamp(0.0,1.0);
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart:(details)=>_onDrag(details.localPosition),
      onPanUpdate:(details)=>_onDrag(details.localPosition),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration:BoxDecoration(
              border:widget.border,
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
                begin:Alignment.centerLeft,
                end:Alignment.centerRight,
              )
            ),
          ),
          Padding(
            padding: widget.selectorPadding??EdgeInsets.zero,
            child: _buildSelector()
          )
        ],
      ),
    );
  }
  Widget _buildSelector(){
    final huePercent = widget.hsvColor.hue/360;
    return Align(
      alignment: Alignment(2*huePercent-1.0,0.0),
      child:Container(
        decoration: widget.selectorDecoration,
        width: widget.selectorWidth??5,
        height:widget.selectorHeight??double.infinity,
        color:widget.selectorDecoration!=null?null:Colors.white
      )
    );
  }
}