import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab_assessment_1/services/ExerciseService.dart';  // import ExerciseService
import 'package:lab_assessment_1/services/auth_service.dart';
import 'package:lab_assessment_1/services/workout_services.dart';  // import WorkoutService
import 'package:lab_assessment_1/services/ExerciseService.dart';  // import ExerciseService
import 'package:lab_assessment_1/models/exercise.dart';
import 'package:lab_assessment_1/models/workout.dart';
import 'package:lab_assessment_1/models/user.dart';

import '../models/user.dart';
class CreateWorkoutPage extends StatefulWidget {
  @override
  _CreateWorkoutPageState createState() => _CreateWorkoutPageState();
}

class _CreateWorkoutPageState extends State<CreateWorkoutPage> {
  final WorkoutService _workoutService = WorkoutService();
  final ExerciseService _exerciseService = ExerciseService();

  // Controllers for input fields
  TextEditingController workoutNameController = TextEditingController();
  TextEditingController exerciseNameController = TextEditingController();
  TextEditingController exerciseSetController = TextEditingController();
  TextEditingController exerciseRepsController = TextEditingController();
  TextEditingController exerciseRestTimeController = TextEditingController();

  String workoutId = '';

  // Create a new workout
  void _createWorkout() async {
    String workoutName = workoutNameController.text.trim();
    if (workoutName.isNotEmpty) {
      var newWorkout = workout(
        name: workoutName,
        ID: DateTime.now().millisecondsSinceEpoch.toString(),  // Generate unique ID
        UID:'uid' ,  // Replace with actual user UID
        dateTime: DateTime.now(),
      );

      await _workoutService.addWorkout(newWorkout);
      setState(() {
        workoutId = newWorkout.ID;
      });
    }
  }

  // Create a new exercise
  void _createExercise() async {
    String exerciseName = exerciseNameController.text.trim();
    int sets = int.tryParse(exerciseSetController.text) ?? 0;
    int reps = int.tryParse(exerciseRepsController.text) ?? 0;
    int restTime = int.tryParse(exerciseRestTimeController.text) ?? 0;

    if (exerciseName.isNotEmpty) {
      var newExercise = exercise(
        name: exerciseName,
        ID: DateTime.now().millisecondsSinceEpoch.toString(),  // Generate unique ID
        wID: workoutId,
        set: sets,
        reps: reps,
        repsType: true,  // You can set this based on user input
        restTime: restTime,
      );

      await _exerciseService.addExercise(newExercise);
      // Clear the fields after adding the exercise
      exerciseNameController.clear();
      exerciseSetController.clear();
      exerciseRepsController.clear();
      exerciseRestTimeController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Workout & Exercise')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: workoutNameController,
              decoration: InputDecoration(labelText: 'Workout Name'),
            ),
            ElevatedButton(
              onPressed: _createWorkout,
              child: Text('Create Workout'),
            ),
            if (workoutId.isNotEmpty) ...[
              Text('Workout ID: $workoutId'),
              TextField(
                controller: exerciseNameController,
                decoration: InputDecoration(labelText: 'Exercise Name'),
              ),
              TextField(
                controller: exerciseSetController,
                decoration: InputDecoration(labelText: 'Sets'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: exerciseRepsController,
                decoration: InputDecoration(labelText: 'Reps'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: exerciseRestTimeController,
                decoration: InputDecoration(labelText: 'Rest Time (in seconds)'),
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                onPressed: _createExercise,
                child: Text('Add Exercise'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
