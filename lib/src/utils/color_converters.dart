import 'package:flutter/material.dart';
Color hsvToRgb(HSVColor hsvColor){
  Color color = hsvColor.toColor();
  return Color.fromRGBO(color.red, color.green, color.blue,color.opacity);
}
