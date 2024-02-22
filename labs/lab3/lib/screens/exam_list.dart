import 'package:flutter/material.dart';
import 'package:lab3/models/Exam.dart';
import 'package:intl/intl.dart';

class ExamList extends StatelessWidget {
  final List<Exam> exams;

  const ExamList(this.exams, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: exams.map((course) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(10, 15, 10, 0),
          height: 100,
          child: Card(
            elevation: 5,
            child: Column(children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  course.title,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                DateFormat().format(course.date),
                style: const TextStyle(color: Colors.black45),
              )
            ]),
          ),
        );
      }).toList(),
    );
  }
}
