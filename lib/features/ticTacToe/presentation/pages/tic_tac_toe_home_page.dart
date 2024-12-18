import 'package:flutter/material.dart';
import 'package:games/features/ticTacToe/presentation/pages/tic_tac_toe_instructions_page.dart';
import 'package:games/features/ticTacToe/presentation/pages/tic_tac_toe_page.dart';
import 'package:games/features/ticTacToe/presentation/widgets/button_list_games_widget.dart';

class TicTacToeHomePage extends StatefulWidget {
  const TicTacToeHomePage({super.key});

  @override
  State<TicTacToeHomePage> createState() => _TicTacToeHomePageState();
}

class _TicTacToeHomePageState extends State<TicTacToeHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 16,
              children: [
                const Text(
                  "Jogo da velha",
                  style: TextStyle(fontSize: 16),
                ),
                ButtonOptionWidget(
                  icon: Icons.add,
                  title: "Iniciar novo jogo",
                  onPressed: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TicTacToePage(),
                      ),
                    )
                  },
                ),
                ButtonOptionWidget(
                  icon: Icons.help_outline,
                  title: "Instruções",
                  onPressed: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TicTacToeInstructionsPage(),
                      ),
                    )
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
