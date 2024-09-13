import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeApp());
} 

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) { 
    return MaterialApp(
      title: 'Tic Tac Toe',
      home: TicTacToeScreen(), 
    );
  }
}

class TicTacToeScreen extends StatefulWidget {
  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  List<List<String?>> board = [];
  bool isXTurn = true;

  @override
  void initState() {
    super.initState();
    resetGame();
  }

  void resetGame() {
    setState(() {
      board = List.generate(3, (index) => List.generate(3, (_) => null));
      isXTurn = true;
    });
  }

  void handleTap(int row, int col) {
    if (board[row][col] == null) {
      setState(() {
        board[row][col] = isXTurn ? 'X' : 'O';
        if (checkWin()) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('${isXTurn ? "X" : "O"} wins!'),
              actions: [
                TextButton(
                  onPressed: () {
                    resetGame();
                    Navigator.of(context).pop();
                  },
                  child: Text('Play Again'),
                ),
              ],
            ),
          );
        } else if (checkDraw()) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Draw!'),
              actions: [
                TextButton(
                  onPressed: () {
                    resetGame();
                    Navigator.of(context).pop();
                  },
                  child: Text('Play Again'),
                ),
              ],
            ),
          );
        } else {
          isXTurn = !isXTurn;
        }
      });
    }
  }

  bool checkWin() {
    for (int i = 0; i < 3; i++) {
      if (board[i][0] != null &&
          board[i][0] == board[i][1] &&
          board[i][1] == board[i][2]) {
        return true;
      }
      if (board[0][i] != null &&
          board[0][i] == board[1][i] &&
          board[1][i] == board[2][i]) {
        return true;
      }
    }

    if (board[0][0] != null &&
        board[0][0] == board[1][1] &&
        board[1][1] == board[2][2]) {
      return true;
    }
    if (board[0][2] != null &&
        board[0][2] == board[1][1] &&
        board[1][1] == board[2][0]) {
      return true;
    }

    return false;
  }

  bool checkDraw() {
    return board.every((row) => row.every((cell) => cell != null));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildBoard(),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: resetGame,
            child: Text('Reset Game'),
          ),
        ],
      ),
    );
  }

  Widget _buildBoard() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (row) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (col) {
            return _buildCell(row, col);
          }),
        );
      }),
    );
  }

  Widget _buildCell(int row, int col) {
    return GestureDetector(
      onTap: () => handleTap(row, col),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Center(
          child: Text(
            board[row][col] ?? '',
            style: TextStyle(fontSize: 32),
          ),
        ),
      ),
    );
  }
}
