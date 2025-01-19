import 'dart:convert';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../models/exam_model.dart';

class MapService {
  Future<bool> handleLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  Future<LatLng?> getCurrentLocation() async {
    final hasPermission = await handleLocationPermission();
    if (!hasPermission) return null;

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      throw Exception('Failed to get current location: $e');
    }
  }

  LatLng calculateCenterOfExams(List<Exam> exams) {
    if (exams.isEmpty) return LatLng(0.0, 0.0);

    double latSum = 0;
    double lonSum = 0;

    for (var exam in exams) {
      latSum += exam.latitude;
      lonSum += exam.longitude;
    }

    final centerLat = latSum / exams.length;
    final centerLon = lonSum / exams.length;

    return LatLng(centerLat, centerLon);
  }

  Future<List<LatLng>> getRoute(LatLng currentPosition, LatLng destination) async {
    try {
      final response = await http.get(Uri.parse(
          'http://router.project-osrm.org/route/v1/driving/${currentPosition.longitude},${currentPosition.latitude};${destination.longitude},${destination.latitude}?overview=full&geometries=geojson'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> coordinates = data['routes'][0]['geometry']['coordinates'];

        return coordinates
            .map((coord) => LatLng(coord[1], coord[0]))
            .toList();
      } else {
        throw Exception('Failed to fetch route');
      }
    } catch (e) {
      throw Exception('Error fetching route: $e');
    }
  }
}
