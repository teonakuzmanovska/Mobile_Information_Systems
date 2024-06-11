import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lab3/models/Location.dart' as location_model;
import 'package:lab3/widgets/map_picker.dart';

class NewExam extends StatefulWidget {
  final Function addNewExam;
  const NewExam(this.addNewExam, {super.key});

  @override
  State<NewExam> createState() => _NewExamState();
}

class _NewExamState extends State<NewExam> {
  final titleController = TextEditingController();
  DateTime date = DateTime(0);

  location_model.Location location =
      location_model.Location(coordinates: const LatLng(0, 0), address: "");

  String address = "";
  String textDate = 'Select a date: ';
  String textLocation = 'Select a location: ';

  Future<void> _presentDatePicker() async {
    final datePicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (datePicked != null) {
      final timePicked = await showTimePicker(
        context: context,
        initialTime: const TimeOfDay(hour: 0, minute: 0),
      );

      if (timePicked != null) {
        setState(() {
          date = DateTime(
            datePicked.year,
            datePicked.month,
            datePicked.day,
            timePicked.hour,
            timePicked.minute,
          );
          textDate = DateFormat.yMd().add_jm().format(date);
        });
      }
    }
  }

  Future<void> _showMapPicker() async {
    location = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MapPicker(),
      ),
    );

    if (location !=
        location_model.Location(coordinates: const LatLng(0, 0), address: "")) {
      setState(() {
        textLocation = location.address;
      });
    }
  }

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
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(textLocation),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Material(
                      elevation: 5,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      child: IconButton(
                        onPressed: () {
                          _showMapPicker();
                        },
                        icon: const Icon(
                          Icons.location_on,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if (date != DateTime(0) &&
                      titleController.text.isNotEmpty &&
                      location.coordinates != const LatLng(0, 0)) {
                    widget.addNewExam(
                      titleController.text,
                      date,
                      location,
                    );
                    titleController.clear();
                    setState(() {
                      textDate = 'Select a date:';
                      textLocation = 'Select a location:';
                      date = DateTime(0);
                      location = location_model.Location(
                          coordinates: const LatLng(0, 0), address: "");
                    });
                    Navigator.pop(context);
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
