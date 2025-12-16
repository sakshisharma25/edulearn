import 'package:cloud_firestore/cloud_firestore.dart';

class StudentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Fetch free courses
  Future<List<Map<String, dynamic>>> fetchCourses() async {
    final snapshot =
        await _firestore.collection('courses').get();

    return snapshot.docs
        .map((doc) => doc.data())
        .toList();
  }
}


class CourseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// 🔹 Fetch all courses for student
  Future<List<Map<String, dynamic>>> getCourses() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('courses').get();

      return snapshot.docs.map((doc) {
        return {
          'id': doc.id, // 🔑 courseId
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  /// 🔹 Fetch single course by ID (for course detail)
  Future<Map<String, dynamic>?> getCourseById(String courseId) async {
    try {
      final doc =
          await _firestore.collection('courses').doc(courseId).get();

      if (!doc.exists) return null;

      return {
        'id': doc.id,
        ...doc.data() as Map<String, dynamic>,
      };
    } catch (e) {
      rethrow;
    }
  }
}
