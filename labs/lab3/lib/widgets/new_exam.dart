import 'package:flutter/material.dart';

class NewExam extends StatefulWidget {
  final Function addNewExam;
  const NewExam(this.addNewExam, {super.key});

  @override
  State<NewExam> createState() => _NewExamState();
}

class _NewExamState extends State<NewExam> {
  final titleController = TextEditingController();
  DateTime date = DateTime(0);

  void _presentDatePicker() async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    ).then((datePicked) => {
          if (datePicked != null) {date = datePicked}
        });

    await showTimePicker(
        context: context,
        initialTime: const TimeOfDay(
          hour: 0,
          minute: 0,
        )).then((timePicked) => {
          if (timePicked != null)
            {
              date = DateTime(date.year, date.month, date.day, timePicked.hour,
                  timePicked.minute)
            }
        });
    setState(() {
      if (date != DateTime(0)) {
        textDate = date.toString();
      } else {
        textDate = 'Select a date:';
      }
    });
  }

  String textDate = 'Select a date:';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      child: Card(
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: titleController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(textDate),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Material(
                      elevation: 5,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      child: IconButton(
                        onPressed: () {
                          _presentDatePicker();
                        },
                        icon: const Icon(
                          Icons.calendar_month,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if (date != DateTime.now() &&
                      titleController.text.isNotEmpty) {
                    widget.addNewExam(titleController.text, date);
                    titleController.clear();
                    textDate = 'Select a date:';
                    date = DateTime(0);
                  }
                },
                child: const Text('Ok'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
