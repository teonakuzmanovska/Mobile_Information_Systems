import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:lab3/models/Exam.dart';

class CalendarView extends StatefulWidget {
  final List<Exam> exams;

  const CalendarView({super.key, required this.exams});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  @override
  Widget build(BuildContext context) {
    // Create a list of CalendarEventData from userCourses
    List<CalendarEventData> events = widget.exams.map((exam) {
      return CalendarEventData(date: exam.date, title: exam.title);
    }).toList();

    // Create an EventController
    EventController eventController = EventController();

    // Add events to the controller
    eventController.addAll(events);

    return CalendarControllerProvider(
      controller: eventController,
      child: const Scaffold(
        body: MonthView(),
      ),
    );
  }
}
