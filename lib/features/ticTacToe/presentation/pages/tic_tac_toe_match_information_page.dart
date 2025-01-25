import 'package:flutter/material.dart';
import 'package:games/features/ticTacToe/data/models/player_model.dart';
import 'package:games/features/ticTacToe/data/models/tic_tac_toe_page_model.dart';
import 'package:games/features/ticTacToe/presentation/pages/tic_tac_toe_page.dart';
import 'package:games/features/ticTacToe/presentation/widgets/button_icon_select_widget.dart';
import 'package:games/shared/data/payers/list_of_local_players.dart';
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
  final _inputImagePlayer1InitController = TextEditingController();
  final _inputImagePlayer2InitController = TextEditingController();

  bool? isValidateSelectionIconInt;

  void _realTimeValidation() {
    _formKey.currentState!.validate();
    setState(() {});
  }

  void _selectIImagePlayer1(String value) {
    setState(() {
      _inputImagePlayer1InitController.text = value;
    });
  }

  void _selectIImagePlayer2(String value) {
    setState(() {
      _inputImagePlayer2InitController.text = value;
    });
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
                  inputImageController: _inputImagePlayer1InitController,
                  playerSelected: _inputImagePlayer1InitController.text,
                  onButtonPressed: _selectIImagePlayer1,
                  valuePlayerDifferent: _inputImagePlayer2InitController.text,
                ),
                SectionInfoPlayer(
                  inputNameController: _inputName2Controller,
                  realTimeValidation: _realTimeValidation,
                  typeIcon: 'O',
                  inputImageController: _inputImagePlayer2InitController,
                  playerSelected: _inputImagePlayer2InitController.text,
                  onButtonPressed: _selectIImagePlayer2,
                  valuePlayerDifferent: _inputImagePlayer1InitController.text,
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
                        imagePlayer1: _inputImagePlayer1InitController.text,
                        player1Type: 'X',
                        player2: _inputName2Controller.text,
                        imagePlayer2: _inputImagePlayer2InitController.text,
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

class SectionInfoPlayer extends StatefulWidget {
  final String typeIcon;
  final VoidCallback realTimeValidation;
  final TextEditingController inputNameController;
  final TextEditingController inputImageController;
  final String playerSelected;
  final Function(String) onButtonPressed;
  final String valuePlayerDifferent;

  const SectionInfoPlayer({
    super.key,
    required this.realTimeValidation,
    required this.inputNameController,
    required this.typeIcon,
    required this.playerSelected,
    required this.onButtonPressed,
    required this.inputImageController,
    required this.valuePlayerDifferent,
  });

  @override
  State<SectionInfoPlayer> createState() => _SectionInfoPlayerState();
}

class _SectionInfoPlayerState extends State<SectionInfoPlayer> {
  List<PlayerModel> players = [];

  @override
  void initState() {
    super.initState();

    initializeCharacters();
  }

  Future<void> initializeCharacters() async {
    final playersLocal = listOfLocalPlayers
        .map((players) => PlayerModel.fromMap(players))
        .toList();

    setState(() {
      players = playersLocal;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  widget.typeIcon == 'X' ? Icons.close : Icons.circle_outlined,
                  size: 30,
                  color: widget.typeIcon == 'X' ? Colors.blue : Colors.red,
                )
              ],
            ),
            TextFormFieldWidget(
              controller: widget.inputNameController,
              labelText: 'Nome',
              hintText: 'Nome',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Insira o nome do jogador';
                }
                return null;
              },
              onChanged: widget.realTimeValidation,
            ),
            const Text(
              'Selecione uma imagem:',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            if (players.isNotEmpty)
              SizedBox(
                height: 100,
                width: width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: players.length,
                  itemBuilder: (context, index) {
                    final player = players[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Stack(
                        children: [
                          if (widget.valuePlayerDifferent != player.image)
                            GestureDetector(
                              onTap: () {
                                widget.inputImageController.text = player.image;

                                widget.onButtonPressed(player.image);
                              },
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: Image.asset(
                                      player.image,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    player.name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else
                            Container(),
                          if (widget.playerSelected == player.image)
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.5,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                ),
                              ),
                            )
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
