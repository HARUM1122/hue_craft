import 'package:flutter/material.dart';
import 'package:skein_color_convert/skein_color_convert.dart';
Color hsvToRgb(HSVColor hsvColor){
  Color color = hsvColor.toColor();
  return Color.fromRGBO(color.red, color.green, color.blue,color.opacity);
}
HSVColor rgbToHsv(Color rgb){
  List hsv = convert.rgb.hsv(rgb.red,rgb.green,rgb.blue);
  return HSVColor.fromAHSV(rgb.opacity, hsv[0].toDouble(), hsv[1]/100, hsv[2]/100);
}