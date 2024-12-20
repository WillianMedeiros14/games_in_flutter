import 'package:flutter/material.dart';
import 'package:games/features/ticTacToe/data/models/tic_tac_toe_page_model.dart';
import 'package:games/features/ticTacToe/presentation/pages/tic_tac_toe_page.dart';
import 'package:games/features/ticTacToe/presentation/widgets/button_icon_select_widget.dart';
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
  final _inputTypeGameController = TextEditingController();
  final _inputName1Controller = TextEditingController();
  final _inputName2Controller = TextEditingController();
  final _inputCurrentPlayerInitController = TextEditingController();

  bool? isValidateSelectionIconInt;

  void _realTimeValidation() {
    _formKey.currentState!.validate();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _inputTypeGameController.text = 'Off-line';
  }

  @override
  void dispose() {
    _inputTypeGameController.dispose();
    _inputName1Controller.dispose();
    _inputName2Controller.dispose();
    _inputCurrentPlayerInitController.dispose();
    super.dispose();
  }

  _validateSelectionIconInt() {
    setState(() {
      isValidateSelectionIconInt =
          _inputCurrentPlayerInitController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
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
        padding: const EdgeInsets.only(top: 0, right: 16, bottom: 0, left: 16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 16,
              children: [
                TextFormFieldWidget(
                  controller: _inputTypeGameController,
                  labelText: 'Tipo de jogo',
                  hintText: 'Selecione o tipo de jogo',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Selecione o tipo de jogo';
                    }
                    return null;
                  },
                  enabled: false,
                  onChanged: _realTimeValidation,
                ),
                SectionInfoPlayer(
                  inputNameController: _inputName1Controller,
                  realTimeValidation: _realTimeValidation,
                  typeIcon: 'X',
                ),
                SectionInfoPlayer(
                  inputNameController: _inputName2Controller,
                  realTimeValidation: _realTimeValidation,
                  typeIcon: 'O',
                ),
                ButtonIconSelectInitGameWidget(
                  inputCurrentPlayerInitController:
                      _inputCurrentPlayerInitController,
                  isValidate: isValidateSelectionIconInt,
                  onValidate: _validateSelectionIconInt,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        _inputCurrentPlayerInitController.text.isNotEmpty) {
                      TicTacToePageModel ticTacToePageInfo = TicTacToePageModel(
                        player1: _inputName1Controller.text,
                        imagePlayer1:
                            "https://static.wikia.nocookie.net/turma-do-kamil/images/5/53/A5f7322cdf21c4de36c7e2c48c926e4c433fe5e4_hq.jpg/revision/latest?cb=20240814003202&path-prefix=pt-br",
                        player1Type: 'X',
                        player2: _inputName2Controller.text,
                        imagePlayer2:
                            'https://pm1.aminoapps.com/6716/1abc6f0137151c387ede9b594745bcc1fce21079_hq.jpg',
                        player2Type: 'O',
                        currentPlayerInit:
                            _inputCurrentPlayerInitController.text,
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TicTacToePage(
                            infoPlayers: ticTacToePageInfo,
                          ),
                        ),
                      );
                    } else {
                      _validateSelectionIconInt();
                    }
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
                const SizedBox(
                  height: 16,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SectionInfoPlayer extends StatelessWidget {
  final String typeIcon;
  final VoidCallback realTimeValidation;
  final TextEditingController inputNameController;
  const SectionInfoPlayer(
      {super.key,
      required this.realTimeValidation,
      required this.inputNameController,
      required this.typeIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color.fromARGB(157, 201, 201, 204),
          width: 0.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Jogardor',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Icon(
                  typeIcon == 'X' ? Icons.close : Icons.circle_outlined,
                  size: 30,
                  color: typeIcon == 'X' ? Colors.blue : Colors.red,
                )
              ],
            ),
            TextFormFieldWidget(
              controller: inputNameController,
              labelText: 'Nome',
              hintText: 'Nome',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Insira o nome do jogador';
                }
                return null;
              },
              onChanged: realTimeValidation,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    "https://static.wikia.nocookie.net/turma-do-kamil/images/5/53/A5f7322cdf21c4de36c7e2c48c926e4c433fe5e4_hq.jpg/revision/latest?cb=20240814003202&path-prefix=pt-br",
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
