import 'package:flutter/material.dart';
import 'game_logic.dart';

class GameBoard extends StatelessWidget {
  final Game2048 game;
  final Map<int, Color> tileColors;

  GameBoard({required this.game, required this.tileColors});

  Color getTileColor(int value) {
    return tileColors[value] ?? Colors.grey[800]!;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: game.size),
      itemCount: game.size * game.size,
      itemBuilder: (context, index) {
        int value = game.board[index ~/ game.size][index % game.size];
        return Container(
          margin: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: getTileColor(value),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              value == 0 ? '' : value.toString(),
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
