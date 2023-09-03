import 'package:flutter/material.dart';
import 'package:mis_lab4/pages/schedule.dart';
import 'package:mis_lab4/models/user.dart';
import 'package:mis_lab4/models/exam.dart';

class LoginPage extends StatelessWidget {
  LoginPage({required this.title, super.key});

  String title;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Map<String, String> users = {
    'ivons123': 'mkoffice',
    'kirca': 'mkoffice',
  };

  final Map<String, List<Exam>> userExams = {
    'ivons123': [
      Exam(course: "Math", date: DateTime(2023, 9, 15)),
      Exam(course: "Statistics", date: DateTime(2023, 9, 10)),
      Exam(course: "Mobile apps", date: DateTime(2023, 9, 9)),
      Exam(course: "Web programming", date: DateTime(2023, 9, 20))
    ],
    'kirca': [
      Exam(course: "Calculus", date: DateTime(2023, 9, 7)),
      Exam(course: "Statistics", date: DateTime(2023, 9, 10)),
      Exam(course: "DevOps", date: DateTime(2023, 9, 12)),
      Exam(course: "programming", date: DateTime(2023, 9, 17))
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (users.containsKey(_usernameController.text) &&
                    users[_usernameController.text] ==
                        _passwordController.text) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SchedulePage(
                          title: "Exams schedule",
                          user: User(
                              username: _usernameController.text,
                              password: _passwordController.text,
                              exams: userExams[_usernameController.text]))));
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
