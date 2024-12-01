import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_assessment_1/services/firebase_service.dart';

class User {
  String name;
  String id;
  String email;

  User({required this.name, required this.id, required this.email});

  Future<void> addUser() async {
    try {
      await FirestoreService().addData('Users', {
        'name': this.name,
        'id': this.id,
        'email': this.email,
      });
      print("User added successfully!");
    } catch (e) {
      print("Failed to add user: $e");
    }
  }
}
