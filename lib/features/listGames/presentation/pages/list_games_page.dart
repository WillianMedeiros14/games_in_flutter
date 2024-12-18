import 'package:flutter/material.dart';
import 'package:games/features/listGames/presentation/widgets/button_list_games_widget.dart';
import 'package:games/features/ticTacToe/home/presentation/pages/tic_tac_toe_page.dart';

class ListGamesPage extends StatefulWidget {
  const ListGamesPage({super.key});

  @override
  State<ListGamesPage> createState() => _ListGamesPageState();
}

class _ListGamesPageState extends State<ListGamesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Todos os jogos",
                style: TextStyle(fontSize: 16),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ButtonListGamesWidget(
                  onPressed: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TicTacToePage(),
                      ),
                    )
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
