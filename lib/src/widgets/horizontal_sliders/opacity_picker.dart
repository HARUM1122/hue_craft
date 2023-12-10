import 'package:flutter/material.dart';
import '../../utils/typedefs.dart';
class HorizontalOpacityPicker extends StatefulWidget {
  final HSVColor hsvColor;
  final ColorCallback onSelected;
  final Border? border;
  final BorderRadiusGeometry? borderRadius;
  final double? selectorWidth;
  final double? selectorHeight;
  final EdgeInsets? selectorPadding;
  final BoxDecoration? selectorDecoration;
  const HorizontalOpacityPicker({
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
  State<HorizontalOpacityPicker> createState() => _HorizontalOpacityPickerState();
}
class _HorizontalOpacityPickerState extends State<HorizontalOpacityPicker> {
  void _onDragStart(DragStartDetails details){
    final sliderPercent = _calculatePercentage(details.localPosition);
    widget.onSelected(widget.hsvColor.withAlpha(sliderPercent));
  }
  void _onDragUpdate(DragUpdateDetails details){
    final sliderPercent = _calculatePercentage(details.localPosition);
    widget.onSelected(widget.hsvColor.withAlpha(sliderPercent));
  }
  double _calculatePercentage(Offset localPosition){
    final RenderBox box = context.findRenderObject() as RenderBox;
    return(1.0-((localPosition.dx-4)/(box.size.width-8))).clamp(0.0,1.0);
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
            decoration: BoxDecoration(
              image:const DecorationImage(
                image:AssetImage('assets/images/checker_board_pattern.jpg'),
                fit:BoxFit.cover
              ),
              borderRadius:widget.borderRadius
            ),
            child: Container(
              decoration:BoxDecoration(
                border:widget.border,
                borderRadius: widget.borderRadius,
                gradient: LinearGradient(
                  colors:[
                    HSVColor.fromAHSV(1.0,widget.hsvColor.hue, widget.hsvColor.saturation, widget.hsvColor.value).toColor(),
                    HSVColor.fromAHSV(0.0,widget.hsvColor.hue, widget.hsvColor.saturation, widget.hsvColor.value).toColor(),
                  ],
                  begin:Alignment.centerLeft,
                  end:Alignment.centerRight,
                ),
              ),
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
    return Align(
      alignment: Alignment(1.0-(2*widget.hsvColor.alpha),0.0),
      child:Container(
        decoration: widget.selectorDecoration,
        width: widget.selectorWidth??5,
        height:widget.selectorHeight??double.infinity,
        color:widget.selectorDecoration!=null?null:Colors.white
      )
    );
  }
}