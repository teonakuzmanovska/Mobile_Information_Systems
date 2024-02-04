import 'package:flutter/material.dart';
import 'trousers_selection.dart';

class TopSelection extends StatefulWidget {
  final Map<String, List<String>> clothes;

  const TopSelection({Key? key, required this.clothes}) : super(key: key);

  @override
  _TopSelectionState createState() => _TopSelectionState();
}

class _TopSelectionState extends State<TopSelection> {
  Map<String, String> outfit = {'top': "", 'trousers': "", "shoes": ""};

  Widget getTextWidgets(List<String> clothings, String type) {
    return Column(
        children: clothings
            .map((item) => TextButton(
                onPressed: () {
                  setState(() {
                    outfit[type] = item;
                  });
                  print(outfit);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TrousersSelection(
                              clothes: widget.clothes, outfit: outfit)));
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
                  "Which top will you wear today?",
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 36, 83, 122)),
                )),
            getTextWidgets(widget.clothes['tops']!, "top"),
          ],
        ),
      ),
    );
  }
}
