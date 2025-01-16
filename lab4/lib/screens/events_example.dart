import 'package:flutter/material.dart';
import 'package:lab4/screens/create_exam.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/exam_model.dart';
import 'map.dart';

class ExamCalendar extends StatefulWidget {
  const ExamCalendar({super.key});

  @override
  State<ExamCalendar> createState() => _ExamCalendarState();
}

class _ExamCalendarState extends State<ExamCalendar> {
  late final ValueNotifier<List<Exam>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    _loadStoredEvents();
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Exam> _getEventsForDay(DateTime day) {
    return kEvents[DateTime(day.year, day.month, day.day)] ?? [];
  }

  Future<void> _loadStoredEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final storedEvents = prefs.getString('user_events');

    if (storedEvents != null) {
      final decodedEvents = jsonDecode(storedEvents) as Map<String, dynamic>;
      decodedEvents.forEach((key, value) {
        final date = DateTime.parse(key);
        final exams = (value as List).map((e) => Exam.fromJson(e)).toList();
        kEvents[date] = exams;
      });
    }
  }

  Future<void> _saveStoredEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedEvents = kEvents.map((key, value) {
      return MapEntry(key.toIso8601String(), value.map((e) => e.toJson()).toList());
    });
    await prefs.setString('user_events', jsonEncode(encodedEvents));
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _addExam(Exam exam) {
    setState(() {
      final key = DateTime(exam.dateTime.year, exam.dateTime.month, exam.dateTime.day);
      if (kEvents[key] == null) {
        kEvents[key] = [];
      }
      kEvents[key]!.add(exam);
    });
    _saveStoredEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Calendar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateExam(onAddExam: _addExam),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapScreen(
                    exams: kEvents.values.expand((examList) => examList).toList(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TableCalendar<Exam>(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: _calendarFormat,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            onDaySelected: _onDaySelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Exam>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                if (value.isEmpty) {
                  return const Center(
                    child: Text('No exams on this day.'),
                  );
                }
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        title: Text(value[index].name),
                        subtitle: Text(
                          '${value[index].location}\n'
                              '${DateFormat.Hm().format(value[index].dateTime)}',
                        ),
                        isThreeLine: true,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

final Map<DateTime, List<Exam>> kEvents = {
  DateTime(2025, 1, 16): [
    Exam(
      id: '1',
      name: 'Databases',
      location: 'Lab 200ab, TMF',
      dateTime: DateTime(2025, 1, 16, 9, 0),
      latitude: 41.9981,
      longitude: 21.4254,
    ),
    Exam(
      id: '2',
      name: 'Web Programming',
      location: 'Lab 215, TMF',
      dateTime: DateTime(2025, 1, 16, 14, 0),
      latitude: 41.9992,
      longitude: 21.4265,
    ),
  ],
  DateTime(2025, 1, 17): [
    Exam(
      id: '3',
      name: 'Fundamentals of Web Design',
      location: 'Lab 138, TMF',
      dateTime: DateTime(2025, 1, 17, 11, 0),
      latitude: 41.9975,
      longitude: 21.4239,
    ),
  ],
};

final kFirstDay = DateTime(2010, 1, 1);
final kLastDay = DateTime(2025, 12, 31);

