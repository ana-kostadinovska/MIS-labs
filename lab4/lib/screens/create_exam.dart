import 'package:flutter/material.dart';
import '../models/exam_model.dart';

class CreateExam extends StatefulWidget {
  final Function(Exam) onAddExam;

  const CreateExam({super.key, required this.onAddExam});

  @override
  _CreateExamState createState() => _CreateExamState();
}

class _CreateExamState extends State<CreateExam> {
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();
  DateTime? selectedDateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Exam'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nameController,
              decoration: const InputDecoration(labelText: 'Exam Name'),
            ),
            TextField(controller: locationController,
              decoration: const InputDecoration(labelText: 'Location'),
            ),
            TextField(controller: latitudeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Latitude'),
            ),
            TextField(controller: longitudeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Longitude'),
            ),
            ListTile(
              title: const Text('Date and time'),
              subtitle: Text(
                selectedDateTime == null ? 'Select a date' : selectedDateTime!.toString(),
              ),
              onTap: _pickDateTime,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addExam,
              child: const Text('Add Exam'),
            ),
          ],
        ),
      ),
    );
  }

  void _pickDateTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, pickedTime.hour, pickedTime.minute,
          );
        });
      }
    }
  }

  void _addExam() {
    if (nameController.text.isNotEmpty &&
        locationController.text.isNotEmpty &&
        latitudeController.text.isNotEmpty &&
        longitudeController.text.isNotEmpty &&
        selectedDateTime != null) {
      final latitude = double.tryParse(latitudeController.text);
      final longitude = double.tryParse(longitudeController.text);

      if (latitude != null && longitude != null) {
        final exam = Exam(
          id: DateTime.now().toString(),
          name: nameController.text,
          location: locationController.text,
          dateTime: selectedDateTime!,
          latitude: latitude,
          longitude: longitude,
        );

        widget.onAddExam(exam);
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter valid coordinates.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
    }
  }
}
