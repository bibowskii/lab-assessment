/*
import 'package:flutter/material.dart';
import 'package:lab_assessment_1/services/ExerciseService.dart';  // import ExerciseService
import 'package:lab_assessment_1/services/workout_services.dart';  // import WorkoutService
import 'workout_details_screen.dart';  // import WorkoutDetailsPage
import 'package:lab_assessment_1/services/firebase_service.dart';

class WorkoutsPage extends StatefulWidget {
  @override
  _WorkoutsPageState createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends State<WorkoutsPage> {
  final WorkoutService _workoutService = WorkoutService();

  // List to hold all workouts
  List<Map<String, dynamic>> workouts = [];

  @override
  void initState() {
    super.initState();
    _fetchWorkouts();
  }

  // Fetch all workouts from Firestore
  _fetchWorkouts() async {
    var data = await _workoutService.getData("workouts");
    setState(() {
      workouts = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Workouts')),
      body: ListView.builder(
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          var workout = workouts[index];
          return ListTile(
            title: Text(workout['name']),
            onTap: () {
              // Navigate to workout details page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WorkoutDetailsPage(workoutId: workout['ID']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
*/
