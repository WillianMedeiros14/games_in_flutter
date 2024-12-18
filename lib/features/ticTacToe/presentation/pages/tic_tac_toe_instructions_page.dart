import 'package:flutter/material.dart';

class TicTacToeInstructionsPage extends StatelessWidget {
  const TicTacToeInstructionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Instruções',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            InstructionRowWidget(
              title: "Objetivo do jogo:",
              description:
                  "O objetivo é ser o primeiro a formar uma linha contínua (horizontal, vertical ou diagonal) com três marcas (X ou O).",
            ),
            InstructionRowWidget(
              title: "Jogadores:",
              description:
                  "O jogo é jogado entre dois jogadores, um usando 'X' e o outro 'O'.",
            ),
            InstructionRowWidget(
              title: "Alternância de turnos:",
              description:
                  "Os jogadores se alternam para fazer um movimento até um deles vencer ou empatar.",
            ),
            InstructionRowWidget(
              title: "Informação de quem é a jogada:",
              description:
                  "Vai ficar uma borda vede sobre as informações do jogador, informando que é a vez dele jogar.",
            ),
            InstructionRowWidget(
              title: "Movimentos:",
              description:
                  "Em cada turno, o jogador deve colocar seu símbolo em uma das casas vazias no tabuleiro de 3x3.",
            ),
            InstructionRowWidget(
              title: "Movimentos após 3 jogadas:",
              description:
                  "Depois que o jogador fizer a terçeira jogada, para fazer a próxima ele deve segurar de onde ele querer tirar e arrastar para onde ele quer jogar.",
            ),
            InstructionRowWidget(
              title: "Vencedor:",
              description:
                  "O vencedor é o jogador que conseguir alinhar três símbolos consecutivos, seja na horizontal, vertical ou diagonal.",
            ),
            InstructionRowWidget(
              title: "Empate:",
              description:
                  "Se todas as casas forem preenchidas e ninguém tiver vencido, o jogo termina em empate.",
            ),
          ],
        ),
      ),
    );
  }
}

class InstructionRowWidget extends StatelessWidget {
  final String title;
  final String description;

  const InstructionRowWidget({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
