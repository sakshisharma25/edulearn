import 'package:cloud_firestore/cloud_firestore.dart';

class AdminStudentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getStudents() async {
    final snapshot = await _firestore
        .collection('users')
        .where('role', isEqualTo: 'student')
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();
  }
}
