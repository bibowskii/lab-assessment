import 'package:flutter/material.dart';
import 'package:lab_assessment_1/screens/edit_exercise_page.dart';
import 'package:lab_assessment_1/services/firebase_service.dart';

class WorkoutDetailsPage extends StatefulWidget {
  final String workoutId;

  WorkoutDetailsPage({required this.workoutId});

  @override
  _WorkoutDetailsPageState createState() => _WorkoutDetailsPageState();
}

class _WorkoutDetailsPageState extends State<WorkoutDetailsPage> {
  final FirestoreService _firestoreService = FirestoreService();
  List<Map<String, dynamic>> exercises = [];

  @override
  void initState() {
    super.initState();
    _fetchExercises();
  }

  Future<void> _fetchExercises() async {
    var data = await _firestoreService.getData("exercises");
    setState(() {
      exercises = data.where((e) => e['wID'] == widget.workoutId).toList();
    });
  }

  Future<void> _deleteExercise(String exerciseId) async {
    await _firestoreService.deleteData("exercises", exerciseId);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Exercise deleted successfully')),
    );
    _fetchExercises();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Details'),
      ),
      body: exercises.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          var exercise = exercises[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: ListTile(
              title: Text(
                exercise['name'],
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "Sets: ${exercise['set']} | Reps: ${exercise['reps']} | Rest time: ${exercise['restTime']}",
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blueAccent),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditExercisePage(
                            exerciseId: exercise['ID'],
                            exerciseData: exercise,
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () => _showDeleteConfirmationDialog(exercise['ID']),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(String exerciseId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Exercise'),
        content: const Text('Are you sure you want to delete this exercise?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteExercise(exerciseId);
            },
            child: const Text('Delete'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
        ],
      ),
    );
  }
}
