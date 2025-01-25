import 'package:flutter/material.dart';
import 'package:games/features/ticTacToe/presentation/pages/tic_tac_toe_instructions_page.dart';
import 'package:games/features/ticTacToe/presentation/pages/tic_tac_toe_match_information_page.dart';
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
      appBar: AppBar(
        title: const Text(
          "Jogo da velha",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 16,
              children: [
                ButtonOptionWidget(
                  icon: Icons.add,
                  title: "Novo jogo",
                  onPressed: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            const TicTacToeMatchInformationPage(),
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
