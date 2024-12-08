import 'package:flutter/material.dart';
import 'color_selection_screen.dart';

class ScoreSelectionScreen extends StatefulWidget {
  const ScoreSelectionScreen({super.key});

  @override
  ScoreSelectionScreenState createState() => ScoreSelectionScreenState();
}

class ScoreSelectionScreenState extends State<ScoreSelectionScreen> {
  int selectedGoal = 2048; // Default goal
  final List<int> scoreGoals = [256, 512, 1024, 2048];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Selectionner le Score à avoir')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Selectionner le score maximum à atteindre:',
              style: TextStyle(fontSize: 24, color: Colors.black), // Text color
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.white, // Background color of the dropdown
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: DropdownButtonFormField<int>(
                value: selectedGoal,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: const TextStyle(
                    color: Colors.black), // Text color inside the dropdown
                dropdownColor: Colors.white,
                items: scoreGoals.map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedGoal = newValue!;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ColorSelectionScreen(selectedGoal: selectedGoal),
                  ),
                );
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
