# hue_craft
A simple package for building custom color pickers in flutter

## Example

```dart
import 'package:flutter/material.dart';

import 'package:hue_craft/hue_craft.dart'; // Import the package

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HSVColor _color = const HSVColor.fromAHSV(1.0, 0.0, 1.0, 1.0); // initial color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Color picker example"),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              height: MediaQuery.of(context).size.height / 2.5,
              child: SaturationValuePicker(
                hsvColor: _color,
                onSelected: (hsvColor) {
                  setState(() {
                    _color = hsvColor;
                    print("RGB: ${hsvToRgb(hsvColor).toString()}");
                    print("CMYK: ${hsvToCmyk(hsvColor).toString()}");
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              height: MediaQuery.of(context).size.height / 24,
              child: HorizontalHuePicker( // You can also use Vertical one
                hsvColor: _color,
                selectorWidth: 14,
                selectorDecoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(6),
                ),
                onSelected: (hsvColor) {
                  setState(() {
                    _color = hsvColor;
                    print("RGB: ${hsvToRgb(hsvColor).toString()}");
                    print("CMYK: ${hsvToCmyk(hsvColor).toString()}");
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              height: MediaQuery.of(context).size.height / 24,
              child: HorizontalOpacityPicker( // You can also use Vertical one
                hsvColor: _color,
                selectorWidth: 14,
                selectorDecoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(6),
                ),
                onSelected: (hsvColor) {
                  setState(() {
                    _color = hsvColor;
                    print("RGB: ${hsvToRgb(hsvColor).toString()}");
                    print("CMYK: ${hsvToCmyk(hsvColor).toString()}");
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width - 50,
              height: MediaQuery.of(context).size.height / 24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.black, width: 2),
                color: _color.toColor()
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```