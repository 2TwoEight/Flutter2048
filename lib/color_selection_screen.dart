import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'game_screen.dart';

class ColorSelectionScreen extends StatefulWidget {
  final int selectedGoal;

  const ColorSelectionScreen({Key? key, required this.selectedGoal})
      : super(key: key);

  @override
  _ColorSelectionScreenState createState() => _ColorSelectionScreenState();
}

class _ColorSelectionScreenState extends State<ColorSelectionScreen> {
  final Map<int, Color> tileColors = {
    2: Colors.blue[100]!,
    4: Colors.blue[200]!,
    8: Colors.blue[300]!,
    16: Colors.blue[400]!,
    32: Colors.blue[500]!,
    64: Colors.blue[600]!,
    128: Colors.blue[700]!,
    256: Colors.blue[800]!,
    512: Colors.blue[900]!,
    1024: Colors.orange[700]!,
    2048: Colors.orange[900]!,
  };

  void selectColor(int tileValue) async {
    Color? selectedColor = await showDialog<Color>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selectionner la couleur pour la tuile $tileValue'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: tileColors[tileValue]!,
              onColorChanged: (Color color) {
                Navigator.of(context).pop(color);
              },
            ),
          ),
        );
      },
    );

    if (selectedColor != null) {
      setState(() {
        tileColors[tileValue] = selectedColor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Selectionner les couleurs de tuiles')),
      body: ListView(
        children: tileColors.keys.map((tileValue) {
          return ListTile(
            title: Text(
              'Tuile $tileValue',
              style: TextStyle(color: Colors.black), // Text color set to white
            ),
            trailing: Container(
              width: 24,
              height: 24,
              color: tileColors[tileValue],
            ),
            onTap: () => selectColor(tileValue),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GameScreen(
                  selectedGoal: widget.selectedGoal, tileColors: tileColors),
            ),
          );
        },
      ),
    );
  }
}
