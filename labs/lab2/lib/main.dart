import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Labs',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 83, 153, 117)),
        scaffoldBackgroundColor: const Color.fromARGB(255, 233, 233, 233),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Labs Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> clothes = [
    'Black shirt',
    'White shirt',
    'Red shirt',
    'Leather jeans',
    'Denim jeans',
    'Office trousers',
    'Sneakers',
    'Boots',
    'High heels'
  ];

  void _showEditDialog(BuildContext context, String clothing, int index) {
    TextEditingController textEditingController =
        TextEditingController(text: clothing);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Edit Clothing'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    TextField(
                      controller: textEditingController,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      clothes[index] = textEditingController.text;
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    ).then((value) => setState(() {}));
  }

  void _showAddDialog(BuildContext context) {
    TextEditingController textEditingController =
        TextEditingController(text: " ");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Add Clothing'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    TextField(
                      controller: textEditingController,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      if (clothes.contains(textEditingController.text)) {
                        // Show error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Clothing already exists',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        clothes.add(textEditingController.text);
                      }
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    ).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 83, 153, 117),
        title: const Text(
          "191523",
          style: TextStyle(color: Color.fromARGB(255, 150, 19, 19)),
        ),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "My wardrobe",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.add),
                      color: Colors.green,
                      onPressed: () {
                        setState(() {
                          _showAddDialog(context);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: clothes.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    child: ListTile(
                        title: Text(clothes[index]),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                color: Colors.amber,
                                onPressed: () {
                                  setState(() {
                                    _showEditDialog(
                                        context, clothes[index], index);
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: () {
                                  setState(() {
                                    clothes.removeAt(index);
                                  });
                                },
                              ),
                            ],
                          ),
                        )),
                  );
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              color: Colors.blue,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
