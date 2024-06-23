import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  final String player1;
  final String player2;

  GameScreen({required this.player1, required this.player2});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<List<String>> _board;
  late String _currentPlayer;
  late String? _winner;
  late bool _gameOver;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    _board = List.generate(3, (_) => List.filled(3, ''));
    _currentPlayer = 'X';
    _winner = null;
    _gameOver = false;
  }

  void _makeMove(int row, int col) {
    if (_board[row][col] == '' && !_gameOver) {
      setState(() {
        _board[row][col] = _currentPlayer;
        if (_checkWinner(row, col)) {
          _winner = _currentPlayer;
          _gameOver = true;
          _showAlertDialog(
              context, _winner == 'X' ? widget.player1 : widget.player2);
        } else if (_isBoardFull()) {
          _gameOver = true;
          _showAlertDialog(context, null);
        } else {
          _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  bool _checkWinner(int row, int col) {
    if (_board[row].every((cell) => cell == _currentPlayer)) {
      return true;
    }

    if (_board.every((row) => row[col] == _currentPlayer)) {
      return true;
    }

    if (_board[0][0] == _currentPlayer &&
        _board[1][1] == _currentPlayer &&
        _board[2][2] == _currentPlayer) {
      return true;
    }

    if (_board[0][2] == _currentPlayer &&
        _board[1][1] == _currentPlayer &&
        _board[2][0] == _currentPlayer) {
      return true;
    }
    return false;
  }

  bool _isBoardFull() {
    return _board.every((row) => row.every((cell) => cell.isNotEmpty));
  }

  Widget _buildCell(int row, int col) {
    return GestureDetector(
      onTap: () => _makeMove(row, col),
      child: Container(
        margin: EdgeInsets.all(3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color.fromARGB(255, 234, 224, 224)),
            color: const Color.fromARGB(255, 255, 205, 221)),
        child: Center(
          child: Text(
            _board[row][col],
            style: TextStyle(
                fontSize: 55,
                fontWeight: FontWeight.bold,
                color: _board[row][col] == "X" ? Colors.white : Colors.black87),
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context, String? winner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Game Over',
            style: TextStyle(
              color: const Color.fromARGB(255, 246, 83, 137),
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'assets/images/image1.png',
                ),
                SizedBox(height: 16),
                Text(
                  winner != null ? 'Winner: $winner' : 'It\'s a Draw!',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 117, 163),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Play Again',
                style: TextStyle(color: Color.fromARGB(255, 255, 7, 118)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _initializeGame();
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/gameBackground.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.only(top: 50, left: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.pink),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 1, right: 10, left: 10, bottom: 10),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 255, 166, 195),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                        offset: Offset(4, 4),
                      ),
                    ],
                  ),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: GridView.builder(
                      padding: EdgeInsets.all(10),
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        int row = index ~/ 3;
                        int col = index % 3;
                        return _buildCell(row, col);
                      },
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Turn : ",
                            style: TextStyle(
                                color: Colors.pink[400],
                                fontFamily: "Times new roman",
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            _currentPlayer == "X"
                                ? widget.player1 + "($_currentPlayer)"
                                : widget.player2 + "($_currentPlayer)",
                            style: TextStyle(
                                fontSize: 25,
                                fontFamily: "Times new roman",
                                fontWeight: FontWeight.w600,
                                color: _currentPlayer == "X"
                                    ? Color.fromARGB(255, 255, 129, 190)
                                    : Color.fromARGB(255, 142, 66, 95)),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _initializeGame();
                          });
                        },
                        child: Text(
                          'Play Again',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 246, 83, 137),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
