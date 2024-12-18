import 'package:flutter/material.dart';
import 'package:games/features/ticTacToe/home/presentation/widgets/button_tic_tac_toe_widget.dart';
import 'package:games/features/ticTacToe/home/presentation/widgets/winning_line_painter_widget.dart';

class TicTacToePage extends StatefulWidget {
  const TicTacToePage({super.key});

  @override
  State<TicTacToePage> createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage> {
  List<List<String?>> board = [
    [null, null, null],
    [null, null, null],
    [null, null, null],
  ];

  final String player1 = "Willian";
  final String player2 = "Carlos";
  final String player1Type = "X";
  final String player2Type = "O";

  String currentPlayer = 'X';
  List<int>? winningLine;
  int? draggingPiece;

  int get xCount =>
      board.expand((row) => row).where((cell) => cell == 'X').length;
  int get oCount =>
      board.expand((row) => row).where((cell) => cell == 'O').length;

  bool get canAddNewPiece => xCount < 3 || oCount < 3;

  void _onCellPress(int row, int col) {
    if (board[row][col] == null && canAddNewPiece) {
      setState(() {
        board[row][col] = currentPlayer;
        currentPlayer = (currentPlayer == 'X') ? player2Type : player1Type;
      });

      winnerCheck();
    }
  }

  void winnerCheck() {
    checkLines();
    checkColumns();
    checkMainDiagonal();
    checkSecondaryDiagonal();
    checkDraw();
  }

  void checkLines() {
    for (int i = 0; i < 3; i++) {
      final String? Line0 = board[i][0];
      final String? Line1 = board[i][1];
      final String? Line2 = board[i][2];

      if (Line0 != null && Line0 == Line1 && Line1 == Line2) {
        setState(() {
          winningLine = [i * 3, i * 3 + 2];
        });
        print('Player ${board[i][0]} venceu!');
        return;
      }
    }
  }

  void checkColumns() {
    for (int i = 0; i < 3; i++) {
      final String? column0 = board[0][i];
      final String? column1 = board[1][i];
      final String? column2 = board[2][i];

      if (column0 != null && column0 == column1 && column1 == column2) {
        setState(() {
          winningLine = [i, i + 6];
        });

        return;
      }
    }
  }

  void checkMainDiagonal() {
    final String? diagonalMain0 = board[0][0];
    final String? diagonalMain1 = board[1][1];
    final String? diagonalMain2 = board[2][2];

    if (diagonalMain0 != null &&
        diagonalMain0 == diagonalMain1 &&
        diagonalMain1 == diagonalMain2) {
      setState(() {
        winningLine = [0, 8];
      });

      return;
    }
  }

  void checkSecondaryDiagonal() {
    final String? diagonalSecondary0 = board[0][2];
    final String? diagonalSecondary1 = board[1][1];
    final String? diagonalSecondary2 = board[2][0];

    if (diagonalSecondary0 != null &&
        diagonalSecondary0 == diagonalSecondary1 &&
        diagonalSecondary1 == diagonalSecondary2) {
      setState(() {
        winningLine = [2, 6];
      });

      return;
    }
  }

  void checkDraw() {
    if (board.every((row) => row.every((cell) => cell != null))) {
      return;
    }
  }

  void resetGame() {
    setState(() {
      board = [
        [null, null, null],
        [null, null, null],
        [null, null, null],
      ];
      currentPlayer = 'X';
      winningLine = null;
      draggingPiece = null;
    });
  }

  void _onDragEnd(int row, int col) {
    if (draggingPiece != null && board[row][col] == null) {
      final startRow = draggingPiece! ~/ 3;
      final startCol = draggingPiece! % 3;

      setState(() {
        board[row][col] = currentPlayer;
        currentPlayer = (currentPlayer == 'X') ? player2Type : player1Type;
        board[startRow][startCol] = null;
        winnerCheck();
      });
    }
    draggingPiece = null;
  }

  void _onDragStart(int row, int col) {
    if (board[row][col] == currentPlayer) {
      draggingPiece = row * 3 + col;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 237, 237),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Stack(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      int row = index ~/ 3;
                      int col = index % 3;
                      return DragTarget<int>(
                        onAcceptWithDetails: (details) {
                          _onDragEnd(row, col);
                        },
                        builder: (context, candidateData, rejectedData) {
                          return Draggable<int>(
                            data: index,
                            feedback: ButtonTicTacToe(
                              typeButton: board[row][col],
                              onPressed: () {},
                            ),
                            childWhenDragging: ButtonTicTacToe(
                              typeButton: null,
                              onPressed: () {},
                            ),
                            child: ButtonTicTacToe(
                              typeButton: board[row][col],
                              onPressed: () => _onCellPress(row, col),
                            ),
                            onDragStarted: () {
                              _onDragStart(
                                row,
                                col,
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                  if (winningLine != null)
                    Positioned.fill(
                      child: CustomPaint(
                        painter: WinningLinePainter(winningLine!),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PlayerWidget(
                    typeButton: player1Type,
                    currentPlayer: currentPlayer,
                    namePlayer: player1,
                    image:
                        "https://toyshopping.com.br/blog/wp-content/uploads/2021/12/Naruto-Classico-e-Naruto-Shippuden-fillers-1024x576.jpg",
                  ),
                  PlayerWidget(
                    typeButton: player2Type,
                    currentPlayer: currentPlayer,
                    namePlayer: player2,
                    image:
                        "https://pop.proddigital.com.br/wp-content/uploads/sites/8/2024/04/01-32.jpg",
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: resetGame,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  'Recomeçar Jogo',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlayerWidget extends StatelessWidget {
  final String typeButton;
  final String currentPlayer;
  final String namePlayer;
  final String image;
  const PlayerWidget(
      {super.key,
      required this.typeButton,
      required this.currentPlayer,
      required this.namePlayer,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color:
                typeButton == currentPlayer ? Colors.green : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              spacing: 5,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(namePlayer),
                Icon(
                  typeButton == 'O' ? Icons.circle_outlined : Icons.close,
                  size: 25,
                  color: typeButton == 'O' ? Colors.red : Colors.blue,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
