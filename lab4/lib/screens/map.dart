import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/exam_model.dart';
import '../services/map_service.dart';

class MapScreen extends StatefulWidget {
  final List<Exam> exams;

  const MapScreen({Key? key, required this.exams}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _currentPosition;
  List<LatLng> _routePoints = [];
  bool _isLoadingRoute = false;
  bool _isLoadingLocation = true;
  LatLng _mapCenter = LatLng(42.0047678, 21.4097791);
  final MapService _mapService = MapService();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _calculateCenterOfExams();
  }

  Future<void> _getCurrentLocation() async {
    try {
      _currentPosition = await _mapService.getCurrentLocation();
      setState(() {
        _isLoadingLocation = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to get current location: $e')),
        );
      }
    }
  }

  void _calculateCenterOfExams() {
    setState(() {
      _mapCenter = _mapService.calculateCenterOfExams(widget.exams);
    });
  }

  Future<void> _getRoute(LatLng destination) async {
    if (_currentPosition == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Current location is not available.')),
      );
      return;
    }

    setState(() {
      _routePoints = [];
      _isLoadingRoute = true;
    });

    try {
      _routePoints = await _mapService.getRoute(_currentPosition!, destination);
      setState(() {
        _isLoadingRoute = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching route: $e')),
        );
      }
      setState(() {
        _isLoadingRoute = false;
      });
    }
  }

  void _showExamDetails(BuildContext context, Exam exam) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(exam.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Location: ${exam.location}'),
              Text('Latitude: ${exam.latitude}'),
              Text('Longitude: ${exam.longitude}'),
              Text('Time: ${exam.dateTime}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await _getRoute(LatLng(exam.latitude, exam.longitude));
              },
              child: const Text('Get Route'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map Screen')),
      body: _isLoadingLocation
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
        options: MapOptions(
          center: _mapCenter,
          zoom: 15.0,
        ),
        children: [
          TileLayer(
            urlTemplate:
            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          if (_currentPosition != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: _currentPosition!,
                  builder: (ctx) => const Icon(
                    Icons.person_pin_circle,
                    color: Colors.blue,
                    size: 30.0,
                  ),
                ),
              ],
            ),
          MarkerLayer(
            markers: widget.exams.map((exam) {
              return Marker(
                point: LatLng(exam.latitude, exam.longitude),
                builder: (ctx) => GestureDetector(
                  onTap: () {
                    _showExamDetails(context, exam);
                  },
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 30.0,
                  ),
                ),
              );
            }).toList(),
          ),
          if (_routePoints.isNotEmpty)
            PolylineLayer(
              polylines: [
                Polyline(
                  points: _routePoints,
                  color: Colors.blue,
                  strokeWidth: 4.0,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
