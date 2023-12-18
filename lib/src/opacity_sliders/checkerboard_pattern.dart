import 'package:flutter/material.dart';
class CheckerBoard extends StatelessWidget {
  const CheckerBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) => Wrap(children: () {
        bool bright = true;
        const double squareSize = 10.0;
        final inAColumn = size.biggest.height ~/ squareSize;
        final inARow = size.biggest.width ~/ squareSize;
        final indexes = List.generate(inAColumn, (i) => inARow * (i + 1));
        return List.generate(
          inAColumn * inARow,
          (index) {
            if (!indexes.contains(index)) bright = !bright;
            return Container(
              color: bright ? Colors.white : Colors.black,
              height: squareSize,
              width: squareSize,
            );
          },
        );
      }()),
    );
  }
}