import 'dart:math';

import 'package:flutter/material.dart';

import '../models/rgb_model.dart';
import '../models/cmyk_model.dart';

RGB hsvToRgb(HSVColor hsvColor) {
  final Color color = hsvColor.toColor();
  return RGB(
    red: color.red,
    green: color.green,
    blue: color.blue,
    alpha: color.alpha
 );
}

CMYK hsvToCmyk(HSVColor hsvColor) {
  final Color rgbColor = hsvColor.toColor();

  final double r = rgbColor.red / 255.0;
  final double g = rgbColor.green / 255.0;
  final double b = rgbColor.blue / 255.0;
  final int alpha = rgbColor.alpha;

  final double c = 1 - r;
  final double m = 1 - g;
  final double y = 1 - b;
  final double k = min(c, min(m, y));

  final int cyan = k < 1 ? ((c - k) / (1 - k) * 100).round() : 0;
  final int magenta = k < 1 ? ((m - k) / (1 - k) * 100).round() : 0;
  final int yellow = k < 1 ? ((y - k) / (1 - k) * 100).round() : 0;
  final int black = (k * 100).round();

  return CMYK(cyan: cyan, magenta: magenta, yellow: yellow, black: black, alpha: alpha);
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