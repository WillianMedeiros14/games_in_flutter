import 'package:flutter/material.dart';

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
