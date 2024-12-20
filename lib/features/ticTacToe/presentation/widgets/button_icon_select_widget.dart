import 'package:flutter/material.dart';

class ButtonIconSelectInitGameWidget extends StatefulWidget {
  final TextEditingController inputCurrentPlayerInitController;
  final bool? isValidate;
  final VoidCallback onValidate;

  const ButtonIconSelectInitGameWidget({
    super.key,
    required this.inputCurrentPlayerInitController,
    required this.isValidate,
    required this.onValidate,
  });

  @override
  State<ButtonIconSelectInitGameWidget> createState() =>
      _ButtonIconSelectInitGameWidgetState();
}

class _ButtonIconSelectInitGameWidgetState
    extends State<ButtonIconSelectInitGameWidget> {
  String? _selectedIcon;

  void _onSelect(String icon) {
    setState(() {
      _selectedIcon = icon;
      widget.inputCurrentPlayerInitController.text = icon;
      widget.onValidate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6,
      children: [
        const Text(
          'Quem vai começar jogando?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ButtonSelectInitGame(
              typeIcon: 'X',
              isSelected: _selectedIcon == 'X',
              onPressed: () => _onSelect('X'),
            ),
            const SizedBox(width: 16),
            ButtonSelectInitGame(
              typeIcon: 'O',
              isSelected: _selectedIcon == 'O',
              onPressed: () => _onSelect('O'),
            ),
          ],
        ),
        if (widget.isValidate == false)
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              'Campo obrigatório',
              style: TextStyle(
                color: Color.fromARGB(255, 218, 51, 40), // Padrão: Colors.red
                fontSize: 12, // Padrão: 12sp
                fontWeight: FontWeight.normal,
                // Padrão para mensagens de erro
              ),
            ),
          )
      ],
    );
  }
}

class ButtonSelectInitGame extends StatelessWidget {
  final String typeIcon;
  final VoidCallback? onPressed;
  final bool isSelected;
  const ButtonSelectInitGame({
    super.key,
    required this.typeIcon,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            padding: const EdgeInsets.symmetric(
              vertical: 16,
            ),
          ),
          child: Icon(
            typeIcon == 'X' ? Icons.close : Icons.circle_outlined,
            size: 30,
            color: typeIcon == 'X' ? Colors.blue : Colors.red,
          ),
        ),
        if (isSelected)
          const Positioned(
            top: 0,
            right: 0,
            child: Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
          ),
      ],
    );
  }
}
