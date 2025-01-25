import 'package:flutter/material.dart';

class PlayerWidget extends StatelessWidget {
  final String typeButton;
  final String currentPlayer;
  final String namePlayer;
  final String image;
  const PlayerWidget({
    super.key,
    required this.typeButton,
    required this.currentPlayer,
    required this.namePlayer,
    required this.image,
  });

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
                  child: Image.asset(
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
