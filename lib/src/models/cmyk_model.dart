class CMYK {
  CMYK({
    required this.cyan,
    required this.magenta,
    required this.yellow,
    required this.black,
    required this.alpha,
  });

  final int cyan;
  final int magenta;
  final int yellow;
  final int black;
  final int alpha;

  @override
  String toString() => "CMYKA($cyan, $magenta, $yellow, $black, $alpha)";
}