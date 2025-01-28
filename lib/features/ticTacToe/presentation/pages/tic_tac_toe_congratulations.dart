import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:games/features/ticTacToe/data/models/tic_tac_toe_page_model.dart';
import 'package:games/features/ticTacToe/data/models/winning_player_model.dart';
import 'package:games/features/ticTacToe/presentation/pages/tic_tac_toe_home_page.dart';
import 'package:games/features/ticTacToe/presentation/pages/tic_tac_toe_page.dart';
import 'package:lottie/lottie.dart';

class TicTacToeCongratulations extends StatefulWidget {
  final TicTacToePageModel infoPlayers;
  final InfoWinningPlayerModel winningPlayer;
  const TicTacToeCongratulations(
      {super.key, required this.infoPlayers, required this.winningPlayer});

  @override
  State<TicTacToeCongratulations> createState() =>
      _TicTacToeCongratulationsState();
}

class _TicTacToeCongratulationsState extends State<TicTacToeCongratulations> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_congratulations.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Color(0x4D2631FF),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    spacing: 20,
                    children: [
                      Column(
                        children: [
                          Stack(
                            children: [
                              Lottie.asset(
                                'assets/animations/animation_confetti.json',
                              ),
                              Column(
                                spacing: 16,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height: 50,
                                        decoration: const BoxDecoration(
                                          color: Color.fromARGB(0, 165, 78, 78),
                                          image: DecorationImage(
                                            image: AssetImage(
                                              'assets/images/bg_bg_congratulations_phrase.png',
                                            ),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                            top: 5,
                                          ),
                                          child: const Text(
                                            "Parabéns",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Center(
                                    child: ClipRRect(
                                      child: Image.asset(
                                        'assets/images/trophy_congratulations.png',
                                        height: 190,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: Color(0x802631FF),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Center(
                          child: Column(
                            spacing: 16,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  widget.winningPlayer.image,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                widget.winningPlayer.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => TicTacToePage(
                                infoPlayers: widget.infoPlayers,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFECAC4C),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 12,
                          ),
                        ),
                        child: const Text(
                          'Nova partida',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final navigator = Navigator.of(context);

                          navigator.pop();
                          navigator.pop();
                          navigator.pop();

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TicTacToeHomePage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 12,
                          ),
                        ),
                        child: const Text(
                          'Recomeçar jogo',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
