import 'package:mis_lab4/models/exam.dart';

class User {
  User({required this.username, required this.password, required this.exams});

  String username;
  String password;
  List<Exam>? exams = [];
}
