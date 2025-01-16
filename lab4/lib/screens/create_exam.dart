import 'package:flutter/material.dart';
import '../models/exam_model.dart';

class CreateExam extends StatefulWidget {
  final Function(Exam) onAddExam;

  const CreateExam({super.key, required this.onAddExam});

  @override
  _CreateExamState createState() => _CreateExamState();
}

class _CreateExamState extends State<CreateExam> {
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  DateTime? _selectedDateTime;

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
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Exam Name'),
            ),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'Location'),
            ),
            ListTile(
              title: const Text('Date & Time'),
              subtitle: Text(
                _selectedDateTime == null
                    ? 'Select a date'
                    : _selectedDateTime!.toString(),
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
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  void _addExam() {
    if (_nameController.text.isNotEmpty &&
        _locationController.text.isNotEmpty &&
        _selectedDateTime != null) {
      final exam = Exam(
        id: DateTime.now().toString(),
        name: _nameController.text,
        location: _locationController.text,
        dateTime: _selectedDateTime!,
        latitude: 0.0,
        longitude: 0.0,
      );

      widget.onAddExam(exam);
      Navigator.pop(context);
    }
  }
}
