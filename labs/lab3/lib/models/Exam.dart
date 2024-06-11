// ignore: file_names
import 'package:lab3/models/Location.dart' as location_model;

class Exam {
  final String title;
  final DateTime date;
  final location_model.Location location;

  Exam({required this.title, required this.date, required this.location});
}
