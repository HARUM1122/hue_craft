# hue_craft
A simple package for building custom color pickers
## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Example
Here's a simple example of it

```dart
import 'package:flutter/material.dart';
import 'package:hue_craft/hue_craft.dart'; // Import the package

void main()=>runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Home()
    );
  }
}

class Home extends StatefulWidget {
  Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HSVColor color = const HSVColor.fromAHSV(1.0, 0.0, 1.0, 1.0);
  @override
  Widget build( BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Color picker example")
      ),
      body:Center(
        child: Column(
          children: [
            const SizedBox(height:30),
            SizedBox(
              width:MediaQuery.of(context).size.width-50,
              height:MediaQuery.of(context).size.height/2.5,
              child:SvPicker( // Widget for picking saturation and value
                hsvColor: color, 
                onSelected: (hsvColor){
                  setState((){
                    color = hsvColor;
                  });
                }
              )
            ),
            const SizedBox(height:20),
            SizedBox(
              width:MediaQuery.of(context).size.width-50,
              height:MediaQuery.of(context).size.height/24,
              child:HorizontalHuePicker( // For picking the actual color
                hsvColor: color,
                border:Border.all(
                  color:Colors.black
                ),
                borderRadius: BorderRadius.circular(4),
                selectorWidth: 14,
                selectorDecoration:BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.black,width:2),
                  borderRadius: BorderRadius.circular(6)
                ),
                onSelected: (hsvColor){
                  setState((){
                    color = hsvColor;
                  });
                }
              )
            ),
            const SizedBox(height:20),
            SizedBox(
              width:MediaQuery.of(context).size.width-50,
              height:MediaQuery.of(context).size.height/24,
              child:HorizontalOpacityPicker( // For picking the opacity
                hsvColor: color,
                border:Border.all(
                  color:Colors.black
                ),
                borderRadius: BorderRadius.circular(4),
                selectorWidth: 14,
                selectorDecoration:BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.black,width:2),
                  borderRadius: BorderRadius.circular(6)
                ),
                onSelected: (hsvColor){
                  setState((){
                    color = hsvColor;
                  });
                }
              )
            ),
            const SizedBox(height:20),
            Container(
              width:MediaQuery.of(context).size.width-50,
              height:MediaQuery.of(context).size.height/24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border:Border.all(color:Colors.black,width: 2),
                color:hsvToRgb(color)
              ), 
            )
          ],
        ),
      )
    );
  }
}
```
## License