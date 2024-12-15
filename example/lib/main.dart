import 'package:flutter/material.dart';

import 'utils/utils.dart';

import 'dialog/color_picker_one.dart';
import 'dialog/color_picker_two.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Example',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialogBox(
                  context: context,
                  child: const ColorPickerOneDialog()
                );
              },
              child: const Text(
                "Show color picker one"
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showDialogBox(
                  context: context,
                  child: const ColorPickerTwoDialog()
                );
              },
              child: const Text(
                "Show color picker two"
              ),
            )
          ],
        ),
      ),
    );
  }
}
