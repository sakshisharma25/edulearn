import 'package:cloud_firestore/cloud_firestore.dart';

class AdminCourseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addCourse({
    required String title,
    required String description,
    required String videoUrl,
    required String pdfUrl,
    required List<Map<String, dynamic>> mcqs,
  }) async {
    await _firestore.collection('courses').add({
      'title': title,
      'description': description,
      'videoUrl': videoUrl,
      'pdfUrl': pdfUrl,
      'mcqs': mcqs,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
