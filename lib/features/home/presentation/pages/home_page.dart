import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List<String?>> board = [
    [null, null, null],
    [null, null, null],
    [null, null, null],
  ];

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
        currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
      });
      displayBoardInConsole();
      winnerCheck();
    }
  }

  void displayBoardInConsole() {
    for (var row in board) {
      print(row.map((e) => e ?? 'null').join(' | '));
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
        currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
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
                            feedback: ButtonsTicTacToe(
                              typeButton: board[row][col],
                              onPressed: () {},
                            ),
                            childWhenDragging: ButtonsTicTacToe(
                              typeButton: null,
                              onPressed: () {},
                            ),
                            child: ButtonsTicTacToe(
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
              Text(
                'Jogador Atual: $currentPlayer',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
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

class WinningLinePainter extends CustomPainter {
  final List<int> line;
  WinningLinePainter(this.line);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.greenAccent
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    final start = _getOffset(line[0], size);
    final end = _getOffset(line[1], size);

    canvas.drawLine(start, end, paint);
  }

  Offset _getOffset(int index, Size size) {
    final cellWidth = size.width / 3;
    final cellHeight = size.height / 3;
    final row = index ~/ 3;
    final col = index % 3;

    return Offset(
      (col + 0.5) * cellWidth,
      (row + 0.5) * cellHeight,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class ButtonsTicTacToe extends StatelessWidget {
  final VoidCallback? onPressed;

  final String? typeButton;

  const ButtonsTicTacToe({
    super.key,
    this.typeButton,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Center(
          child: typeButton != null
              ? Icon(
                  typeButton == 'O' ? Icons.circle_outlined : Icons.close,
                  size: 45,
                  color: typeButton == 'O' ? Colors.red : Colors.blue,
                )
              : Container(),
        ),
      ),
    );
  }
}
