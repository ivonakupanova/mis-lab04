import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';

class MyCalendar extends StatefulWidget {
  Map<DateTime, List<CleanCalendarEvent>> ExamsMap;

  MyCalendar({super.key, required this.ExamsMap});

  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  DateTime? _selectedDay;

  List<CleanCalendarEvent>? selectedEvents;

  void _handleDate(date) {
    setState(() {
      _selectedDay = date;
      selectedEvents = widget.ExamsMap[_selectedDay] ?? [];
    });
  }

  @override
  void initState() {
    selectedEvents = widget.ExamsMap[_selectedDay] ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Calendar(
          startOnMonday: true,
          selectedColor: Colors.blue,
          todayColor: Colors.red,
          eventColor: Colors.green,
          eventDoneColor: Colors.amber,
          bottomBarColor: Colors.deepOrange,
          bottomBarArrowColor: Colors.amber,
          onDateSelected: (date) {
            return _handleDate(date);
          },
          events: widget.ExamsMap,
          isExpanded: true,
          dayOfWeekStyle: const TextStyle(
            fontSize: 15,
            color: Colors.black12,
          ),
          bottomBarTextStyle: const TextStyle(color: Colors.black),
          hideBottomBar: false,
          hideArrows: false,
          weekDays: const ['Mon', 'Tue', 'Wen', 'Thu', 'Fri', 'Sat', 'Sun'],
        ),
      ),
    );
  }
}
