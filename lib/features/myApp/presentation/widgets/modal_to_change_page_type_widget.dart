import 'package:flutter/material.dart';

class ModalToChangePageTypeWidget extends StatefulWidget {
  final VoidCallback onTogglePageList;
  final VoidCallback onTogglePageSlider;

  const ModalToChangePageTypeWidget({
    super.key,
    required this.onTogglePageList,
    required this.onTogglePageSlider,
  });

  @override
  State<ModalToChangePageTypeWidget> createState() =>
      _ModalToChangePageTypeWidgetState();
}

class _ModalToChangePageTypeWidgetState
    extends State<ModalToChangePageTypeWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 25, 149, 81),
        shape: CircleBorder(),
        padding: EdgeInsets.all(16),
      ),
      icon: const Icon(Icons.swap_horiz),
      color: Colors.white,
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(builder: (
              BuildContext context,
              StateSetter setState,
            ) {
              return Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text(
                        'Tipo de visualização',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Column(
                          children: <Widget>[
                            ItemMoreOptionsPageDetails(
                              onPressed: () => {
                                Navigator.pop(context),
                                widget.onTogglePageList(),
                              },
                              icon: Icons.list,
                              colorIcon: Colors.black,
                              title: 'Lista',
                            ),
                            ItemMoreOptionsPageDetails(
                              onPressed: () => {
                                Navigator.pop(context),
                                widget.onTogglePageSlider(),
                              },
                              icon: Icons.slideshow,
                              colorIcon: Colors.black,
                              title: 'Slider',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
          },
        );
      },
    );
  }
}

class ItemMoreOptionsPageDetails extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color colorIcon;
  final String title;
  const ItemMoreOptionsPageDetails({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.title,
    required this.colorIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: colorIcon,
            size: 30,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 19,
            ),
          ),
        ],
      ),
    );
  }
}
