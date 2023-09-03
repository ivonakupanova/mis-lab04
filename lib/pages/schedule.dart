import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/clean_calendar_event.dart';
import 'package:mis_lab4/widgets/calendar.dart';
import 'package:mis_lab4/models/exam.dart';
import 'package:mis_lab4/models/user.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key, required this.title, required this.user});

  final String title;
  final User user;

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  Map<DateTime, List<CleanCalendarEvent>> eventsDictionary = {};
  Map<String, List<Exam>> userSchedule = {};
  List<CleanCalendarEvent> events = [];
  List<Exam> examsList = [];

  @override
  void initState() {
    super.initState();
    examsList = widget.user.exams!;

    if (examsList != null) {
      _populateDictionary(examsList);
    }
  }

  Future<void> _showAddExamDialog(BuildContext context) async {
    String examTitle = '';
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Exam'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  examTitle = value;
                },
                decoration: const InputDecoration(labelText: 'Exam Title'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () async {
                  selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023, 6, 1, 8, 0, 0),
                      lastDate: DateTime(2023, 12, 31, 6, 0, 0)) as DateTime;
                },
                child: const Text('Pick Exam Date'),
              ),
              TextButton(
                onPressed: () async {
                  selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now()) as TimeOfDay;
                },
                child: const Text('Pick Time'),
              ),
            ],
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
                _addNewItemToList(Exam(
                    course: examTitle,
                    date: DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        selectedTime.hour,
                        selectedTime.minute)));
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _populateDictionary(List<Exam> examsList) {
    for (var exam in examsList) {
      if (!eventsDictionary.containsKey(exam.date)) {
        eventsDictionary[
            DateTime(exam.date.year, exam.date.month, exam.date.day)] = [];
      }
      eventsDictionary[DateTime(exam.date.year, exam.date.month, exam.date.day)]
          ?.add(CleanCalendarEvent(exam.course,
              startTime: exam.date,
              endTime: exam.date.add(const Duration(minutes: 60))));
    }
  }

  void _addNewItemToList(Exam item) {
    setState(() {
      examsList.add(item);
      _populateDictionary(examsList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_box),
              onPressed: () => _showAddExamDialog(context),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
          // constraints:
          // BoxConstraints(minHeight: MediaQuery.of(context).size.height ),
          height: 800,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text("Schedule:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.center),
                // calendar
                Flexible(
                    child: MyCalendar(ExamsMap: eventsDictionary),
                    fit: FlexFit.loose)
              ]),
        )));
  }
}
