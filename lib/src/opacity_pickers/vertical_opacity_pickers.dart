import 'package:flutter/material.dart';
import '../utils/typedefs.dart';

class VerticalOpacityPicker extends StatefulWidget {
  final HSVColor hsvColor;
  final ColorCallback onSelected;
  final Decoration? decoration;
  final double? selectorWidth;
  final double? selectorHeight;
  final EdgeInsets? selectorPadding;
  final BoxDecoration? selectorDecoration;

  const VerticalOpacityPicker({
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
  State<VerticalOpacityPicker> createState() => _VerticalOpacityPickerState();
}

class _VerticalOpacityPickerState extends State<VerticalOpacityPicker> {
  void _onDrag(Offset localPosition) {
    final double sliderPercent = _calculatePercentage(localPosition);
    widget.onSelected(widget.hsvColor.withAlpha(sliderPercent));
  }

  double _calculatePercentage(Offset localPosition) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    return (1.0 - ((localPosition.dy - 4) / (box.size.height - 8))).clamp(0.0, 1.0);
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
              decoration: widget.decoration ??  BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    HSVColor.fromAHSV(1.0, widget.hsvColor.hue, widget.hsvColor.saturation, widget.hsvColor.value).toColor(),
                    HSVColor.fromAHSV(0.0, widget.hsvColor.hue, widget.hsvColor.saturation, widget.hsvColor.value).toColor(),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
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
      alignment: Alignment(0.0, 1.0 - (2 * widget.hsvColor.alpha)),
      child: Container(
        width: widget.selectorWidth ?? double.infinity,
        height: widget.selectorHeight ?? 5,
        decoration: widget.selectorDecoration,
        color: widget.selectorDecoration != null ? null : Colors.white,
      ),
    );
  }
}
