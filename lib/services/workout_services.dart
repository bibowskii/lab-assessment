import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_assessment_1/services/firebase_service.dart';
import 'package:lab_assessment_1/models/workout.dart'; // import the FirestoreService

class WorkoutService {
  final FirestoreService _firestoreService = FirestoreService();
  final String collection = "workouts"; // Firestore collection for workouts

  Future<void> addWorkout(workout workout) async {
    try {
      Map<String, dynamic> workoutData = {
        "name": workout.name,
        "ID": workout.ID,
        "UID": workout.UID,
        "dateTime": workout.dateTime.toIso8601String(), // Firestore stores DateTime as string
        "isDone": workout.isDone, // Set default to false (Not Done)
      };

      await _firestoreService.addData(collection, workoutData);
    } catch (e) {
      print("Error adding workout: $e");
    }
  }

  Future<void> updateWorkout(String documentId, workout workout) async {
    try {
      Map<String, dynamic> workoutData = {
        "name": workout.name,
        "ID": workout.ID,
        "UID": workout.UID,
        "dateTime": workout.dateTime.toIso8601String(),
        "isDone": workout.isDone, // Update status
      };

      // Update the workout document in Firestore
      await _firestoreService.updateData(collection, documentId, workoutData);
    } catch (e) {
      print("Error updating workout: $e");
    }
  }

  Future<void> deleteWorkout(String documentId) async {
    try {
      // Delete the workout document from Firestore
      await _firestoreService.deleteData(collection, documentId);
    } catch (e) {
      print("Error deleting workout: $e");
    }
  }
}
