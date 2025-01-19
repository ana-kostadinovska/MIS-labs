import 'package:flutter/material.dart';
import 'package:lab4/services/exam_service.dart';
import 'package:lab4/screens/create_exam.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../models/exam_model.dart';
import '../services/locator_service.dart';
import 'map.dart';

class ExamCalendar extends StatefulWidget {
  const ExamCalendar({super.key});

  @override
  State<ExamCalendar> createState() => _ExamCalendarState();
}

class _ExamCalendarState extends State<ExamCalendar> {
  late LocationMonitoringService _locationService;
  late final ValueNotifier<List<Exam>> _selectedEvents;
  late Map<DateTime, List<Exam>> _events;
  final ExamService _examService = ExamService();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _locationService = LocationMonitoringService(exams: kEvents.values.expand((e) => e).toList(), context: context);
    _locationService.startMonitoring();
    _selectedDay = _focusedDay;
    _events = {};
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    _loadStoredEvents();
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    _locationService.stopMonitoring();
    super.dispose();
  }

  List<Exam> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  Future<void> _loadStoredEvents() async {
    _events = await _examService.loadEvents();
    setState(() {
      _selectedEvents.value = _getEventsForDay(_selectedDay!);
    });
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
      _examService.addExam(exam, _events);
      _selectedEvents.value = _getEventsForDay(_selectedDay!);
    });
  }

  void _deleteExam(Exam exam) {
    setState(() {
      _examService.deleteExam(exam, _events);
      _selectedEvents.value = _getEventsForDay(_selectedDay!);
    });
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
                    exams: _events.values.expand((examList) => examList).toList(),
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
                    final exam = value[index];
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
                        title: Text(exam.name),
                        subtitle: Text(
                          '${exam.location}\n'
                              '${DateFormat.Hm().format(exam.dateTime)}',
                        ),
                        isThreeLine: true,
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteExam(exam),
                        ),
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
      latitude: 42.0045,
      longitude: 21.4105,
    ),
    Exam(
      id: '2',
      name: 'Web Programming',
      location: 'Lab 215, TMF',
      dateTime: DateTime(2025, 1, 16, 14, 0),
      latitude: 42.0039,
      longitude: 21.4093,
    ),
  ],
  DateTime(2025, 1, 17): [
    Exam(
      id: '3',
      name: 'Fundamentals of Web Design',
      location: 'Lab 138, TMF',
      dateTime: DateTime(2025, 1, 17, 11, 0),
      latitude: 42.0053,
      longitude: 21.4085,
    ),
  ],

};

final kFirstDay = DateTime(2010, 1, 1);
final kLastDay = DateTime(2025, 12, 31);
