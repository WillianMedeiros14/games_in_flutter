import 'package:flutter/material.dart';
import 'package:games/features/ticTacToe/data/models/player_model.dart';
import 'package:games/shared/data/payers/list_of_local_players.dart';
import 'package:games/shared/widget/text_form_field_widget.dart';

class SectionInfoPlayerWidget extends StatefulWidget {
  final String typeIcon;
  final VoidCallback realTimeValidation;
  final TextEditingController inputNameController;
  final TextEditingController inputImageController;
  final String playerSelected;
  final Function(String) onButtonPressed;
  final String valuePlayerDifferent;

  const SectionInfoPlayerWidget({
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
  State<SectionInfoPlayerWidget> createState() => _SectionInfoPlayerState();
}

class _SectionInfoPlayerState extends State<SectionInfoPlayerWidget> {
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
