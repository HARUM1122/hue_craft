import 'package:flutter/material.dart';
Color hsvToRgb(HSVColor hsvColor, {bool alpha = true}) {
  Color color = hsvColor.toColor();
  return alpha 
  ? Color.fromARGB(color.alpha, color.red, color.green, color.blue)
  : Color.fromARGB(1, color.red, color.green, color.blue);
}
String hsvToHex(HSVColor hsvColor, {bool alpha = true}) {
  final Color argbColor = hsvColor.toColor();
  String hexString = "";
  final List<int> values = [argbColor.red, argbColor.green, argbColor.blue];
  if (alpha) {
    values.insert(0, argbColor.alpha);
  }
  for(final int v in values) {
    hexString += v.toRadixString(16).padLeft(2,'0');
  }
  return hexString;
}