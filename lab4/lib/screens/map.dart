import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/exam_model.dart';

class MapScreen extends StatelessWidget {
  final List<Exam> exams;

  const MapScreen({Key? key, required this.exams}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Locations'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(41.9981, 21.4254),
          zoom: 15.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: exams.map((exam) {
              return Marker(
                point: LatLng(exam.latitude, exam.longitude),
                width: 40.0,
                height: 40.0,
                builder: (ctx) => const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 30.0,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
