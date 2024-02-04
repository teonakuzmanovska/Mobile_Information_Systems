import 'package:flutter/material.dart';

class Outfit extends StatefulWidget {
  final Map<String, String> outfit;

  const Outfit({Key? key, required this.outfit}) : super(key: key);

  @override
  _OutfitState createState() => _OutfitState();
}

class _OutfitState extends State<Outfit> {
  Widget getTextWidgets() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.outfit.values
          .map((item) => Text(
                item,
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 150, 19, 19),
                ),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 113, 174, 143),
        title: const Text(
          "My wardrobe",
          style: TextStyle(
              color: Color.fromARGB(255, 150, 19, 19),
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16.0), // Adjust the value as needed
              child: Title(
                color: Color.fromARGB(255, 26, 132, 173),
                child: const Text(
                  "My outfit for today:",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 36, 83, 122),
                  ),
                ),
              ),
            ),
            getTextWidgets(),
          ],
        ),
      ),
    );
  }
}
