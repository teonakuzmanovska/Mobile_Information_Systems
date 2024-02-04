import 'package:flutter/material.dart';

class Selection extends StatefulWidget{
  final Map<String, List<String>> clothes;

  const Selection({Key? key, required this.clothes}) : super(key: key);

   @override
  _SelectionState createState() => _SelectionState();
}

class _SelectionState extends State<Selection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selection Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Clothes in Selection Page: ${widget.clothes}'),
          ],
        ),
      ),
    );
  }
}
