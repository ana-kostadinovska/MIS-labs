import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/exam_model.dart';

class LocationMonitoringService {
  final List<Exam> exams;
  final double radius;
  final BuildContext context;
  final Set<String> notifiedExams = {};

  StreamSubscription<Position>? _positionStream;

  LocationMonitoringService({
    required this.exams,
    required this.context,
    this.radius = 100.0,
  });

  void startMonitoring() {
    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      _checkProximity(position);
    });
  }

  void stopMonitoring() {
    _positionStream?.cancel();
  }

  void _checkProximity(Position userPosition) {
    for (final exam in exams) {
      final distance = Geolocator.distanceBetween(
        userPosition.latitude,
        userPosition.longitude,
        exam.latitude,
        exam.longitude,
      );

      if (distance <= radius && !notifiedExams.contains(exam.id)) {
        _triggerReminder(exam);
        notifiedExams.add(exam.id);
      }
    }
  }

  void _triggerReminder(Exam exam) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reminder'),
          content: Text('You are near "${exam.name}".\n'
                'Time: ${exam.dateTime}',
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context),
              child: const Text('Dismiss'),
            ),
          ],
        );
      },
    );
  }
}
