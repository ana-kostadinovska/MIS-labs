import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/exam_model.dart';

class ExamService {
  static const String _eventsKey = 'user_events';

  Future<Map<DateTime, List<Exam>>> loadEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final storedEvents = prefs.getString(_eventsKey);

    if (storedEvents != null) {
      final decodedEvents = jsonDecode(storedEvents) as Map<String, dynamic>;
      return decodedEvents.map((key, value) {
        final date = DateTime.parse(key);
        final exams = (value as List).map((e) => Exam.fromJson(e)).toList();
        return MapEntry(date, exams);
      });
    }
    return {};
  }

  Future<void> saveEvents(Map<DateTime, List<Exam>> events) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedEvents = events.map((key, value) {
      return MapEntry(key.toIso8601String(), value.map((e) => e.toJson()).toList());
    });
    await prefs.setString(_eventsKey, jsonEncode(encodedEvents));
  }

  Future<void> addExam(Exam exam, Map<DateTime, List<Exam>> events) async {
    final key = DateTime(exam.dateTime.year, exam.dateTime.month, exam.dateTime.day);
    if (events[key] == null) {
      events[key] = [];
    }
    events[key]!.add(exam);
    await saveEvents(events);
  }

  Future<void> deleteExam(Exam exam, Map<DateTime, List<Exam>> events) async {
    final key = DateTime(exam.dateTime.year, exam.dateTime.month, exam.dateTime.day);
    events[key]?.remove(exam);
    if (events[key]?.isEmpty ?? false) {
      events.remove(key);
    }
    await saveEvents(events);
  }
}
