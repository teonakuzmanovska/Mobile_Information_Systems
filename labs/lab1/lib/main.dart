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
            seedColor: const Color.fromARGB(255, 9, 152, 181)),
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
  final _textController = TextEditingController();
  List<String> courses = [
    'Probability and statistics',
    'Data Science',
    'Mobile information systems'
  ];

  void addCourse(String course) {
    setState(() {
      courses.add(course);
    });
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 9, 152, 181),
        title: const Text("191523"),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Center(
                child: Text(
                  "My courses from winter semester 2023/2024:",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: courses.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      title: Text(courses[index]),
                      trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () {
                            setState(() {
                              courses.removeAt(index);
                            });
                          }));
                },
              ),
            ),
            TextField(
              controller: _textController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintText: 'Add a course',
              ),
              onSubmitted: (String value) {
                if (value.isNotEmpty) {
                  addCourse(value);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
