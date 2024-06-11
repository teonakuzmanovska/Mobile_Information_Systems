import 'package:flutter/material.dart';
import 'package:lab3/models/Exam.dart';
import 'package:lab3/models/Location.dart' as location_model;
import 'package:lab3/screens/calendar_view.dart';
import 'package:lab3/screens/exam_list.dart';
import 'package:lab3/screens/map_view.dart';
import 'package:lab3/widgets/new_exam.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  static const String id = "homeScreen";

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final titleController = TextEditingController();

  final List<Exam> _exams = [];

  void _addNewCourse(
      String title, DateTime date, location_model.Location location) {
    final newCourse = Exam(title: title, date: date, location: location);

    setState(() {
      _exams.add(newCourse);
    });
  }

  void _startAddNewCourse(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewExam(_addNewCourse);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exams schedule'),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CalendarView(exams: _exams))),
            icon: const Icon(Icons.calendar_month),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MapView(exams: _exams))),
            icon: const Icon(Icons.map),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () => _startAddNewCourse(context),
            icon: const Icon(Icons.add),
            color: Colors.black,
          )
        ],
      ),
      body: ListView(children: [ExamList(_exams)]),
    );
  }
}
