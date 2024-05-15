import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
    required this.kelime,
    required this.onPressed,
  }) : super(key: key);

  final String kelime;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: 150, // Kartın genişliğini belirle
        height: 150, // Kartın yüksekliğini belirle
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              children: [
                // Stroked text as border.
                Center(
                  child: Text(
                    kelime.replaceAll("+", " "),
                    style: TextStyle(
                      fontSize: 20,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 6
                        ..color = const Color.fromARGB(255, 83, 25, 120),
                    ),
                  ),
                ),
                // Solid text as fill.
                Center(
                  child: Text(
                    kelime.replaceAll("+", " "),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
