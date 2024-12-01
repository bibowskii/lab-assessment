import 'package:flutter/material.dart';
import 'package:lab_assessment_1/services/firebase_service.dart';

class EditExercisePage extends StatefulWidget {
  final String exerciseId;
  final Map<String, dynamic> exerciseData;

  EditExercisePage({required this.exerciseId, required this.exerciseData});

  @override
  _EditExercisePageState createState() => _EditExercisePageState();
}

class _EditExercisePageState extends State<EditExercisePage> {
  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _setsController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.exerciseData['name'];
    _setsController.text = widget.exerciseData['set'].toString();
    _repsController.text = widget.exerciseData['reps'].toString();
  }

  Future<void> _updateExercise() async {
    await _firestoreService.updateData(
      "exercises",
      widget.exerciseId,
      {
        'name': _nameController.text,
        'set': int.parse(_setsController.text),
        'reps': int.parse(_repsController.text),
      },
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Exercise updated successfully')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Exercise'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Exercise Name'),
            ),
            TextField(
              controller: _setsController,
              decoration: const InputDecoration(labelText: 'Sets'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _repsController,
              decoration: const InputDecoration(labelText: 'Reps'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateExercise,
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
