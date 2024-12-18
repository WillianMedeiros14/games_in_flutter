import 'package:flutter/material.dart';

class ButtonListGamesWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const ButtonListGamesWidget({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(16)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/jogo_da_velha.png',
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 8,
          ),
          const Text(
            "Jogo da velha",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
