import 'dart:math';

enum Direction { up, down, left, right }

class Game2048 {
  List<List<int>> board;
  final int size;

  Game2048(this.size)
      : board = List.generate(size, (_) => List.filled(size, 0));

  void reset() {
    board = List.generate(size, (_) => List.filled(size, 0));
    addRandomTile();
    addRandomTile();
  }

  void addRandomTile() {
    List<Point<int>> emptyTiles = [];
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        if (board[i][j] == 0) {
          emptyTiles.add(Point(i, j));
        }
      }
    }
    if (emptyTiles.isNotEmpty) {
      Point<int> randomTile = emptyTiles[Random().nextInt(emptyTiles.length)];
      board[randomTile.x][randomTile.y] = Random().nextBool() ? 2 : 4;
    }
  }

  void move(Direction direction) {
    switch (direction) {
      case Direction.up:
        for (int j = 0; j < size; j++) {
          List<int> column = [];
          for (int i = 0; i < size; i++) {
            if (board[i][j] != 0) column.add(board[i][j]);
          }
          merge(column);
          for (int i = 0; i < size; i++) {
            board[i][j] = i < column.length ? column[i] : 0;
          }
        }
        break;
      case Direction.down:
        for (int j = 0; j < size; j++) {
          List<int> column = [];
          for (int i = size - 1; i >= 0; i--) {
            if (board[i][j] != 0) column.add(board[i][j]);
          }
          merge(column);
          for (int i = 0; i < size; i++) {
            board[size - 1 - i][j] = i < column.length ? column[i] : 0;
          }
        }
        break;
      case Direction.left:
        for (int i = 0; i < size; i++) {
          List<int> row = [];
          for (int j = 0; j < size; j++) {
            if (board[i][j] != 0) row.add(board[i][j]);
          }
          merge(row);
          for (int j = 0; j < size; j++) {
            board[i][j] = j < row.length ? row[j] : 0;
          }
        }
        break;
      case Direction.right:
        for (int i = 0; i < size; i++) {
          List<int> row = [];
          for (int j = size - 1; j >= 0; j--) {
            if (board[i][j] != 0) row.add(board[i][j]);
          }
          merge(row);
          for (int j = 0; j < size; j++) {
            board[i][size - 1 - j] = j < row.length ? row[j] : 0;
          }
        }
        break;
    }
    addRandomTile();
  }

  void merge(List<int> tiles) {
    for (int i = 0; i < tiles.length - 1; i++) {
      if (tiles[i] == tiles[i + 1]) {
        tiles[i] *= 2;
        tiles.removeAt(i + 1);
        tiles.add(0); // Add a zero at the end to maintain the length
      }
    }
  }

  bool isGameOver() {
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        if (board[i][j] == 0) return false;
        if (i < size - 1 && board[i][j] == board[i + 1][j]) return false;
        if (j < size - 1 && board[i][j] == board[i][j + 1]) return false;
      }
    }
    return true;
  }

  int calculateScore() {
    int maxTile = 0;
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        if (board[i][j] > maxTile) {
          maxTile = board[i][j];
        }
      }
    }
    return maxTile;
  }
}
