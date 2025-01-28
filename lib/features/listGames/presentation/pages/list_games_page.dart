import 'package:flutter/material.dart';
import 'package:games/features/listGames/presentation/widgets/button_list_games_widget.dart';
import 'package:games/features/ticTacToe/presentation/pages/tic_tac_toe_home_page.dart';
import 'package:games/features/ticTacToe/presentation/pages/tic_tac_toe_page.dart';
import 'package:flutter/services.dart';

class ListGamesPage extends StatefulWidget {
  const ListGamesPage({super.key});

  @override
  State<ListGamesPage> createState() => _ListGamesPageState();
}

class _ListGamesPageState extends State<ListGamesPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Todos os jogos",
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
                ButtonListGamesWidget(
                  title: "Jogo da velha",
                  pathIcon: 'assets/icons/jogo_da_velha.png',
                  onPressed: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TicTacToeHomePage(),
                      ),
                    )
                  },
                ),
                // ButtonListGamesWidget(
                //   title: "Sucuri",
                //   pathIcon: 'assets/icons/snake.png',
                //   onPressed: () => {
                //     Navigator.of(context).push(
                //       MaterialPageRoute(
                //         builder: (context) => const TicTacToeHomePage(),
                //       ),
                //     )
                //   },
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
