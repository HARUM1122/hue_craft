import 'package:flutter/material.dart';
import '../utils/typedefs.dart';

class HorizontalOpacityPicker extends StatefulWidget {
  final HSVColor hsvColor;
  final ColorCallback onSelected;
  final Decoration? decoration;
  final double? selectorWidth;
  final double? selectorHeight;
  final EdgeInsets? selectorPadding;
  final BoxDecoration? selectorDecoration;

  const HorizontalOpacityPicker({
    required this.hsvColor,
    required this.onSelected,
    this.decoration,
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
  void _onDrag(Offset localPosition) {
    final double sliderPercent = _calculatePercentage(localPosition);
    widget.onSelected(widget.hsvColor.withAlpha(sliderPercent));
  }

  double _calculatePercentage(Offset localPosition) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    return (1.0 - ((localPosition.dx - 4) / (box.size.width - 8))).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) => _onDrag(details.localPosition),
      onPanUpdate: (details) => _onDrag(details.localPosition),
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: widget.decoration ?? BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    HSVColor.fromAHSV(1.0, widget.hsvColor.hue, widget.hsvColor.saturation, widget.hsvColor.value).toColor(),
                    HSVColor.fromAHSV(0.0, widget.hsvColor.hue, widget.hsvColor.saturation, widget.hsvColor.value).toColor(),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
          ),
          Padding(
            padding: widget.selectorPadding ?? EdgeInsets.zero,
            child: _buildSelector(),
          ),
        ],
      ),
    );
  }

  Widget _buildSelector() {
    return Align(
      alignment: Alignment(1.0 - (2 * widget.hsvColor.alpha), 0.0),
      child: Container(
        width: widget.selectorWidth ?? 5,
        height: widget.selectorHeight ?? double.infinity,
        decoration: widget.selectorDecoration,
        color: widget.selectorDecoration != null ? null : Colors.black,
      ),
    );
  }
}
