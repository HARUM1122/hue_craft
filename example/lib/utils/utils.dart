import 'package:flutter/material.dart';

Future<T?> showDialogBox<T>({required BuildContext context, required Widget child}) {
  return showDialog<T>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(12),
        child: child
      );
  });
}