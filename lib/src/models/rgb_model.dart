class RGB {
  RGB({
    required this.red,
    required this.green,
    required this.blue,
    required this.alpha
  });
  
  final int red;
  final int green;
  final int blue;
  final int alpha;

  @override
  String toString() => "RGBA($red, $green, $blue, $alpha)";
}