class Exam {
  final String id;
  final String name;
  final String location;
  final DateTime dateTime;
  final double latitude;
  final double longitude;

  Exam({
    required this.id,
    required this.name,
    required this.location,
    required this.dateTime,
    required this.latitude,
    required this.longitude,
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      dateTime: DateTime.parse(json['dateTime']),
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'dateTime': dateTime.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}


