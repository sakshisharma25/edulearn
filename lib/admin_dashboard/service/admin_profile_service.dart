import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminProfileService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> fetchProfile() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final doc =
        await _firestore.collection('users').doc(user.uid).get();

    return doc.data();
  }

  // 🔧 PATCH PROFILE
  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? phone,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final Map<String, dynamic> updates = {};

    if (firstName != null) updates['firstName'] = firstName;
    if (lastName != null) updates['lastName'] = lastName;
    if (phone != null) updates['phone'] = phone;

    if (updates.isEmpty) return;

    updates['updatedAt'] = FieldValue.serverTimestamp();

    await _firestore
        .collection('users')
        .doc(user.uid)
        .update(updates);
  }
}
