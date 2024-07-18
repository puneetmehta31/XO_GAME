import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TIC TAC TOE',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:  const TicTacToe(),
    );
  }
}

//working class for the program of the game

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<List<String>> board = List.generate(3, (_) => List.filled(3, ''));

  bool xTurn = true;

  String winner = '';

  void _onTileTap(int row, int col) {
    if (board[row][col] != '' || winner != '') return;

    setState(() {
      board[row][col] = xTurn ? 'X' : 'O';
      xTurn = !xTurn;
      winner = _checkWinner();
    });
  }

  String _checkWinner() {
    for (int i = 0; i < 3; i++) {
      if (board[i][0] != '' &&
          board[i][0] == board[i][1] &&
          board[i][1] == board[i][2]) {
        return board[i][0];
      }
      if (board[0][1] != '' &&
          board[0][1] == board[1][i] &&
          board[1][i] == board[2][i]) {
        return board[0][i];
      }
    }

    if (board[0][0] != '' &&
        board[0][0] == board[1][1] &&
        board[1][1] == board[2][2]) {
      return board[0][0];
    }
    if (board[0][2] != '' &&
        board[0][2] == board[1][1] &&
        board[1][1] == board[2][0]) {
      return board[0][2];
    }
    //checking for a draw condition

    if (!board.any((row) => row.any((cell) => cell == ''))) {
      return 'Draw';
    }
    return '';
  }

  void _resetGame() {
    setState(() {
      board = List.generate(3, (_) => List.filled(3, ''));
      xTurn = true;
      winner = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            winner == ''
                ? (xTurn ? 'X\'s turn' : 'O\'s turn')
                : winner == 'Draw'
                    ? 'It \'s a Draw'
                    : 'winner : $winner',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: SizedBox(
              width: 300,
              height: 300,
              child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    int row = index ~/ 3;
                    int col = index % 3;
            
                    return GestureDetector(
                      onTap: () => _onTileTap(row, col),
                      child: Container(
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Colors.blue, Colors.red],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomLeft,
                              ),
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(color: Colors.black26),
                              ]),
                          margin: const EdgeInsets.all(4),
                          child: Center(
                            child: Text(
                              board[row][col],
                              style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                        blurRadius: 10.0,
                                        color: Colors.black26,
                                        offset: Offset(2, 2))
                                  ]),
                            ),
                          )),
                    );
                  }),
            ),
          ),

const SizedBox(height: 20,),

ElevatedButton(
  onPressed: _resetGame, 
  style: ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(
      horizontal: 40,
      vertical: 20,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    )
  ), 
  child: const Text('Reset Game',style: TextStyle(fontSize: 40),),
  )

        ],
      ),
    );
  }
}
