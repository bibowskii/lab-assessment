import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_assessment_1/services/firebase_service.dart';
import 'package:lab_assessment_1/models/exercise.dart';

class ExerciseService {
  final FirestoreService _firestoreService = FirestoreService();
  final String collection = "exercises";  // Firestore collection for exercises

  // Add an exercise
  Future<void> addExercise(exercise exercise) async {
    try {
      Map<String, dynamic> exerciseData = {
        "name": exercise.name,
        "wID": exercise.wID,  // Workout ID to associate the exercise with a workout
        "ID": exercise.ID,
        "set": exercise.set,
        "reps": exercise.reps,
        "repsType": exercise.repsType,
        "restTime": exercise.restTime,
      };

      // Add exercise data to Firestore
      await _firestoreService.addData(collection, exerciseData);
    } catch (e) {
      print("Error adding exercise: $e");
    }
  }

  // Update an exercise
  Future<void> updateExercise(String documentId, exercise exercise) async {
    try {
      Map<String, dynamic> exerciseData = {
        "name": exercise.name,
        "wID": exercise.wID,
        "ID": exercise.ID,
        "set": exercise.set,
        "reps": exercise.reps,
        "repsType": exercise.repsType,
        "restTime": exercise.restTime,
      };

      // Update the exercise document in Firestore
      await _firestoreService.updateData(collection, documentId, exerciseData);
    } catch (e) {
      print("Error updating exercise: $e");
    }
  }

  // Delete an exercise
  Future<void> deleteExercise(String documentId) async {
    try {
      // Delete the exercise document from Firestore
      await _firestoreService.deleteData(collection, documentId);
    } catch (e) {
      print("Error deleting exercise: $e");
    }
  }
}
