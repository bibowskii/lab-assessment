import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;


  Future<void> addData(String collection, Map<String, dynamic> data) async {
    try {
      await _db.collection(collection).add(data);
    } catch (e) {
      print("Error adding data: $e");
    }
  }


  Future<List<Map<String, dynamic>>> getData(String collection) async {
    try {
      QuerySnapshot snapshot = await _db.collection(collection).get();
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print("Error getting data: $e");
      return [];
    }
  }


  Future<Map<String, dynamic>?> getDocument(String collection, String documentId) async {
    try {
      DocumentSnapshot doc = await _db.collection(collection).doc(documentId).get();
      return doc.exists ? doc.data() as Map<String, dynamic> : null;
    } catch (e) {
      print("Error getting document: $e");
      return null;
    }
  }


  Future<void> updateData(String collection, String documentId, Map<String, dynamic> data) async {
    try {
      await _db.collection(collection).doc(documentId).update(data);
    } catch (e) {
      print("Error updating data: ${e}");
    }
  }


  Future<void> deleteData(String collection, String documentId) async {
    try {
      await _db.collection(collection).doc(documentId).delete();
    } catch (e) {
      print("Error deleting data: $e");
    }
  }
}
