import 'package:flutter/material.dart';
import 'package:lab2/shoes_selection.dart';

class TrousersSelection extends StatefulWidget {
  final Map<String, List<String>> clothes;
  final Map<String, String> outfit;

  const TrousersSelection(
      {Key? key, required this.clothes, required this.outfit})
      : super(key: key);

  @override
  _TrousersSelectionState createState() => _TrousersSelectionState();
}

class _TrousersSelectionState extends State<TrousersSelection> {
  Widget getButtonWidgets(List<String> clothings, String type) {
    return Column(
        children: clothings
            .map((item) => TextButton(
                onPressed: () {
                  setState(() {
                    widget.outfit[type] = item;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShoesSelection(
                              clothes: widget.clothes, outfit: widget.outfit)));
                },
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 113, 174, 143),
                  minimumSize:
                      Size(double.infinity, 40), // Set the width as needed
                ),
                child: Text(item,
                    style: TextStyle(color: Color.fromARGB(255, 150, 19, 19)))))
            .toList());
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
            Title(
                color: Color.fromARGB(255, 26, 132, 173),
                child: const Text(
                  "Which trousers will you wear today?",
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 36, 83, 122)),
                )),
            getButtonWidgets(widget.clothes['trousers']!, "trousers"),
          ],
        ),
      ),
    );
  }
}
