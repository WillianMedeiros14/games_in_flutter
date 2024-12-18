import 'package:flutter/material.dart';
import 'package:games/features/ticTacToe/data/models/tic_tac_toe_page_model.dart';
import 'package:games/features/ticTacToe/presentation/pages/tic_tac_toe_page.dart';
import 'package:games/shared/widget/text_form_field_widget.dart';

class TicTacToeMatchInformationPage extends StatefulWidget {
  const TicTacToeMatchInformationPage({super.key});

  @override
  State<TicTacToeMatchInformationPage> createState() =>
      _TicTacToeMatchInformationPageState();
}

class _TicTacToeMatchInformationPageState
    extends State<TicTacToeMatchInformationPage> {
  final _formKey = GlobalKey<FormState>();
  final _inputNameController = TextEditingController();

  void _realTimeValidation() {
    _formKey.currentState!.validate();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Informações do jogo",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                spacing: 16,
                children: [
                  TextFormFieldWidget(
                    controller: _inputNameController,
                    labelText: 'Nome',
                    hintText: 'Insira o nome',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira o nome';
                      }
                      return null;
                    },
                    onChanged: _realTimeValidation,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      TicTacToePageModel ticTacToePageInfo = TicTacToePageModel(
                          player1: 'Wilian',
                          imagePlayer1:
                              "https://static.wikia.nocookie.net/turma-do-kamil/images/5/53/A5f7322cdf21c4de36c7e2c48c926e4c433fe5e4_hq.jpg/revision/latest?cb=20240814003202&path-prefix=pt-br",
                          player1Type: 'X',
                          player2: 'Medeiros Dev',
                          imagePlayer2:
                              'https://pm1.aminoapps.com/6716/1abc6f0137151c387ede9b594745bcc1fce21079_hq.jpg',
                          player2Type: 'O',
                          currentPlayerInit: 'O');

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TicTacToePage(
                            infoPlayers: ticTacToePageInfo,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(color: Colors.white, width: 1.5),
                      backgroundColor: const Color(0xFF021326),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                    ),
                    child: const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Iniciar o jogo',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
