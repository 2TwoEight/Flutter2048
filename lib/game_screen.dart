import 'package:flutter/material.dart';
import 'game_board.dart';
import 'game_logic.dart';

class GameScreen extends StatefulWidget {
  final int selectedGoal;
  final Map<int, Color> tileColors;

  const GameScreen(
      {Key? key, required this.selectedGoal, required this.tileColors})
      : super(key: key);

  @override
  GameScreenState createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  late Game2048 game;
  int score = 0;
  int moves = 0;

  @override
  void initState() {
    super.initState();
    game = Game2048(4);
    game.reset();
  }

  void onSwipe(Direction direction) {
    setState(() {
      game.move(direction);
      score = game.calculateScore();
      moves++;
      if (game.isGameOver() || score >= widget.selectedGoal) {
        showGameOverDialog();
      }
    });
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              score >= widget.selectedGoal ? "Bravo!" : "Game Over"),
          content: Text(score >= widget.selectedGoal
              ? "Vous avez atteint ${widget.selectedGoal} points! Votre score: $score"
              : "Plus de mouvement possible. Votre socre: $score"),
          actions: [
            TextButton(
              child: Text("Restart"),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  game.reset();
                  score = 0;
                  moves = 0;
                });
              },
            ),
          ],
        );
      },
    );
  }

  void resetGame() {
    setState(() {
      game.reset();
      score = 0;
      moves = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('2048 Game')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Coups: $moves',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  'Score: $score',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                IconButton(
                  icon: Icon(Icons.refresh),
                  iconSize: 32,
                  onPressed: resetGame,
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: GameBoard(game: game, tileColors: widget.tileColors),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_upward),
                  iconSize: 48,
                  onPressed: () => onSwipe(Direction.up),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 48,
                      onPressed: () => onSwipe(Direction.left),
                    ),
                    SizedBox(width: 20),
                    IconButton(
                      icon: Icon(Icons.arrow_forward),
                      iconSize: 48,
                      onPressed: () => onSwipe(Direction.right),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 48,
                  onPressed: () => onSwipe(Direction.down),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
