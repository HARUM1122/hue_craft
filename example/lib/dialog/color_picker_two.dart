import 'package:flutter/material.dart';

import 'package:hue_craft/hue_craft.dart';

class ColorPickerTwoDialog extends StatefulWidget {
  const ColorPickerTwoDialog({super.key});

  @override
  State<ColorPickerTwoDialog> createState() => _ColorPickerTwoDialogState();
}

class _ColorPickerTwoDialogState extends State<ColorPickerTwoDialog> {
  HSVColor _color = HSVColor.fromColor(const Color(0xFFFF1100));

  void _onColorChanged(HSVColor newColor) {
    setState(() => _color = newColor);
  }
  
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0XFF1C1D23),
          borderRadius: BorderRadius.circular(12)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pick a Color',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 16,
                fontWeight: FontWeight.w700
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 180,
                    child: SaturationValuePicker(
                      hsvColor: _color,
                      borderRadius: BorderRadius.circular(6),
                      onColorChanged: _onColorChanged
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 15,
                  height: 170,
                  child: VerticalHuePicker(
                    hsvColor: _color,
                    borderRadius: 12,
                    onColorChanged: _onColorChanged
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 15,
                  height: 170,
                  child: VerticalOpacityPicker(
                    hsvColor: _color,
                    borderRadius: 12,
                    onColorChanged: _onColorChanged
                  ),
                ),
              ]
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: _color.toColor(),
                      border: Border.all(
                        color: Colors.white,
                        width: 0.5
                      ),
                      borderRadius: BorderRadius.circular(4)
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 0.5
                      ),
                      borderRadius: BorderRadius.circular(4)
                    ),
                    child: Center(
                      child: Text(
                        "#${hsvToHex(_color, alpha: true)}",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xFFFFFFFF)
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}