import 'package:flutter/material.dart';

class ButtonTicTacToe extends StatelessWidget {
  final VoidCallback? onPressed;

  final String? typeButton;

  const ButtonTicTacToe({
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
